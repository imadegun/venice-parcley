import { requireRole } from '@/lib/auth'

export default async function AdminSettingsPage() {
  await requireRole(['admin', 'administrator'])

  return (
    <div className="space-y-3">
      <h1 className="text-3xl font-semibold text-gray-900">Settings</h1>
      <p className="text-gray-600">Admin settings module is being prepared.</p>
    </div>
  )
}
