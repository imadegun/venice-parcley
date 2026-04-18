import Link from 'next/link'
import { notFound } from 'next/navigation'
import { createServerAuthClient } from '@/lib/supabase-server'
import { createServerSupabaseClient } from '@/lib/supabase'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { Button } from '@/components/ui/button'

interface ConfirmationPageProps {
  params: Promise<{ id: string }>
}

export default async function BookingConfirmationPage({ params }: ConfirmationPageProps) {
  const { id } = await params
  const authClient = await createServerAuthClient()
  const {
    data: { user },
  } = await authClient.auth.getUser()

  if (!user) {
    notFound()
  }

  const supabase = createServerSupabaseClient()
  const { data: booking } = await supabase
    .from('bookings')
    .select('id, user_id, check_in_date, check_out_date, total_guests, total_cents, status, apartments(name)')
    .eq('id', id)
    .single()

  if (!booking || booking.user_id !== user.id) {
    notFound()
  }

  const apartmentName = (booking.apartments as { name?: string } | null)?.name || 'Apartment stay'

  return (
    <main className="max-w-2xl mx-auto px-4 py-10">
      <Card>
        <CardHeader>
          <CardTitle className="text-2xl">Booking Confirmation</CardTitle>
        </CardHeader>
        <CardContent className="space-y-3 text-sm text-gray-700">
          <p>
            Booking ID: <strong>{booking.id}</strong>
          </p>
          <p>
            Property: <strong>{apartmentName}</strong>
          </p>
          <p>
            Dates: <strong>{booking.check_in_date}</strong> to <strong>{booking.check_out_date}</strong>
          </p>
          <p>
            Guests: <strong>{booking.total_guests || 1}</strong>
          </p>
          <p>
            Total Paid: <strong>€{(booking.total_cents / 100).toFixed(2)}</strong>
          </p>
          <p>
            Status: <strong className="uppercase">{booking.status}</strong>
          </p>

          <div className="pt-4 flex gap-3">
            <Button asChild>
              <Link href="/bookings">View my bookings</Link>
            </Button>
            <Button asChild variant="outline">
              <Link href="/apartments">Back to apartments</Link>
            </Button>
          </div>
        </CardContent>
      </Card>
    </main>
  )
}

