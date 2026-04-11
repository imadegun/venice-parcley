import { redirect } from 'next/navigation'
import { requireRole } from '@/lib/auth'
import { AdminSidebar } from '@/components/admin/sidebar'

export default async function AdminLayout({
  children,
}: {
  children: React.ReactNode
}) {
  try {
    await requireRole(['admin', 'administrator'])
  } catch {
    redirect('/login')
  }

  return (
    <div className="min-h-screen bg-gray-50">
      <div className="flex">
        <AdminSidebar />
        <main className="flex-1 ml-64">
          <div className="p-8">
            {children}
          </div>
        </main>
      </div>
    </div>
  )
}