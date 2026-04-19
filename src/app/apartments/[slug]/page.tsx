import Image from 'next/image'
import { notFound } from 'next/navigation'
import { MapPin, Users, Bed } from 'lucide-react'
import { Badge } from '@/components/ui/badge'
import { createServerSupabaseClient } from '@/lib/supabase'
import { AnimatedGallery } from '@/components/apartments/animated-gallery'
import { Container } from '@/components/layout/container'
import { EmbeddedBookingFlow } from '@/components/booking/embedded-booking-flow'

interface ApartmentDetail {
  id: string
  slug: string
  name: string
  description: string
  short_description: string | null
  base_price_cents: number
  max_guests: number
  bedrooms: number
  amenities: string[] | null
  gallery_images: string[] | null
  image_url: string | null
  is_active: boolean
}

interface ApartmentDetailPageProps {
  params: Promise<{ slug: string }>
}

export default async function ApartmentDetailPage({ params }: ApartmentDetailPageProps) {
  const { slug } = await params
  const supabase = createServerSupabaseClient()

  const { data, error } = await supabase
    .from('apartments')
    .select('id, slug, name, description, short_description, base_price_cents, max_guests, bedrooms, amenities, gallery_images, image_url, is_active')
    .eq('slug', slug)
    .eq('is_active', true)
    .single()

  if (error || !data) {
    notFound()
  }

  const apartment = data as ApartmentDetail
  const gallery = apartment.gallery_images?.length
    ? apartment.gallery_images
    : apartment.image_url
      ? [apartment.image_url]
      : []

  return (
    <Container spacing="xxl">
      <div className="max-w-4xl mx-auto space-y-10">
        <div className="space-y-3">
          <h1 className="text-4xl md:text-5xl font-bold text-gray-900 mb-4 animate-title">{apartment.name}</h1>
          <p className="text-lg text-gray-600 font-mulish leading-8 max-w-4xl animate-title-delay-1">
            {apartment.short_description || 'Artful stay designed for comfort and inspiration.'}
          </p>
          <div className="flex flex-wrap items-center gap-4 text-sm text-gray-600 font-mulish animate-title-delay-2">
            <span className="inline-flex items-center gap-2"><Users className="h-4 w-4" /> {apartment.max_guests} guests</span>
            <span className="inline-flex items-center gap-2"><Bed className="h-4 w-4" /> {apartment.bedrooms} bedrooms</span>
            <span className="inline-flex items-center gap-2"><MapPin className="h-4 w-4" /> Venice, Italy</span>
          </div>
        </div>

        {gallery.length > 0 ? (
          <AnimatedGallery images={gallery} title={apartment.name} />
        ) : (
          <div className="relative h-80 w-full rounded-lg bg-gradient-to-br from-blue-100 to-teal-100 overflow-hidden">
            <div className="h-full w-full flex items-center justify-center">
              <MapPin className="h-14 w-14 text-blue-400" />
            </div>
            {apartment.image_url && (
              <Image src={apartment.image_url} alt={apartment.name} fill className="object-cover" />
            )}
          </div>
        )}

        <div className="grid gap-8 lg:grid-cols-3">
          <section className="lg:col-span-2 space-y-4">
            <h2 className="text-2xl md:text-3xl font-bold text-gray-900 mb-4 animate-title">About this apartment</h2>
            <p className="text-lg text-gray-600 font-mulish leading-8 whitespace-pre-line">{apartment.description}</p>
          </section>

          <aside className="rounded-lg border border-gray-200 p-6 h-fit space-y-4">
            <p className="text-sm text-gray-500">Starting from</p>
            <p className="text-3xl font-bold text-gray-900">€{(apartment.base_price_cents / 100).toFixed(0)}</p>
            <p className="text-sm text-gray-500">per night</p>
          </aside>
        </div>

        {(apartment.amenities?.length || 0) > 0 && (
          <section className="space-y-3">
            <h2 className="text-2xl md:text-3xl font-bold text-gray-900 mb-4 animate-title-delay-1">Amenities</h2>
            <div className="flex flex-wrap gap-2">
              {apartment.amenities?.map((amenity) => (
                <Badge key={amenity} variant="secondary">{amenity}</Badge>
              ))}
            </div>
          </section>
        )}

        <section className="space-y-4">
          <h2 className="text-2xl md:text-3xl font-bold text-gray-900">Book this apartment</h2>
          <EmbeddedBookingFlow apartmentId={apartment.id} />
        </section>
      </div>
    </Container>
  )
}
