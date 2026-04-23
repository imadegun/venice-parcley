import { createServerAuthClient } from '@/lib/supabase-server'
import { Container } from '@/components/layout/container'

export default async function AboutPage() {
  const supabase = await createServerAuthClient()

  // Fetch the menu item for /about
  const { data: menuItem } = await supabase
    .from('menu_items')
    .select('*')
    .eq('href', '/about')
    .eq('is_active', true)
    .single()

  const content = menuItem?.content?.en
  const title = menuItem?.title?.en || 'About Venice Parcley'

  return (
    <Container spacing="xxl">
      <h1 className="text-4xl md:text-5xl font-bold text-gray-900 mb-12 animate-title">
        {title}
      </h1>
      {menuItem?.image_url && (
        <div className="mb-8 animate-title-delay-1">
          <img
            src={menuItem.image_url}
            alt={title}
            className="w-full max-w-2xl mx-auto rounded-lg shadow-lg"
          />
        </div>
      )}
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
    </Container>
  )
}
