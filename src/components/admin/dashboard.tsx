import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { Calendar, DollarSign, Users } from 'lucide-react'

interface AdminStats {
  todayBookings: number
  todayRevenue: number
  totalBookings: number
}

interface AdminDashboardProps {
  stats: AdminStats
}

export function AdminDashboard({ stats }: AdminDashboardProps) {
  return (
    <div className="grid gap-6 md:grid-cols-2 lg:grid-cols-3">
      {/* Today's Bookings */}
      <Card>
        <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
          <CardTitle className="text-sm font-medium">Today's Bookings</CardTitle>
          <Calendar className="h-4 w-4 text-muted-foreground" />
        </CardHeader>
        <CardContent>
          <div className="text-2xl font-bold">{stats.todayBookings}</div>
          <p className="text-xs text-muted-foreground">
            Confirmed bookings today
          </p>
        </CardContent>
      </Card>

      {/* Today's Revenue */}
      <Card>
        <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
          <CardTitle className="text-sm font-medium">Today's Revenue</CardTitle>
          <DollarSign className="h-4 w-4 text-muted-foreground" />
        </CardHeader>
        <CardContent>
          <div className="text-2xl font-bold">${stats.todayRevenue.toFixed(2)}</div>
          <p className="text-xs text-muted-foreground">
            Revenue from confirmed bookings
          </p>
        </CardContent>
      </Card>

      {/* Total Bookings */}
      <Card>
        <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
          <CardTitle className="text-sm font-medium">Total Bookings</CardTitle>
          <Users className="h-4 w-4 text-muted-foreground" />
        </CardHeader>
        <CardContent>
          <div className="text-2xl font-bold">{stats.totalBookings}</div>
          <p className="text-xs text-muted-foreground">
            Last 30 days
          </p>
        </CardContent>
      </Card>
    </div>
  )
}