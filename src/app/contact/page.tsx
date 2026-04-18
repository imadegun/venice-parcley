import { createServerAuthClient } from '@/lib/supabase-server'
import { Container } from '@/components/layout/container'

export default async function ContactPage() {
  const supabase = await createServerAuthClient()

  // Fetch the menu item for /contact
  const { data: menuItem } = await supabase
    .from('menu_items')
    .select('*')
    .eq('href', '/contact')
    .eq('is_active', true)
    .single()

  const content = menuItem?.content
  const mapEmbed = menuItem?.map_embed
  const title = menuItem?.label || 'Contact Us'

  return (
    <Container spacing="xxl">
      <h1 className="text-4xl md:text-5xl font-bold text-gray-900 mb-12 animate-title">
        {title}
      </h1>

      {/* Map Section - Only show if map_embed is provided */}
      {mapEmbed && (
        <div className="mb-12 rounded-xl overflow-hidden shadow-lg animate-title-delay-1">
          <div
            className="w-full h-96"
            dangerouslySetInnerHTML={{ __html: mapEmbed }}
          />
        </div>
      )}

      {/* Content Section */}
      {content ? (
        <div
          className="text-lg text-gray-600 font-mulish leading-8 max-w-4xl animate-title-delay-2"
          dangerouslySetInnerHTML={{ __html: content }}
        />
      ) : (
        <div className="text-center py-12">
          <p className="text-gray-500">No content has been added yet.</p>
        </div>
      )}
    </Container>
  )
}
