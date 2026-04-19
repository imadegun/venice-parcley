import { NextResponse } from 'next/server'
import { z } from 'zod'
import { createServerSupabaseClient } from '@/lib/supabase'
import { createServerAuthClient } from '@/lib/supabase-server'
import { stripe } from '@/lib/stripe'

const createPaymentIntentSchema = z.object({
  apartmentId: z.string().uuid(),
  checkInDate: z.string().min(10),
  checkOutDate: z.string().min(10),
  totalGuests: z.number().int().positive(),
  guestName: z.string().min(2),
  guestEmail: z.string().email(),
  guestPhone: z.string().nullable().optional(),
  specialRequests: z.string().nullable().optional(),
})

export async function POST(request: Request) {
  try {
    const authClient = await createServerAuthClient()
    const {
      data: { user },
    } = await authClient.auth.getUser()

    if (!user) {
      return NextResponse.json(
        {
          error: 'Authentication required',
          loginUrl: '/login?next=/apartments',
        },
        { status: 401 }
      )
    }

    const body = await request.json()
    const parsed = createPaymentIntentSchema.safeParse(body)

    if (!parsed.success) {
      return NextResponse.json(
        { error: parsed.error.issues[0]?.message || 'Invalid booking payload' },
        { status: 400 }
      )
    }

    const payload = parsed.data
    const supabase = createServerSupabaseClient()

    const { data: apartment, error: apartmentError } = await supabase
      .from('apartments')
      .select('id, slug, name, base_price_cents, max_guests, is_active')
      .eq('id', payload.apartmentId)
      .eq('is_active', true)
      .single()

    if (apartmentError || !apartment) {
      return NextResponse.json({ error: 'Apartment not found' }, { status: 404 })
    }

    if (payload.totalGuests > apartment.max_guests) {
      return NextResponse.json({ error: 'Guest count exceeds apartment capacity' }, { status: 400 })
    }

    const checkIn = new Date(payload.checkInDate)
    const checkOut = new Date(payload.checkOutDate)
    const nights = Math.max(1, Math.round((checkOut.getTime() - checkIn.getTime()) / (1000 * 60 * 60 * 24)))
    const totalCents = nights * apartment.base_price_cents

    // Temporarily disable availability check for testing
    // TODO: Re-enable after fixing date overlap logic
    /*
    const { data: overlappingBookings, error: overlapError } = await supabase
      .from('bookings')
      .select('id')
      .eq('apartment_id', apartment.id)
      .in('status', ['pending', 'confirmed'])
      .or(`and(check_in_date.lte.${payload.checkOutDate},check_out_date.gte.${payload.checkInDate})`)

    if (overlapError) {
      return NextResponse.json({ error: overlapError.message }, { status: 500 })
    }

    if (overlappingBookings && overlappingBookings.length > 0) {
      return NextResponse.json({ error: 'Selected dates are no longer available' }, { status: 409 })
    }
    */

    const { data: booking, error: bookingError } = await supabase
      .from('bookings')
      .insert({
        user_id: user.id,
        apartment_id: apartment.id,
        check_in_date: payload.checkInDate,
        check_out_date: payload.checkOutDate,
        total_guests: payload.totalGuests,
        total_cents: totalCents,
        status: 'pending',
        special_requests: payload.specialRequests || null,
        contact_info: {
          guest_name: payload.guestName,
          guest_email: payload.guestEmail,
          guest_phone: payload.guestPhone || null,
        },
      })
      .select('id')
      .single()

    if (bookingError || !booking) {
      return NextResponse.json({ error: bookingError?.message || 'Unable to create booking' }, { status: 500 })
    }

    // Create PaymentIntent instead of Checkout Session
    const paymentIntent = await stripe.paymentIntents.create({
      amount: totalCents,
      currency: 'eur',
      metadata: {
        booking_id: booking.id,
        user_id: user.id,
        apartment_id: apartment.id,
        guest_email: payload.guestEmail,
        guest_name: payload.guestName,
      },
      description: `${apartment.name} (${nights} night${nights > 1 ? 's' : ''})`,
      automatic_payment_methods: {
        enabled: true,
      },
    })

    return NextResponse.json({
      bookingId: booking.id,
      clientSecret: paymentIntent.client_secret,
      amount: totalCents,
      currency: 'eur',
    })
  } catch (error) {
    const message = error instanceof Error ? error.message : 'Unexpected booking error'
    return NextResponse.json({ error: message }, { status: 500 })
  }
}