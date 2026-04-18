import { NextResponse } from 'next/server'
import { createServerSupabaseClient } from '@/lib/supabase'
import { createServerAuthClient } from '@/lib/supabase-server'

interface RouteContext {
  params: Promise<{ id: string }>
}

export async function GET(_request: Request, context: RouteContext) {
  try {
    const { id } = await context.params

    const authClient = await createServerAuthClient()
    const {
      data: { user },
    } = await authClient.auth.getUser()

    if (!user) {
      return NextResponse.json({ error: 'Authentication required' }, { status: 401 })
    }

    const supabase = createServerSupabaseClient()
    const { data: booking, error } = await supabase
      .from('bookings')
      .select('id, user_id, apartment_id, check_in_date, check_out_date, total_guests, total_cents, status, special_requests, created_at, apartments(name)')
      .eq('id', id)
      .single()

    if (error || !booking) {
      return NextResponse.json({ error: 'Booking not found' }, { status: 404 })
    }

    if (booking.user_id !== user.id) {
      return NextResponse.json({ error: 'Forbidden' }, { status: 403 })
    }

    return NextResponse.json({ booking })
  } catch (error) {
    const message = error instanceof Error ? error.message : 'Unexpected booking lookup error'
    return NextResponse.json({ error: message }, { status: 500 })
  }
}

