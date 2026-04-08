import { redirect } from 'next/navigation'
import { Container } from '@/components/layout/container'
import { requireRole } from '@/lib/auth'
import { createServerSupabaseClient } from '@/lib/supabase'
import { AdminDashboard } from '@/components/admin/dashboard'

export default async function AdminPage() {
  try {
    await requireRole(['admin'])
  } catch {
    redirect('/login')
  }

  const supabase = createServerSupabaseClient()

  // Get dashboard stats
  const { data: bookings } = await supabase
    .from('bookings')
    .select('status, created_at, total_cents')
    .gte('created_at', new Date(Date.now() - 30 * 24 * 60 * 60 * 1000).toISOString())

  const todayBookings = bookings?.filter(booking =>
    new Date(booking.created_at).toDateString() === new Date().toDateString()
  ) || []

  const confirmedBookings = todayBookings.filter(b => b.status === 'confirmed')
  const todayRevenue = confirmedBookings.reduce((sum, b) => sum + b.total_cents, 0)

  const stats = {
    todayBookings: confirmedBookings.length,
    todayRevenue: todayRevenue / 100, // Convert cents to dollars
    totalBookings: bookings?.length || 0,
  }

  return (
    <Container className="py-8">
      <div className="max-w-6xl mx-auto">
        <h1 className="text-3xl font-bold text-gray-900 mb-8">Admin Dashboard</h1>
        <AdminDashboard stats={stats} />
      </div>
    </Container>
  )
}