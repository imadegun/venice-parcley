import Link from "next/link"
import Image from "next/image"
import { Button } from "@/components/ui/button"
import { HeroSection } from "@/components/hero/hero-section"
import { PhotoGallery } from "@/components/gallery/photo-gallery"
import { ArrowRight, MapPin, Star, Users } from "lucide-react"
import { getHomepageContent } from "@/lib/content"
import { createServerSupabaseClient } from "@/lib/supabase"

interface FrontendApartment {
  id: string
  slug: string
  name: string
  short_description: string | null
  base_price_cents: number
  max_guests: number
  bedrooms: number
  image_url: string | null
  is_active: boolean
}

export default async function Home() {
  const homepageContent = await getHomepageContent()
  const supabase = createServerSupabaseClient()
  const { data: featuredApartments } = await supabase
    .from('apartments')
    .select('id, slug, name, short_description, base_price_cents, max_guests, bedrooms, image_url, is_active')
    .eq('is_active', true)
    .order('created_at', { ascending: false })
    .limit(3)

  return (
    <div className="min-h-screen pb-24 md:pb-0">
      {/* Hero Section */}
      <HeroSection heroContentData={homepageContent.hero} />

      {/* Mobile Intro Copy */}
      <section className="py-12 bg-white">
        <div className="container mx-auto px-4">
          <div className="mx-auto max-w-3xl text-center">
            <p className="text-[12px] md:text-sm uppercase tracking-[0.28em] text-slate-600 font-montserrat mb-5">
              SHORELINE VIBES
            </p>
            <h1 className="text-[30px] md:text-5xl font-semibold text-gray-900 leading-tight font-josefin mb-4">
              Life at Shoreline, wrapped in artful calm and cinematic sea light.
            </h1>
            <div className="mx-auto mb-7 h-[2px] w-24 bg-gradient-to-r from-transparent via-slate-500 to-transparent" />
            <p className="text-base md:text-lg text-gray-600 font-mulish px-[30px] md:px-0 leading-8">
              Drift through curated spaces, coastal textures, and boutique rhythms designed for guests who savor design-forward stays.
            </p>
          </div>
        </div>
      </section>

      {/* Featured Apartments */}
      <section className="py-16 bg-white">
        <div className="container mx-auto px-4">
          <div className="text-center mb-12">
            <h2 className="text-3xl font-bold text-gray-900 mb-4 font-bebas">{homepageContent.featured.title}</h2>
            <p className="text-lg text-gray-600 max-w-2xl mx-auto font-mulish">
              {homepageContent.featured.description}
            </p>
          </div>

          <div className="grid gap-8 md:grid-cols-2 lg:grid-cols-3 mb-12">
            {(featuredApartments as FrontendApartment[] | null)?.map((apartment) => (
              <Link
                key={apartment.id}
                href={`/apartments/${apartment.slug}`}
                className="bg-white rounded-lg shadow-lg overflow-hidden hover:shadow-xl transition-shadow"
              >
                <div className="relative h-48 bg-gradient-to-br from-blue-100 to-teal-100">
                  {apartment.image_url ? (
                    <Image
                      src={apartment.image_url}
                      alt={apartment.name}
                      fill
                      className="object-cover"
                    />
                  ) : (
                    <div className="h-full w-full flex items-center justify-center">
                      <MapPin className="h-12 w-12 text-blue-400" />
                    </div>
                  )}
                </div>
                <div className="p-6">
                  <h3 className="text-xl font-medium text-gray-900 mb-2">{apartment.name}</h3>
                  <p className="text-gray-600 mb-4">
                    {apartment.short_description || `${apartment.max_guests} guests • ${apartment.bedrooms} bedroom(s)`}
                  </p>
                  <div className="flex items-center justify-between">
                    <span className="text-sm text-gray-600">
                      {apartment.max_guests} guests • {apartment.bedrooms} bedrooms
                    </span>
                    <div className="text-right">
                      <p className="text-2xl font-bold text-gray-900">€{(apartment.base_price_cents / 100).toFixed(0)}</p>
                      <p className="text-sm text-gray-600">per night</p>
                    </div>
                  </div>
                </div>
              </Link>
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

      {/* About Section */}
      <section className="py-16 bg-gray-50">
        <div className="container mx-auto px-4">
          <div className="grid gap-12 lg:grid-cols-2 items-center">
            <div>
              <h2 className="text-3xl font-bold text-gray-900 mb-6 font-bebas">{homepageContent.about.title}</h2>
              <p className="text-lg text-gray-600 mb-6 font-mulish">
                {homepageContent.about.content}
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

      {/* Gallery Section */}
      <section className="py-16 bg-white">
        <div className="container mx-auto px-4">
          <div className="text-center mb-12">
            <h2 className="text-3xl font-bold text-gray-900 mb-4 font-bebas">Artistic Spaces</h2>
            <p className="text-lg text-gray-600 font-mulish">
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

      {/* CTA Section */}
      <section className="py-16 bg-gradient-to-r from-blue-600 to-teal-600 text-white">
        <div className="container mx-auto px-4 text-center">
          <h2 className="text-3xl font-semibold mb-4 font-josefin">Ready for an Artistic Experience?</h2>
          <p className="text-lg mb-8 max-w-2xl mx-auto font-mulish">
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
