import Link from "next/link"
import { Button } from "@/components/ui/button"
import { HeroSection } from "@/components/hero/hero-section"
import { PhotoGallery } from "@/components/gallery/photo-gallery"
import { ArrowRight, MapPin, Users, Star } from "lucide-react"

export default function Home() {
  return (
    <div className="min-h-screen pb-24 md:pb-0">
      {/* Hero Section */}
      <HeroSection />

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
            <h2 className="text-3xl font-bold text-gray-900 mb-4 font-bebas">Featured Apartments</h2>
            <p className="text-lg text-gray-600 max-w-2xl mx-auto font-mulish">
              Experience Venice like never before in our carefully curated collection of artistic apartments.
            </p>
          </div>

          <div className="grid gap-8 md:grid-cols-2 lg:grid-cols-3 mb-12">
            {/* Mock apartment cards - in real app, fetch from database */}
            {[1, 2, 3].map((i) => (
              <div key={i} className="bg-white rounded-lg shadow-lg overflow-hidden hover:shadow-xl transition-shadow">
                <div className="h-48 bg-gradient-to-br from-blue-100 to-teal-100 flex items-center justify-center">
                  <MapPin className="h-12 w-12 text-blue-400" />
                </div>
                <div className="p-6">
                  <h3 className="text-xl font-medium text-gray-900 mb-2">
                    Artistic Studio {i}
                  </h3>
                  <p className="text-gray-600 mb-4">
                    Venice, Italy • 2 guests • 1 bedroom
                  </p>
                  <div className="flex items-center justify-between">
                    <div className="flex items-center gap-1">
                      <Star className="h-4 w-4 text-yellow-400 fill-current" />
                      <span className="text-sm text-gray-600">4.9</span>
                    </div>
                    <div className="text-right">
                      <p className="text-2xl font-bold text-gray-900">€{120 + i * 20}</p>
                      <p className="text-sm text-gray-600">per night</p>
                    </div>
                  </div>
                </div>
              </div>
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
              <h2 className="text-3xl font-bold text-gray-900 mb-6 font-bebas">About Venice Parcley</h2>
              <p className="text-lg text-gray-600 mb-6 font-mulish">
                We connect art lovers with extraordinary living spaces in Venice, offering a unique blend of luxury accommodation and artistic inspiration.
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
