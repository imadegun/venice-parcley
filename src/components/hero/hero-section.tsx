'use client'

import { useState, useEffect } from 'react'
import Image from 'next/image'
import { ChevronLeft, ChevronRight } from 'lucide-react'
import { Button } from '@/components/ui/button'
import { useTranslation } from 'react-i18next'
import { getHeroContent, type HeroContent } from '@/lib/content'

interface HeroSectionProps {
  heroContentData?: HeroContent
}

export function HeroSection({ heroContentData }: HeroSectionProps) {
  const { t, i18n } = useTranslation()
  const [currentImageIndex, setCurrentImageIndex] = useState(0)
  const [isTransitioning, setIsTransitioning] = useState(false)
  const heroContent = heroContentData ?? getHeroContent()

  const currentLang = i18n.language as 'en' | 'it'

  // Auto-rotate images
  useEffect(() => {
    const interval = setInterval(() => {
      setIsTransitioning(true)
      setTimeout(() => {
        setCurrentImageIndex((prev) =>
          (prev + 1) % heroContent.backgroundImages.length
        )
        setIsTransitioning(false)
      }, 1000) // 1s fade
    }, 20000) // 20s total

    return () => clearInterval(interval)
  }, [heroContent.backgroundImages.length])

  const nextImage = () => {
    setIsTransitioning(true)
    setTimeout(() => {
      setCurrentImageIndex((prev) =>
        (prev + 1) % heroContent.backgroundImages.length
      )
      setIsTransitioning(false)
    }, 1000)
  }

  const prevImage = () => {
    setIsTransitioning(true)
    setTimeout(() => {
      setCurrentImageIndex((prev) =>
        (prev - 1 + heroContent.backgroundImages.length) % heroContent.backgroundImages.length
      )
      setIsTransitioning(false)
    }, 1000)
  }

  const goToImage = (index: number) => {
    if (index === currentImageIndex) return
    setIsTransitioning(true)
    setTimeout(() => {
      setCurrentImageIndex(index)
      setIsTransitioning(false)
    }, 1000)
  }

  return (
    <section className="relative z-[1] mt-[10px] h-[min(80vh,700px)] aspect-[4/5] w-full overflow-hidden rounded-bl-[60px] rounded-br-[60px] md:mt-0 md:h-screen md:aspect-auto md:rounded-bl-[40px] md:rounded-br-[40px]">
      {/* Background Images */}
      <div className="absolute inset-0 overflow-hidden rounded-bl-[60px] rounded-br-[60px] md:rounded-bl-[40px] md:rounded-br-[40px]">
        {heroContent.backgroundImages.map((image, index) => (
          <div
            key={index}
            className={`absolute inset-0 transition-opacity duration-[2600ms] ease-in-out ${
              index === currentImageIndex ? 'opacity-100' : 'opacity-0'
            }`}
          >
            <Image
              src={image}
              alt={`Hero background blur ${index + 1}`}
              fill
              className="object-cover blur-md scale-105 opacity-50"
              priority={index === 0}
              loading={index === 0 ? 'eager' : 'lazy'}
              fetchPriority={index === 0 ? 'high' : 'auto'}
              sizes="100vw"
              quality={100}
              placeholder="empty"
            />
            <Image
              src={image}
              alt={`Hero background ${index + 1}`}
              fill
              className={`object-cover ${
                index === currentImageIndex
                  ? 'animate-[fullThenFloat_2600ms_ease-in-out] hero-cinematic-loop'
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
      <div className="absolute inset-0 bg-black/40 rounded-bl-[60px] rounded-br-[60px] md:rounded-bl-[40px] md:rounded-br-[40px]" />

      {/* Top White-to-Transparent Fade (Hero-only) */}
      <div className="absolute top-0 left-0 right-0 z-[5] h-24 bg-gradient-to-b from-white/75 via-white/30 to-transparent rounded-bl-[60px] rounded-br-[60px] md:rounded-bl-[40px] md:rounded-br-[40px] pointer-events-none" />

      {/* Navigation Arrows */}
      <Button
        variant="ghost"
        size="sm"
        className="absolute left-2 top-1/2 -translate-y-1/2 z-20 text-white hover:bg-white/20 md:left-4"
        onClick={prevImage}
      >
        <ChevronLeft className="w-7 h-7 md:w-8 md:h-8" />
      </Button>

      <Button
        variant="ghost"
        size="sm"
        className="absolute right-2 top-1/2 -translate-y-1/2 z-20 text-white hover:bg-white/20 md:right-4"
        onClick={nextImage}
      >
        <ChevronRight className="w-7 h-7 md:w-8 md:h-8" />
      </Button>

      {/* Content */}
      <div className="relative z-10 text-center text-white max-w-4xl mx-auto px-6 md:px-4">
        <h1 className="text-[30px] md:text-7xl font-semibold mb-4 md:mb-6 leading-tight font-josefin">
          {heroContent.title[currentLang]}
        </h1>
        <p className="text-base md:text-2xl mb-6 md:mb-8 text-white/90 max-w-2xl mx-auto px-2 md:px-0">
          {heroContent.subtitle[currentLang]}
        </p>

        <div className="flex flex-col sm:flex-row gap-4 justify-center items-center">
          {/* <Button size="lg" className="text-lg px-8 py-4 bg-white text-black hover:bg-white/90">
            {heroContent.ctaText[currentLang]}
          </Button> */}
          {/* View Property Types button disabled temporarily */}
        </div>
      </div>

      {/* Image indicators disabled temporarily */}

      <style jsx>{`
        @keyframes fullThenFloat {
          0% {
            transform: scale(1);
          }
          35% {
            transform: scale(1);
          }
          100% {
            transform: scale(1.04);
          }
        }
      `}</style>
    </section>
  )
}
