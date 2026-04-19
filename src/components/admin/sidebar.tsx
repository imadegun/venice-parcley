'use client'

import Link from 'next/link'
import { usePathname } from 'next/navigation'
import {
  Home,
  Calendar,
  Users,
  Settings,
  LogOut,
  FileText
} from 'lucide-react'
import { Button } from '@/components/ui/button'
import { cn } from '@/lib/utils'

const adminNavItems = [
  {
    title: 'Dashboard',
    href: '/admin',
    icon: Home
  },
  {
    title: 'Apartments',
    href: '/admin/apartments',
    icon: Home
  },
  {
    title: 'Bookings',
    href: '/admin/bookings',
    icon: Calendar
  },
  // DISABLED: Gallery feature not ready yet
  /*
  {
    title: 'Gallery',
    href: '/admin/gallery',
    icon: Image
  },
  */
  {
    title: 'Content',
    href: '/admin/content',
    icon: FileText
  },
  {
    title: 'Users',
    href: '/admin/users',
    icon: Users,
    adminOnly: true
  },
  {
    title: 'Settings',
    href: '/admin/settings',
    icon: Settings
  }
]

export function AdminSidebar() {
  const pathname = usePathname()

  const handleLogout = async () => {
    // TODO: Implement logout
    window.location.href = '/'
  }

  return (
    <div className="fixed left-0 top-0 z-40 h-screen w-64 bg-white shadow-lg border-r">
      <div className="flex h-full flex-col">
        {/* Logo */}
        <div className="flex h-16 items-center border-b px-6">
          <Link href="/" className="flex items-center space-x-2">
            <div className="h-8 w-8 rounded-full bg-gradient-to-r from-blue-500 to-teal-500"></div>
            <span className="text-lg font-bold text-gray-900 font-yellowtail">Venice Parcley</span>
          </Link>
        </div>

        {/* Navigation */}
        <nav className="flex-1 space-y-1 p-4">
          {adminNavItems.map((item) => {
            const Icon = item.icon
            const isActive = pathname === item.href

            return (
              <Link key={item.href} href={item.href}>
                <Button
                  variant={isActive ? "secondary" : "ghost"}
                  className={cn(
                    "w-full justify-start",
                    isActive && "bg-blue-50 text-blue-700 hover:bg-blue-100"
                  )}
                >
                  <Icon className="mr-3 h-4 w-4" />
                  {item.title}
                </Button>
              </Link>
            )
          })}
        </nav>

        {/* Logout */}
        <div className="border-t p-4">
          <Button
            variant="ghost"
            className="w-full justify-start text-red-600 hover:text-red-700 hover:bg-red-50"
            onClick={handleLogout}
          >
            <LogOut className="mr-3 h-4 w-4" />
            Logout
          </Button>
        </div>
      </div>
    </div>
  )
}