import Link from 'next/link'
import { notFound } from 'next/navigation'
import { createServerAuthClient } from '@/lib/supabase-server'
import { createServerSupabaseClient } from '@/lib/supabase'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { Button } from '@/components/ui/button'
import { Container } from '@/components/layout/container'
import { CheckCircle, Calendar, Users, Euro, MapPin } from 'lucide-react'
import { format } from 'date-fns'

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

  const checkIn = booking.check_in_date ? new Date(booking.check_in_date) : null
  const checkOut = booking.check_out_date ? new Date(booking.check_out_date) : null
  const nights = checkIn && checkOut ? Math.ceil((checkOut.getTime() - checkIn.getTime()) / (1000 * 60 * 60 * 24)) : 0

  return (
    <Container spacing="xxl">
      <div className="max-w-4xl mx-auto space-y-8">
        {/* Success Header */}
        <div className="text-center space-y-4 animate-title">
          <div className="w-20 h-20 bg-green-100 rounded-full flex items-center justify-center mx-auto">
            <CheckCircle className="h-10 w-10 text-green-600" />
          </div>
          <div>
            <h1 className="text-4xl md:text-5xl font-bold text-gray-900 mb-2">Booking Confirmed!</h1>
            <p className="text-lg text-gray-600">Your reservation has been successfully processed</p>
          </div>
        </div>

        {/* Booking Details Card */}
        <Card className="shadow-lg">
          <CardHeader>
            <CardTitle className="text-2xl flex items-center gap-2">
              <MapPin className="h-6 w-6" />
              {apartmentName}
            </CardTitle>
          </CardHeader>
          <CardContent className="space-y-6">
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
              {/* Booking ID */}
              <div className="space-y-2">
                <h4 className="font-medium text-gray-900">Booking Reference</h4>
                <p className="text-sm text-gray-600 font-mono">{booking.id.slice(0, 8).toUpperCase()}</p>
              </div>

              {/* Dates */}
              <div className="space-y-2">
                <h4 className="font-medium text-gray-900 flex items-center gap-2">
                  <Calendar className="h-4 w-4" />
                  Check-in
                </h4>
                <p className="text-sm text-gray-600">
                  {checkIn ? format(checkIn, 'EEE, MMM d, yyyy') : booking.check_in_date}
                </p>
                {checkOut && (
                  <div className="mt-2">
                    <h4 className="font-medium text-gray-900">Check-out</h4>
                    <p className="text-sm text-gray-600">
                      {format(checkOut, 'EEE, MMM d, yyyy')}
                    </p>
                  </div>
                )}
                {nights > 0 && (
                  <p className="text-xs text-gray-500 mt-1">{nights} night{nights !== 1 ? 's' : ''}</p>
                )}
              </div>

              {/* Guests */}
              <div className="space-y-2">
                <h4 className="font-medium text-gray-900 flex items-center gap-2">
                  <Users className="h-4 w-4" />
                  Guests
                </h4>
                <p className="text-sm text-gray-600">{booking.total_guests || 1} guest{booking.total_guests !== 1 ? 's' : ''}</p>
              </div>

              {/* Payment */}
              <div className="space-y-2">
                <h4 className="font-medium text-gray-900 flex items-center gap-2">
                  <Euro className="h-4 w-4" />
                  Total Paid
                </h4>
                <p className="text-2xl font-bold text-green-600">€{(booking.total_cents / 100).toFixed(2)}</p>
                <p className="text-xs text-gray-500 uppercase tracking-wide">{booking.status}</p>
              </div>
            </div>

            {/* Action Buttons */}
            <div className="border-t pt-6 flex flex-col sm:flex-row gap-4 justify-center">
              <Button asChild size="lg">
                <Link href="/bookings">View My Bookings</Link>
              </Button>
              <Button asChild variant="outline" size="lg">
                <Link href="/apartments">Book Another Stay</Link>
              </Button>
            </div>
          </CardContent>
        </Card>

        {/* Additional Information */}
        <Card>
          <CardContent className="p-6">
            <div className="space-y-4">
              <h3 className="text-lg font-semibold text-gray-900">Important Information</h3>
              <div className="grid grid-cols-1 md:grid-cols-2 gap-4 text-sm text-gray-600">
                <div>
                  <h4 className="font-medium text-gray-900 mb-2">Check-in Instructions</h4>
                  <p>You will receive check-in instructions via email 24 hours before your arrival.</p>
                </div>
                <div>
                  <h4 className="font-medium text-gray-900 mb-2">Cancellation Policy</h4>
                  <p>Free cancellation up to 24 hours before check-in. See our terms for details.</p>
                </div>
              </div>
            </div>
          </CardContent>
        </Card>
      </div>
    </Container>
  )
}

