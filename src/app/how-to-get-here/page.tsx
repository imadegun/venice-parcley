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
    <Container spacing="xxl">
      <div className="max-w-4xl mx-auto">
        <h1 className="text-4xl md:text-5xl font-bold text-gray-900 mb-12 animate-title">
          {title}
        </h1>
        {content ? (
          <div
            className="text-lg text-gray-600 font-mulish leading-8 max-w-4xl animate-title-delay-1"
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
