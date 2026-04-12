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
    <div className="m-0 p-0 bg-slate-50 min-h-screen overflow-x-hidden">
      <style>{`
        .floating-book-button,
        .floating-menu-button,
        [class*="floating"],
        [class*="fixed"]:not(.fixed.left-0) {
          display: none !important;
          visibility: hidden !important;
          pointer-events: none !important;
        }
      `}</style>
      <div className="flex min-h-screen">
        <AdminSidebar />
        <main className="flex-1 ml-64 min-h-screen">
          <div className="bg-white border-b px-8 py-4 shadow-sm">
            <div className="flex items-center justify-between">
              <div className="text-sm text-slate-500">Admin Panel</div>
              <div className="flex items-center gap-4">
                <div className="text-sm font-medium text-slate-700">Administrator</div>
              </div>
            </div>
          </div>
          <div className="p-8">{children}</div>
        </main>
      </div>
    </div>
  )
}
