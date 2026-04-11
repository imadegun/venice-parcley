'use client'

import { useState, useEffect } from 'react'
import Image from 'next/image'
import { ChevronLeft, ChevronRight } from 'lucide-react'
import { Button } from '@/components/ui/button'
import { useTranslation } from 'react-i18next'
import { getHeroContent } from '@/lib/content'

export function HeroSection() {
  const { t, i18n } = useTranslation()
  const [currentImageIndex, setCurrentImageIndex] = useState(0)
  const heroContent = getHeroContent()

  const currentLang = i18n.language as 'en' | 'it'

  // Auto-rotate images
  useEffect(() => {
    const interval = setInterval(() => {
      setCurrentImageIndex((prev) =>
        (prev + 1) % heroContent.backgroundImages.length
      )
    }, 20000)

    return () => clearInterval(interval)
  }, [heroContent.backgroundImages.length])

  const nextImage = () => {
    setCurrentImageIndex((prev) =>
      (prev + 1) % heroContent.backgroundImages.length
    )
  }

  const prevImage = () => {
    setCurrentImageIndex((prev) =>
      (prev - 1 + heroContent.backgroundImages.length) % heroContent.backgroundImages.length
    )
  }

  const goToImage = (index: number) => {
    setCurrentImageIndex(index)
  }

  return (
    <section className="relative h-screen flex items-center justify-center overflow-hidden">
      {/* Background Images */}
      <div className="absolute inset-0 overflow-hidden rounded-bl-[40px] rounded-br-[40px]">
        {heroContent.backgroundImages.map((image, index) => (
          <div
            key={index}
            className={`absolute inset-0 transition-opacity duration-[2600ms] ease-in-out ${
              index === currentImageIndex ? 'opacity-100' : 'opacity-0'
            }`}
          >
            <Image
              src={image}
              alt={`Hero background ${index + 1}`}
              fill
              className={`object-cover ${
                index === currentImageIndex
                  ? 'hero-cinematic-loop'
                  : ''
              }`}
              priority={index === 0}
              loading={index === 0 ? 'eager' : 'lazy'}
              fetchPriority={index === 0 ? 'high' : 'auto'}
              sizes="100vw"
              quality={100}
              placeholder="empty"
            />
          </div>
        ))}
      </div>

      {/* Overlay */}
      <div className="absolute inset-0 bg-black/40 rounded-bl-[40px] rounded-br-[40px]" />

      {/* Top White-to-Transparent Fade (Hero-only) */}
      <div className="absolute top-0 left-0 right-0 z-[5] h-24 bg-gradient-to-b from-white/75 via-white/30 to-transparent rounded-bl-[40px] rounded-br-[40px] pointer-events-none" />

      {/* Navigation Arrows */}
      <Button
        variant="ghost"
        size="sm"
        className="absolute left-4 top-1/2 -translate-y-1/2 z-20 text-white hover:bg-white/20"
        onClick={prevImage}
      >
        <ChevronLeft className="w-8 h-8" />
      </Button>

      <Button
        variant="ghost"
        size="sm"
        className="absolute right-4 top-1/2 -translate-y-1/2 z-20 text-white hover:bg-white/20"
        onClick={nextImage}
      >
        <ChevronRight className="w-8 h-8" />
      </Button>

      {/* Content */}
      <div className="relative z-10 text-center text-white max-w-4xl mx-auto px-4">
        <h1 className="text-5xl md:text-7xl font-semibold mb-6 leading-tight font-josefin">
          {heroContent.title[currentLang]}
        </h1>
        <p className="text-xl md:text-2xl mb-8 text-white/90 max-w-2xl mx-auto">
          {heroContent.subtitle[currentLang]}
        </p>

        <div className="flex flex-col sm:flex-row gap-4 justify-center items-center">
          <Button size="lg" className="text-lg px-8 py-4 bg-white text-black hover:bg-white/90">
            {heroContent.ctaText[currentLang]}
          </Button>
          <Button
            variant="outline"
            size="lg"
            className="text-lg px-8 py-4 border-white text-white hover:bg-white hover:text-black"
            onClick={() => {
              const apartmentsSection = document.getElementById('apartments')
              apartmentsSection?.scrollIntoView({ behavior: 'smooth' })
            }}
          >
            View Property Types
          </Button>
        </div>
      </div>

      {/* Image Indicators */}
      <div className="absolute bottom-24 left-1/2 -translate-x-1/2 z-10 flex gap-2">
        {heroContent.backgroundImages.map((_, index) => (
          <button
            key={index}
            className={`w-2 h-2 rounded-full transition-colors ${
              index === currentImageIndex ? 'bg-white' : 'bg-white/50'
            }`}
            onClick={() => goToImage(index)}
          />
        ))}
      </div>
    </section>
  )
}
