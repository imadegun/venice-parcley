import { Container } from '@/components/layout/container'
import { createServerAuthClient } from '@/lib/supabase-server'

export default async function HowToGetHerePage() {
  const supabase = await createServerAuthClient()

  // Fetch the menu item for /how-to-get-here
  const { data: menuItem } = await supabase
    .from('menu_items')
    .select('*')
    .eq('href', '/how-to-get-here')
    .eq('is_active', true)
    .single()

  const content = menuItem?.content
  const title = menuItem?.label || 'How to Get Here'

  return (
    <Container className="py-16">
      <div className="max-w-4xl mx-auto">
        <h1 className="text-4xl font-serif font-semibold text-gray-900 mb-8">
          {title}
        </h1>
        {content ? (
          <div
            className="prose prose-lg max-w-none"
            dangerouslySetInnerHTML={{ __html: content }}
          />
        ) : (
          <div className="text-center py-12">
            <p className="text-gray-500">No content has been added yet.</p>
          </div>
        )}
      </div>
    </Container>
  )
}
