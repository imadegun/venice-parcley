import { requireRole } from '@/lib/auth'
import { createServerSupabaseClient } from '@/lib/supabase'
import { createBooking, deleteBooking, updateBooking } from './actions'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { Input } from '@/components/ui/input'
import { Label } from '@/components/ui/label'
import { Textarea } from '@/components/ui/textarea'
import { Button } from '@/components/ui/button'

const bookingStatuses = ['pending', 'confirmed', 'cancelled', 'completed'] as const

export default async function AdminBookingsPage() {
  await requireRole(['admin', 'administrator'])
  const supabase = createServerSupabaseClient()

  const [{ data: bookings, error: bookingsError }, { data: apartments }, { data: users }] = await Promise.all([
    supabase.from('bookings').select('*').order('created_at', { ascending: false }),
    supabase.from('apartments').select('id,name').order('name', { ascending: true }),
    supabase.from('user_profiles').select('user_id,full_name').order('full_name', { ascending: true }),
  ])

  if (bookingsError) {
    throw new Error(bookingsError.message)
  }

  return (
    <div className="space-y-8">
      <div>
        <h1 className="text-3xl font-semibold text-gray-900">Bookings Management</h1>
        <p className="text-gray-600">Create, update, and delete bookings records.</p>
      </div>

      <Card>
        <CardHeader>
          <CardTitle>Create Booking</CardTitle>
        </CardHeader>
        <CardContent>
          <form action={createBooking} className="grid gap-4 md:grid-cols-2">
            <div className="space-y-2">
              <Label htmlFor="user_id">User</Label>
              <select id="user_id" name="user_id" className="h-10 w-full rounded-md border px-3" required>
                <option value="">Select user</option>
                {users?.map((user) => (
                  <option key={user.user_id} value={user.user_id}>
                    {user.full_name || user.user_id}
                  </option>
                ))}
              </select>
            </div>
            <div className="space-y-2">
              <Label htmlFor="apartment_id">Apartment</Label>
              <select id="apartment_id" name="apartment_id" className="h-10 w-full rounded-md border px-3">
                <option value="">No apartment</option>
                {apartments?.map((apt) => (
                  <option key={apt.id} value={apt.id}>
                    {apt.name}
                  </option>
                ))}
              </select>
            </div>
            <div className="space-y-2">
              <Label htmlFor="check_in_date">Check In</Label>
              <Input id="check_in_date" name="check_in_date" type="date" />
            </div>
            <div className="space-y-2">
              <Label htmlFor="check_out_date">Check Out</Label>
              <Input id="check_out_date" name="check_out_date" type="date" />
            </div>
            <div className="space-y-2">
              <Label htmlFor="total_guests">Total Guests</Label>
              <Input id="total_guests" name="total_guests" type="number" min="1" />
            </div>
            <div className="space-y-2">
              <Label htmlFor="total_cents">Total (cents)</Label>
              <Input id="total_cents" name="total_cents" type="number" min="0" required />
            </div>
            <div className="space-y-2">
              <Label htmlFor="status">Status</Label>
              <select id="status" name="status" className="h-10 w-full rounded-md border px-3" defaultValue="pending">
                {bookingStatuses.map((status) => (
                  <option key={status} value={status}>
                    {status}
                  </option>
                ))}
              </select>
            </div>
            <div className="space-y-2 md:col-span-2">
              <Label htmlFor="special_requests">Special Requests</Label>
              <Textarea id="special_requests" name="special_requests" />
            </div>
            <div className="space-y-2 md:col-span-2">
              <Label htmlFor="contact_info">Contact Info JSON</Label>
              <Textarea id="contact_info" name="contact_info" defaultValue="{}" />
            </div>
            <div className="md:col-span-2">
              <Button type="submit">Create Booking</Button>
            </div>
          </form>
        </CardContent>
      </Card>

      <div className="space-y-4">
        {bookings?.map((booking) => (
          <Card key={booking.id}>
            <CardHeader>
              <CardTitle>Booking #{booking.id.slice(0, 8)}</CardTitle>
            </CardHeader>
            <CardContent className="space-y-4">
              <form action={updateBooking} className="grid gap-4 md:grid-cols-2">
                <input type="hidden" name="id" value={booking.id} />
                <div className="space-y-2">
                  <Label>User</Label>
                  <Input name="user_id" defaultValue={booking.user_id} required />
                </div>
                <div className="space-y-2">
                  <Label>Apartment ID</Label>
                  <Input name="apartment_id" defaultValue={booking.apartment_id || ''} />
                </div>
                <div className="space-y-2">
                  <Label>Transportation ID</Label>
                  <Input name="transportation_id" defaultValue={booking.transportation_id || ''} />
                </div>
                <div className="space-y-2">
                  <Label>Check In</Label>
                  <Input name="check_in_date" type="date" defaultValue={booking.check_in_date || ''} />
                </div>
                <div className="space-y-2">
                  <Label>Check Out</Label>
                  <Input name="check_out_date" type="date" defaultValue={booking.check_out_date || ''} />
                </div>
                <div className="space-y-2">
                  <Label>Service Date</Label>
                  <Input name="service_date" type="date" defaultValue={booking.service_date || ''} />
                </div>
                <div className="space-y-2">
                  <Label>Service Time</Label>
                  <Input name="service_time" defaultValue={booking.service_time || ''} />
                </div>
                <div className="space-y-2">
                  <Label>Total Guests</Label>
                  <Input name="total_guests" type="number" min="1" defaultValue={booking.total_guests || ''} />
                </div>
                <div className="space-y-2">
                  <Label>Total (cents)</Label>
                  <Input name="total_cents" type="number" min="0" defaultValue={booking.total_cents} required />
                </div>
                <div className="space-y-2">
                  <Label>Status</Label>
                  <select name="status" defaultValue={booking.status} className="h-10 w-full rounded-md border px-3">
                    {bookingStatuses.map((status) => (
                      <option key={status} value={status}>
                        {status}
                      </option>
                    ))}
                  </select>
                </div>
                <div className="space-y-2 md:col-span-2">
                  <Label>Special Requests</Label>
                  <Textarea name="special_requests" defaultValue={booking.special_requests || ''} />
                </div>
                <div className="space-y-2 md:col-span-2">
                  <Label>Contact Info JSON</Label>
                  <Textarea name="contact_info" defaultValue={JSON.stringify(booking.contact_info || {}, null, 2)} />
                </div>
                <div className="md:col-span-2 flex gap-2">
                  <Button type="submit">Update</Button>
                </div>
              </form>

              <form action={deleteBooking}>
                <input type="hidden" name="id" value={booking.id} />
                <Button type="submit" variant="destructive">
                  Delete
                </Button>
              </form>
            </CardContent>
          </Card>
        ))}
      </div>
    </div>
  )
}
