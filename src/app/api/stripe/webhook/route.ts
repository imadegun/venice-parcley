import { NextResponse } from 'next/server'
import Stripe from 'stripe'
import { stripe } from '@/lib/stripe'
import { createServerSupabaseClient } from '@/lib/supabase'

export async function POST(request: Request) {
  const signature = request.headers.get('stripe-signature')
  const webhookSecret = process.env.STRIPE_WEBHOOK_SECRET

  if (!signature || !webhookSecret) {
    return NextResponse.json({ error: 'Missing Stripe webhook configuration' }, { status: 400 })
  }

  const payload = await request.text()

  let event: Stripe.Event
  try {
    event = stripe.webhooks.constructEvent(payload, signature, webhookSecret)
  } catch (error) {
    const message = error instanceof Error ? error.message : 'Invalid webhook signature'
    return NextResponse.json({ error: message }, { status: 400 })
  }

  try {
    if (event.type === 'payment_intent.succeeded') {
      const paymentIntent = event.data.object as Stripe.PaymentIntent
      const bookingId = paymentIntent.metadata?.booking_id

      if (bookingId) {
        const supabase = createServerSupabaseClient()
        const { error } = await supabase
          .from('bookings')
          .update({
            status: 'confirmed',
            updated_at: new Date().toISOString(),
          })
          .eq('id', bookingId)
          .eq('status', 'pending')

        if (error) {
          console.error('Error updating booking status:', error)
          throw error
        }

        console.log(`Booking ${bookingId} confirmed with payment ${paymentIntent.id}`)
      }
    }

    if (event.type === 'payment_intent.payment_failed') {
      const paymentIntent = event.data.object as Stripe.PaymentIntent
      const bookingId = paymentIntent.metadata?.booking_id

      if (bookingId) {
        const supabase = createServerSupabaseClient()
        await supabase
          .from('bookings')
          .update({
            status: 'cancelled',
            contact_info: {
              stripe_payment_intent_id: paymentIntent.id,
              payment_failed: true,
            },
          })
          .eq('id', bookingId)
          .eq('status', 'pending')
      }
    }

    return NextResponse.json({ received: true })
  } catch (error) {
    const message = error instanceof Error ? error.message : 'Webhook processing error'
    return NextResponse.json({ error: message }, { status: 500 })
  }
}

