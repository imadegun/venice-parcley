
import { requireRole, getUserRole } from '@/lib/auth'
import { createServerSupabaseClient } from '@/lib/supabase'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { Badge } from '@/components/ui/badge'
import { Home, Calendar, Users, Image } from 'lucide-react'

export default async function AdminDashboard() {
  const user = await requireRole(['admin', 'administrator'])
  const userRole = await getUserRole(user.id)

  const supabase = createServerSupabaseClient()

  // Get dashboard stats
  const [
    { count: totalApartments },
    { count: totalBookings },
    { count: pendingBookings },
    { count: totalUsers }
  ] = await Promise.all([
    supabase.from('apartments').select('*', { count: 'exact', head: true }),
    supabase.from('bookings').select('*', { count: 'exact', head: true }),
    supabase.from('bookings').select('*', { count: 'exact', head: true }).eq('status', 'pending'),
    supabase.from('user_profiles').select('*', { count: 'exact', head: true })
  ])

  const stats = [
    {
      title: 'Total Apartments',
      value: totalApartments || 0,
      icon: Home,
      color: 'text-blue-600'
    },
    {
      title: 'Total Bookings',
      value: totalBookings || 0,
      icon: Calendar,
      color: 'text-green-600'
    },
    {
      title: 'Pending Bookings',
      value: pendingBookings || 0,
      icon: Calendar,
      color: 'text-orange-600'
    },
    {
      title: 'Total Users',
      value: totalUsers || 0,
      icon: Users,
      color: 'text-purple-600',
      adminOnly: true
    }
  ]

  return (
    <div className="space-y-8">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold text-gray-900">Admin Dashboard</h1>
          <p className="text-gray-600 mt-2">
            Welcome back! Here's an overview of your Venice Parcley platform.
          </p>
        </div>
        <Badge variant={userRole === 'administrator' ? 'default' : 'secondary'}>
          {userRole === 'administrator' ? 'Administrator' : 'Admin'}
        </Badge>
      </div>

      {/* Stats Grid */}
      <div className="grid gap-6 md:grid-cols-2 lg:grid-cols-4">
        {stats
          .filter(stat => !stat.adminOnly || userRole === 'administrator')
          .map((stat) => {
            const Icon = stat.icon
            return (
              <Card key={stat.title}>
                <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
                  <CardTitle className="text-sm font-medium">{stat.title}</CardTitle>
                  <Icon className={`h-4 w-4 ${stat.color}`} />
                </CardHeader>
                <CardContent>
                  <div className="text-2xl font-bold">{stat.value}</div>
                </CardContent>
              </Card>
            )
          })}
      </div>

      {/* Quick Actions */}
      <div className="grid gap-6 md:grid-cols-2">
        <Card>
          <CardHeader>
            <CardTitle>Quick Actions</CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <div className="grid gap-3">
              <a
                href="/admin/apartments"
                className="flex items-center justify-between p-3 border rounded-lg hover:bg-gray-50 transition-colors"
              >
                <div className="flex items-center gap-3">
                  <Home className="h-5 w-5 text-blue-600" />
                  <span>Manage Apartments</span>
                </div>
                <span className="text-sm text-gray-500">→</span>
              </a>

              <a
                href="/admin/bookings"
                className="flex items-center justify-between p-3 border rounded-lg hover:bg-gray-50 transition-colors"
              >
                <div className="flex items-center gap-3">
                  <Calendar className="h-5 w-5 text-green-600" />
                  <span>Manage Bookings</span>
                </div>
                <span className="text-sm text-gray-500">→</span>
              </a>

              {/* <a
                href="/admin/gallery"
                className="flex items-center justify-between p-3 border rounded-lg hover:bg-gray-50 transition-colors"
              >
                <div className="flex items-center gap-3">
                  <Image className="h-5 w-5 text-purple-600" />
                  <span>Manage Gallery</span>
                </div>
                <span className="text-sm text-gray-500">→</span>
              </a> */}
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>Recent Activity</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="text-center py-8 text-gray-500">
              <p>No recent activity to display.</p>
              <p className="text-sm mt-1">Activity will appear here as users interact with the platform.</p>
            </div>
          </CardContent>
        </Card>
      </div>
    </div>
  )
}