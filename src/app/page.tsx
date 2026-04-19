export const dynamic = 'force-dynamic'
export const revalidate = 0

import Link from "next/link"
import Image from "next/image"
import { Button } from "@/components/ui/button"
import { HeroSection } from "@/components/hero/hero-section"
import { PhotoGallery } from "@/components/gallery/photo-gallery"
import { ArrowRight, MapPin, Star, Users } from "lucide-react"
import { getHomepageContent } from "@/lib/content"
import { createServerSupabaseClient } from "@/lib/supabase"
import { ScrollReveal } from "@/components/animations/scroll-reveal"
import type { HeroContent } from "@/lib/content"

interface FrontendApartment {
  id: string
  slug: string
  name: string
  short_description: string | null
  base_price_cents: number
  max_guests: number
  bedrooms: number
  gallery_images: string[] | null
  image_url: string | null
  is_active: boolean
}

export default async function Home() {
  const homepageContent = await getHomepageContent()
  console.log('🔍 Home page: homepageContent:', JSON.stringify(homepageContent, null, 2))
  console.log('🔍 Home page: intro section:', JSON.stringify(homepageContent.intro, null, 2))

  const supabase = createServerSupabaseClient()

  // Get current language (simplified - you may want to implement proper i18n detection)
  const currentLang = 'en' as 'en' | 'it' // TODO: Implement proper language detection
  const { data: featuredApartments } = await supabase
    .from('apartments')
    .select('id, slug, name, short_description, base_price_cents, max_guests, bedrooms, gallery_images, image_url, is_active')
    .eq('is_active', true)
    .order('created_at', { ascending: false })
    .limit(3)

  const { data: heroApartments } = await supabase
    .from('apartments')
    .select('gallery_images, image_url')
    .eq('is_active', true)
    .order('created_at', { ascending: false })

  const heroImages = Array.from(
    new Set(
      (heroApartments || []).flatMap((apartment) => {
        const gallery = Array.isArray(apartment.gallery_images) ? apartment.gallery_images : []
        if (gallery.length > 0) return gallery
        return apartment.image_url ? [apartment.image_url] : []
      }).filter(Boolean)
    )
  )

  const heroContent: HeroContent = {
    ...homepageContent.hero,
    backgroundImages: heroImages.length > 0
      ? heroImages
      : homepageContent.hero.backgroundImages,
  }

  return (
    <div className="min-h-screen pb-24 md:pb-0">
      {/* Hero Section */}
      <HeroSection heroContentData={heroContent} />

      {/* Mobile Intro Copy */}
      <ScrollReveal direction="up" duration={1000} delay={0}>
        <section className="py-12 bg-white">
          <div className="container mx-auto px-4">
            <div className="mx-auto max-w-3xl text-center">
              <p className="text-xs md:text-sm uppercase tracking-[0.28em] text-gray-600 font-montserrat mb-4">
                {homepageContent.intro?.tagline?.[currentLang] ?? homepageContent.intro?.tagline?.en ?? ''}
              </p>
              <h1 className="text-4xl md:text-5xl font-bold text-gray-900 mb-6 font-josefin">
                {homepageContent.intro?.title?.[currentLang] ?? homepageContent.intro?.title?.en ?? ''}
              </h1>
              <div className="mx-auto mb-8 h-[2px] w-24 bg-gradient-to-r from-transparent via-gray-400 to-transparent" />
              <p className="text-lg text-gray-600 font-mulish leading-8 max-w-2xl mx-auto px-4 md:px-0">
                {homepageContent.intro?.description?.[currentLang] ?? homepageContent.intro?.description?.en ?? ''}
              </p>
            </div>
          </div>
        </section>
      </ScrollReveal>

      {/* Featured Apartments */}
      <ScrollReveal direction="up" duration={1000} delay={200}>
        <section className="py-16 bg-white">
          <div className="container mx-auto px-4">
            <div className="text-center mb-12">
              <h2 className="text-3xl md:text-4xl font-bold text-gray-900 mb-4 font-bebas">
                {homepageContent.featured.title?.[currentLang] ?? homepageContent.featured.title?.en ?? ''}
              </h2>
              <p className="text-lg text-gray-600 max-w-2xl mx-auto font-mulish leading-8">
                {homepageContent.featured.description?.[currentLang] ?? homepageContent.featured.description?.en ?? ''}
              </p>
            </div>

            <div className="grid gap-8 md:grid-cols-2 lg:grid-cols-3 mb-12">
              {(featuredApartments as FrontendApartment[] | null)?.map((apartment, index) => (
                <ScrollReveal key={apartment.id} direction="up" duration={700} delay={index * 150}>
                  <Link
                    href={`/apartments/${apartment.slug}`}
                    className="group relative bg-white rounded-2xl shadow-md overflow-hidden transition-all duration-500 hover:-translate-y-2 hover:shadow-2xl block"
                  >
                    <div className="relative h-52 bg-gradient-to-br from-blue-100 to-teal-100 overflow-hidden">
                      {apartment.image_url ? (
                        <Image
                          src={apartment.image_url}
                          alt={apartment.name}
                          fill
                          className="object-cover transition-transform duration-700 ease-out group-hover:scale-110"
                        />
                      ) : (
                        <div className="h-full w-full flex items-center justify-center">
                          <MapPin className="h-12 w-12 text-blue-400" />
                        </div>
                      )}
                      <div className="absolute inset-0 bg-gradient-to-t from-black/25 via-transparent to-transparent opacity-0 transition-opacity duration-500 group-hover:opacity-100" />
                    </div>
                    <div className="p-6 transition-colors duration-500 group-hover:bg-slate-50/80">
                      <h2 className="text-xl font-semibold text-gray-900 mb-2 transition-colors duration-300 group-hover:text-violet-700">{apartment.name}</h2>
                      <p className="text-gray-600 mb-4 line-clamp-2">
                        {apartment.short_description || `${apartment.max_guests} guests • ${apartment.bedrooms} bedroom(s)`}
                      </p>
                      <div className="flex items-center justify-between text-sm text-gray-600">
                        <span>{apartment.max_guests} guests • {apartment.bedrooms} bedrooms</span>
                        <span className="text-lg font-bold text-gray-900 transition-transform duration-300 group-hover:scale-110">€{(apartment.base_price_cents / 100).toFixed(0)}</span>
                      </div>
                    </div>
                  </Link>
                </ScrollReveal>
              ))}
            </div>

            <div className="text-center">
              <Link href="/apartments">
                <Button size="lg">
                  View All Apartments
                  <ArrowRight className="ml-2 h-4 w-4" />
                </Button>
              </Link>
            </div>
          </div>
        </section>
      </ScrollReveal>

      {/* About Section */}
      <ScrollReveal direction="up" duration={1000} delay={400}>
        <section className="py-16 bg-gray-50">
          <div className="container mx-auto px-4">
            <div className="grid gap-12 lg:grid-cols-2 items-center">
              <div>
                <h2 className="text-3xl md:text-4xl font-bold text-gray-900 mb-6 font-bebas">
                  {homepageContent.about.title?.[currentLang] ?? homepageContent.about.title?.en ?? ''}
                </h2>
                <p className="text-lg text-gray-600 mb-6 font-mulish leading-8 max-w-2xl">
                  {homepageContent.about.content?.[currentLang] ?? homepageContent.about.content?.en ?? ''}
                </p>
                <div className="grid gap-4 md:grid-cols-3 mb-8">
                  <div className="text-center">
                    <Users className="h-8 w-8 text-blue-600 mx-auto mb-2" />
                    <p className="font-semibold text-gray-900">Curated Selection</p>
                    <p className="text-sm text-gray-600">Handpicked artistic spaces</p>
                  </div>
                  <div className="text-center">
                    <MapPin className="h-8 w-8 text-blue-600 mx-auto mb-2" />
                    <p className="font-semibold text-gray-900">Prime Locations</p>
                    <p className="text-sm text-gray-600">Heart of Venice</p>
                  </div>
                  <div className="text-center">
                    <Star className="h-8 w-8 text-blue-600 mx-auto mb-2" />
                    <p className="font-semibold text-gray-900">5-Star Experience</p>
                    <p className="text-sm text-gray-600">Exceptional service</p>
                  </div>
                </div>
                <Link href="/about">
                  <Button variant="outline">
                    Learn More About Us
                  </Button>
                </Link>
              </div>
              <div className="h-96 bg-gradient-to-br from-blue-100 to-teal-100 rounded-lg flex items-center justify-center">
                <MapPin className="h-24 w-24 text-blue-400" />
              </div>
            </div>
          </div>
        </section>
      </ScrollReveal>

      {/* Gallery Section - DISABLED: Feature not ready yet */}
      {/*
      <ScrollReveal direction="up" duration={1000} delay={600}>
        <section className="py-16 bg-white">
          <div className="container mx-auto px-4">
            <div className="text-center mb-12">
              <h2 className="text-3xl md:text-4xl font-bold text-gray-900 mb-4 font-bebas">Artistic Spaces</h2>
              <p className="text-lg text-gray-600 font-mulish leading-8 max-w-2xl mx-auto">
                Explore the unique character of our artistic apartments
              </p>
            </div>
            <PhotoGallery
              images={[
                '/images/apartment-1.jpg',
                '/images/apartment-2.jpg',
                '/images/apartment-3.jpg',
              ]}
              alt="Venice Parcley Apartments Gallery"
            />
          </div>
        </section>
      </ScrollReveal>
      */}

      {/* CTA Section */}
      <ScrollReveal direction="up" duration={1000} delay={800}>
        <section className="py-16 bg-gradient-to-r from-blue-600 to-teal-600 text-white">
          <div className="container mx-auto px-4 text-center">
            <h2 className="text-3xl md:text-4xl font-bold mb-6 font-josefin">Ready for an Artistic Experience?</h2>
            <p className="text-lg md:text-xl mb-8 max-w-2xl mx-auto font-mulish leading-8">
              Book your stay in one of Venice's most unique and inspiring apartments today.
            </p>
            <div className="flex gap-4 justify-center flex-col sm:flex-row">
              <Link href="/apartments">
                <Button size="lg" variant="secondary">
                  Browse Apartments
                </Button>
              </Link>
              <Link href="/contact">
                <Button size="lg" variant="outline" className="border-white text-white hover:bg-white hover:text-blue-600">
                  Contact Us
                </Button>
              </Link>
            </div>
          </div>
        </section>
      </ScrollReveal>

      {/* Sticky Mobile Bottom CTA */}
      <div className="mobile-bottom-cta fixed bottom-0 left-0 right-0 md:hidden px-3 pb-3">
        <Link
          href="/apartments"
          className="flex h-14 w-full items-center justify-center rounded-t-[20px] bg-pink-500 text-white font-montserrat text-sm font-semibold uppercase tracking-[0.18em] shadow-[0_-6px_20px_rgba(0,0,0,0.2)]"
        >
          BOOK NOW
        </Link>
      </div>
    </div>
  );
}
