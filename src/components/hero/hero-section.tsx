'use client'

import { useState, useEffect } from 'react'
import Image from 'next/image'
import { ChevronLeft, ChevronRight } from 'lucide-react'
import { Button } from '@/components/ui/button'
import { useTranslation } from 'react-i18next'
import { getHeroContent, getPropertyTypes } from '@/lib/content'

export function HeroSection() {
  const { t, i18n } = useTranslation()
  const [currentImageIndex, setCurrentImageIndex] = useState(0)
  const heroContent = getHeroContent()
  const propertyTypes = getPropertyTypes()

  const currentLang = i18n.language as 'en' | 'it'

  // Auto-rotate images
  useEffect(() => {
    const interval = setInterval(() => {
      setCurrentImageIndex((prev) =>
        (prev + 1) % heroContent.backgroundImages.length
      )
    }, 5000) // Change image every 5 seconds

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
      <div className="absolute top-20 left-0 right-0 bottom-0 overflow-hidden rounded-tl-[40px] rounded-tr-[40px]">
        {heroContent.backgroundImages.map((image, index) => (
          <div
            key={index}
            className={`absolute inset-0 transition-opacity duration-1000 ${
              index === currentImageIndex ? 'opacity-100' : 'opacity-0'
            }`}
          >
            <Image
              src={image}
              alt={`Hero background ${index + 1}`}
              fill
              className="object-cover animate-soft-entrance"
              priority={index === 0}
              loading={index === 0 ? 'eager' : 'lazy'}
              fetchPriority={index === 0 ? 'high' : 'auto'}
              sizes="100vw"
              quality={85}
              placeholder="blur"
              blurDataURL="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDAAYEBQYFBAYGBQYHBwYIChAKCgkJChQODwwQFxQYGBcUFhYaHSUfGhsjHBYWICwgIyYnKSopGR8tMC0oMCUoKSj/2wBDAQcHBwoIChMKChMoGhYaKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCj/wAARCAABAAEDASIAAhEBAxEB/8QAFQABAQAAAAAAAAAAAAAAAAAAAAv/xAAhEAACAQMDBQAAAAAAAAAAAAABAgMABAUGIWGRkqGx0f/EABUBAQEAAAAAAAAAAAAAAAAAAAMF/8QAGhEAAgIDAAAAAAAAAAAAAAAAAAECEgMRkf/aAAwDAQACEQMRAD8AltJagyeH0AthI5xdrLcNM91BF5pX2HaH9bcfaSXWGaRmknyJckliyjqTzSlT54b6bk+h0R+IRjWjBqO6O2mhP//Z"
            />
          </div>
        ))}
      </div>

      {/* Overlay */}
      <div className="absolute inset-0 bg-black/40" />

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

      {/* Property Type Previews */}
      <div className="absolute bottom-8 left-1/2 -translate-x-1/2 z-10">
        <div className="flex gap-4 overflow-x-auto max-w-4xl px-4">
          {propertyTypes.slice(0, 4).map((propertyType) => (
            <div
              key={propertyType.id}
              className="flex-shrink-0 bg-white/10 backdrop-blur-sm rounded-lg p-3 hover:bg-white/20 transition-colors cursor-pointer group"
              onClick={() => {
                const element = document.getElementById(propertyType.id)
                element?.scrollIntoView({ behavior: 'smooth' })
              }}
            >
              <div className="w-16 h-16 rounded-lg overflow-hidden mb-2">
                <Image
                  src={propertyType.heroImage}
                  alt={propertyType.name[currentLang]}
                  width={64}
                  height={64}
                  className="object-cover w-full h-full group-hover:scale-110 transition-transform duration-300"
                  loading="lazy"
                  quality={80}
                  sizes="64px"
                />
              </div>
              <p className="text-sm font-medium text-white text-center">
                {propertyType.name[currentLang]}
              </p>
            </div>
          ))}
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

      {/* Scroll Indicator */}
      <div className="absolute bottom-8 left-1/2 -translate-x-1/2 z-10 animate-bounce">
        <div className="w-6 h-10 border-2 border-white/50 rounded-full flex justify-center">
          <div className="w-1 h-3 bg-white/50 rounded-full mt-2 animate-pulse" />
        </div>
      </div>
    </section>
  )
}