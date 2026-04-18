import { createServerAuthClient } from '@/lib/supabase-server'

export default async function AboutPage() {
  const supabase = await createServerAuthClient()

  // Fetch the menu item for /about
  const { data: menuItem } = await supabase
    .from('menu_items')
    .select('*')
    .eq('href', '/about')
    .eq('is_active', true)
    .single()

  const content = menuItem?.content
  const title = menuItem?.label || 'About Venice Parcley'

  return (
    <div className="container mx-auto px-4 py-8">
      <h1 className="text-4xl font-bold text-gray-900 mb-8">{title}</h1>
      {content ? (
        <div
          className="prose max-w-none"
          dangerouslySetInnerHTML={{ __html: content }}
        />
      ) : (
        <div className="text-center py-12">
          <p className="text-gray-500">No content has been added yet.</p>
        </div>
      )}
    </div>
  )
}
