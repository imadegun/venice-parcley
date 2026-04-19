import { requireRole } from '@/lib/auth'
import { createServerSupabaseClient } from '@/lib/supabase'
import { updateBookingStatus } from './actions'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { Button } from '@/components/ui/button'
import { Badge } from '@/components/ui/badge'

import { Calendar, Users, Euro, MapPin, Mail, Phone, Clock, CheckCircle, XCircle, AlertCircle, User } from 'lucide-react'
import { format } from 'date-fns'

const statusConfig = {
  pending: { color: 'bg-yellow-100 text-yellow-800 border-yellow-200', icon: Clock },
  confirmed: { color: 'bg-green-100 text-green-800 border-green-200', icon: CheckCircle },
  cancelled: { color: 'bg-red-100 text-red-800 border-red-200', icon: XCircle },
  completed: { color: 'bg-blue-100 text-blue-800 border-blue-200', icon: CheckCircle },
}

export default async function AdminBookingsPage() {
  await requireRole(['admin', 'administrator'])
  const supabase = createServerSupabaseClient()

  const { data: bookings, error } = await supabase
    .from('bookings')
    .select(`
      *,
      apartments:apartment_id (
        id,
        name,
        slug,
        base_price_cents
      )
    `)
    .order('created_at', { ascending: false })

  if (error) {
    throw new Error(error.message)
  }

  const stats = {
    total: bookings?.length || 0,
    pending: bookings?.filter(b => b.status === 'pending').length || 0,
    confirmed: bookings?.filter(b => b.status === 'confirmed').length || 0,
    cancelled: bookings?.filter(b => b.status === 'cancelled').length || 0,
    completed: bookings?.filter(b => b.status === 'completed').length || 0,
  }

  const totalRevenue = bookings?.reduce((sum, booking) => {
    if (booking.status === 'confirmed' || booking.status === 'completed') {
      return sum + (booking.total_cents || 0)
    }
    return sum
  }, 0) || 0

  return (
    <div className="space-y-8 py-8">
      {/* Header */}
      <div className="animate-title">
        <h1 className="text-3xl font-semibold text-gray-900">Booking Management</h1>
        <p className="text-gray-600">Professional hotel booking administration</p>
      </div>

      {/* Stats Cards */}
      <div className="grid grid-cols-2 md:grid-cols-4 lg:grid-cols-6 gap-4">
        <Card>
          <CardContent className="p-4">
            <div className="flex items-center gap-2">
              <Calendar className="h-5 w-5 text-blue-600" />
              <div>
                <p className="text-2xl font-bold">{stats.total}</p>
                <p className="text-xs text-gray-600">Total Bookings</p>
              </div>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardContent className="p-4">
            <div className="flex items-center gap-2">
              <Clock className="h-5 w-5 text-yellow-600" />
              <div>
                <p className="text-2xl font-bold">{stats.pending}</p>
                <p className="text-xs text-gray-600">Pending</p>
              </div>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardContent className="p-4">
            <div className="flex items-center gap-2">
              <CheckCircle className="h-5 w-5 text-green-600" />
              <div>
                <p className="text-2xl font-bold">{stats.confirmed}</p>
                <p className="text-xs text-gray-600">Confirmed</p>
              </div>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardContent className="p-4">
            <div className="flex items-center gap-2">
              <XCircle className="h-5 w-5 text-red-600" />
              <div>
                <p className="text-2xl font-bold">{stats.cancelled}</p>
                <p className="text-xs text-gray-600">Cancelled</p>
              </div>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardContent className="p-4">
            <div className="flex items-center gap-2">
              <CheckCircle className="h-5 w-5 text-blue-600" />
              <div>
                <p className="text-2xl font-bold">{stats.completed}</p>
                <p className="text-xs text-gray-600">Completed</p>
              </div>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardContent className="p-4">
            <div className="flex items-center gap-2">
              <Euro className="h-5 w-5 text-green-600" />
              <div>
                <p className="text-2xl font-bold">€{(totalRevenue / 100).toFixed(0)}</p>
                <p className="text-xs text-gray-600">Revenue</p>
              </div>
            </div>
          </CardContent>
        </Card>
      </div>

      {/* Bookings List */}
      <div className="space-y-4">
        {bookings?.map((booking) => {
          const StatusIcon = statusConfig[booking.status as keyof typeof statusConfig]?.icon || AlertCircle
          const statusStyle = statusConfig[booking.status as keyof typeof statusConfig] || statusConfig.pending

          const checkIn = booking.check_in_date ? new Date(booking.check_in_date) : null
          const checkOut = booking.check_out_date ? new Date(booking.check_out_date) : null
          const nights = checkIn && checkOut ? Math.ceil((checkOut.getTime() - checkIn.getTime()) / (1000 * 60 * 60 * 24)) : 0

          return (
            <Card key={booking.id} className="hover:shadow-md transition-shadow">
              <CardHeader className="pb-3">
                <div className="flex items-start justify-between">
                  <div className="space-y-1">
                    <CardTitle className="text-lg">
                      Booking #{booking.id.slice(0, 8).toUpperCase()}
                    </CardTitle>
                    <div className="flex items-center gap-4 text-sm text-gray-600">
                      <span className="flex items-center gap-1">
                        <User className="h-4 w-4" />
                        {booking.contact_info?.guest_name || 'Guest'}
                      </span>
                      <span className="flex items-center gap-1">
                        <Calendar className="h-4 w-4" />
                        {checkIn ? format(checkIn, 'MMM d, yyyy') : 'TBD'}
                        {checkOut && ` - ${format(checkOut, 'MMM d, yyyy')}`}
                      </span>
                      {nights > 0 && (
                        <span className="flex items-center gap-1">
                          <Clock className="h-4 w-4" />
                          {nights} night{nights !== 1 ? 's' : ''}
                        </span>
                      )}
                    </div>
                  </div>

                  <div className="flex items-center gap-3">
                    <Badge className={`${statusStyle.color} border`}>
                      <StatusIcon className="h-3 w-3 mr-1" />
                      {booking.status.charAt(0).toUpperCase() + booking.status.slice(1)}
                    </Badge>

                    <form action={updateBookingStatus} className="flex items-center gap-2">
                      <input type="hidden" name="bookingId" value={booking.id} />
                      <select
                        key={`status-${booking.id}-${booking.status}-${booking.updated_at}`}
                        name="status"
                        defaultValue={booking.status}
                        className="h-9 w-32 rounded-md border border-input bg-transparent px-3 py-1 text-sm shadow-sm transition-colors focus-visible:outline-none focus-visible:ring-1 focus-visible:ring-ring disabled:cursor-not-allowed disabled:opacity-50"
                      >
                        <option value="pending">Pending</option>
                        <option value="confirmed">Confirmed</option>
                        <option value="cancelled">Cancelled</option>
                        <option value="completed">Completed</option>
                      </select>
                      <Button type="submit" size="sm">Update</Button>
                    </form>
                  </div>
                </div>
              </CardHeader>

              <CardContent className="space-y-4">
                <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
                  {/* Apartment Info */}
                  <div className="space-y-2">
                    <h4 className="font-medium text-gray-900 flex items-center gap-2">
                      <MapPin className="h-4 w-4" />
                      Apartment
                    </h4>
                    <p className="text-sm text-gray-600">
                      {booking.apartments?.name || 'Not assigned'}
                    </p>
                  </div>

                  {/* Guest Info */}
                  <div className="space-y-2">
                    <h4 className="font-medium text-gray-900 flex items-center gap-2">
                      <Users className="h-4 w-4" />
                      Guests & Contact
                    </h4>
                    <div className="space-y-1 text-sm text-gray-600">
                      <p>{booking.total_guests || 1} guest{booking.total_guests !== 1 ? 's' : ''}</p>
                      {booking.contact_info?.guest_email && (
                        <p className="flex items-center gap-1">
                          <Mail className="h-3 w-3" />
                          {booking.contact_info.guest_email}
                        </p>
                      )}
                      {booking.contact_info?.guest_phone && (
                        <p className="flex items-center gap-1">
                          <Phone className="h-3 w-3" />
                          {booking.contact_info.guest_phone}
                        </p>
                      )}
                    </div>
                  </div>

                  {/* Pricing */}
                  <div className="space-y-2">
                    <h4 className="font-medium text-gray-900 flex items-center gap-2">
                      <Euro className="h-4 w-4" />
                      Pricing
                    </h4>
                    <div className="text-sm">
                      <p className="font-medium text-lg">€{(booking.total_cents / 100).toFixed(2)}</p>
                      {nights > 0 && booking.apartments?.base_price_cents && (
                        <p className="text-gray-600">
                          €{(booking.apartments.base_price_cents / 100).toFixed(0)}/night × {nights}
                        </p>
                      )}
                    </div>
                  </div>

                  {/* Booking Details */}
                  <div className="space-y-2">
                    <h4 className="font-medium text-gray-900">Details</h4>
                    <div className="text-sm text-gray-600 space-y-1">
                      <p>Created: {format(new Date(booking.created_at), 'MMM d, yyyy')}</p>
                      {booking.updated_at !== booking.created_at && (
                        <p>Updated: {format(new Date(booking.updated_at), 'MMM d, yyyy')}</p>
                      )}
                      {booking.special_requests && (
                        <div className="mt-2">
                          <p className="font-medium text-gray-900">Special Requests:</p>
                          <p className="text-xs">{booking.special_requests}</p>
                        </div>
                      )}
                    </div>
                  </div>
                </div>
              </CardContent>
            </Card>
          )
        })}

        {(!bookings || bookings.length === 0) && (
          <Card>
            <CardContent className="py-12 text-center">
              <Calendar className="h-12 w-12 text-gray-400 mx-auto mb-4" />
              <h3 className="text-lg font-medium text-gray-900 mb-2">No bookings yet</h3>
              <p className="text-gray-600">Bookings will appear here once guests start making reservations.</p>
            </CardContent>
          </Card>
        )}
      </div>
    </div>
  )
}
