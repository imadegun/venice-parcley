'use client'

import { useState, useEffect, useRef } from 'react'
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
  const [mousePosition, setMousePosition] = useState({ x: 0.5, y: 0.5 })
  const [isTransitioning, setIsTransitioning] = useState(false)
  const [zoomLevels, setZoomLevels] = useState<number[]>([])
  const heroContent = heroContentData ?? getHeroContent()
  const containerRef = useRef<HTMLDivElement>(null)

  const currentLang = i18n.language as 'en' | 'it'

  // Initialize random zoom levels for each image
  useEffect(() => {
    const levels = heroContent.backgroundImages.map(() =>
      1 + Math.random() * 0.15 // Random zoom between 1.0 and 1.15
    )
    setZoomLevels(levels)
  }, [heroContent.backgroundImages.length])

  // Parallax effect on mouse move - smoother with lerp
  useEffect(() => {
    let rafId: number
    let targetX = 0.5
    let targetY = 0.5
    let currentX = 0.5
    let currentY = 0.5

    const handleMouseMove = (e: MouseEvent) => {
      if (!containerRef.current) return
      const rect = containerRef.current.getBoundingClientRect()
      targetX = (e.clientX - rect.left) / rect.width
      targetY = (e.clientY - rect.top) / rect.height
    }

    const animate = () => {
      // Smooth lerp interpolation
      currentX += (targetX - currentX) * 0.08
      currentY += (targetY - currentY) * 0.08
      setMousePosition({ x: currentX, y: currentY })
      rafId = requestAnimationFrame(animate)
    }

    const container = containerRef.current
    if (container) {
      container.addEventListener('mousemove', handleMouseMove)
      animate()
      return () => {
        container.removeEventListener('mousemove', handleMouseMove)
        cancelAnimationFrame(rafId)
      }
    }
  }, [])

  // Auto-rotate images with smooth transition
  useEffect(() => {
    const interval = setInterval(() => {
      setIsTransitioning(true)
      setTimeout(() => {
        setCurrentImageIndex((prev) =>
          (prev + 1) % heroContent.backgroundImages.length
        )
        setIsTransitioning(false)
      }, 600) // Slightly longer for smoother fade
    }, 10000) // 10 seconds for more relaxed feel

    return () => clearInterval(interval)
  }, [heroContent.backgroundImages.length])

  const nextImage = () => {
    setIsTransitioning(true)
    setTimeout(() => {
      setCurrentImageIndex((prev) =>
        (prev + 1) % heroContent.backgroundImages.length
      )
      setIsTransitioning(false)
    }, 600)
  }

  const prevImage = () => {
    setIsTransitioning(true)
    setTimeout(() => {
      setCurrentImageIndex((prev) =>
        (prev - 1 + heroContent.backgroundImages.length) % heroContent.backgroundImages.length
      )
      setIsTransitioning(false)
    }, 600)
  }

  const goToImage = (index: number) => {
    if (index === currentImageIndex) return
    setIsTransitioning(true)
    setTimeout(() => {
      setCurrentImageIndex(index)
      setIsTransitioning(false)
    }, 600)
  }

  // Calculate parallax offset with easing
  const getParallaxOffset = (intensity: number) => ({
    x: (mousePosition.x - 0.5) * intensity,
    y: (mousePosition.y - 0.5) * intensity,
  })

  // Get random zoom for each image (different per slide)
  const getZoomScale = (index: number) => {
    const baseScale = index === currentImageIndex ? 1.08 : 1.0
    const randomZoom = zoomLevels[index] || 1.05
    return isTransitioning ? 1.0 : baseScale * randomZoom
  }

  return (
    <section
      ref={containerRef}
      className="relative z-[1] mt-[10px] h-[min(80vh,700px)] aspect-[4/5] w-full overflow-hidden rounded-bl-[60px] rounded-br-[60px] md:mt-0 md:h-screen md:aspect-auto md:rounded-bl-[40px] md:rounded-br-[40px]"
    >
      {/* Background Images with Parallax & Ken Burns Effect */}
      <div className="absolute inset-0 overflow-hidden rounded-bl-[60px] rounded-br-[60px] md:rounded-bl-[40px] md:rounded-br-[40px]">
        {heroContent.backgroundImages.map((image, index) => {
          const isActive = index === currentImageIndex
          const offset = getParallaxOffset(20)
          const zoomScale = getZoomScale(index)

          return (
            <div
              key={index}
              className={`absolute inset-0 transition-all duration-[1200ms] ease-[cubic-bezier(0.4,0,0.2,1)] ${
                isActive ? 'opacity-100' : 'opacity-0'
              }`}
              style={{
                transform: `translate(${offset.x}px, ${offset.y}px) scale(${zoomScale})`,
                willChange: 'transform, opacity',
              }}
            >
              {/* Blurred background layer for depth */}
              <Image
                src={image}
                alt={`Hero background blur ${index + 1}`}
                fill
                className="object-cover blur-[10px] scale-110 opacity-25"
                priority={index === 0}
                loading={index === 0 ? 'eager' : 'lazy'}
                fetchPriority={index === 0 ? 'high' : 'auto'}
                sizes="100vw"
                quality={100}
                placeholder="empty"
              />

              {/* Main image with smooth Ken Burns zoom */}
              <Image
                src={image}
                alt={`Hero background ${index + 1}`}
                fill
                className="object-cover"
                style={{
                  transform: isActive ? 'scale(1.08)' : 'scale(1.0)',
                  transition: 'transform 10s cubic-bezier(0.4, 0, 0.2, 1)',
                  willChange: 'transform',
                }}
                priority={index === 0}
                loading={index === 0 ? 'eager' : 'lazy'}
                fetchPriority={index === 0 ? 'high' : 'auto'}
                sizes="100vw"
                quality={100}
                placeholder="empty"
              />

              {/* Cinematic gradient overlay */}
              <div
                className={`absolute inset-0 bg-gradient-to-br from-black/10 via-transparent to-black/20 transition-opacity duration-[1200ms] ease-[cubic-bezier(0.4,0,0.2,1)] ${
                  isActive ? 'opacity-100' : 'opacity-0'
                }`}
              />

              {/* Subtle grain texture */}
              <div
                className="absolute inset-0 opacity-20 pointer-events-none mix-blend-overlay"
                style={{
                  backgroundImage: `url("data:image/svg+xml,%3Csvg viewBox='0 0 200 200' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='noise'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.65' numOctaves='3' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23noise)'/%3E%3C/svg%3E")`,
                }}
              />
            </div>
          )
        })}
      </div>

      {/* Dynamic overlay that follows mouse */}
      <div
        className="absolute inset-0 pointer-events-none transition-opacity duration-300"
        style={{
          background: `radial-gradient(circle at ${mousePosition.x * 100}% ${mousePosition.y * 100}%, rgba(255,255,255,0.05) 0%, transparent 50%)`,
        }}
      />

      {/* Vignette & Grain overlay */}
      <div className="absolute inset-0 bg-gradient-to-t from-black/60 via-transparent to-transparent pointer-events-none" />
      <div className="absolute inset-0 bg-gradient-to-b from-black/20 via-transparent to-black/40 pointer-events-none" />

      {/* Top White-to-Transparent Fade (Hero-only) */}
      <div className="absolute top-0 left-0 right-0 z-[5] h-24 bg-gradient-to-b from-white/75 via-white/30 to-transparent rounded-bl-[60px] rounded-br-[60px] md:rounded-bl-[40px] md:rounded-br-[40px] pointer-events-none" />

      {/* Navigation Arrows with hover effects */}
      <Button
        variant="ghost"
        size="sm"
        className="absolute left-2 top-1/2 -translate-y-1/2 z-20 text-white hover:bg-white/20 md:left-4 transition-all duration-300 hover:scale-110"
        onClick={prevImage}
        aria-label="Previous image"
      >
        <ChevronLeft className="w-7 h-7 md:w-8 md:h-8" />
      </Button>

      <Button
        variant="ghost"
        size="sm"
        className="absolute right-2 top-1/2 -translate-y-1/2 z-20 text-white hover:bg-white/20 md:right-4 transition-all duration-300 hover:scale-110"
        onClick={nextImage}
        aria-label="Next image"
      >
        <ChevronRight className="w-7 h-7 md:w-8 md:h-8" />
      </Button>

      {/* Image indicators */}
      <div className="absolute bottom-8 left-1/2 -translate-x-1/2 z-20 flex gap-3">
        {heroContent.backgroundImages.map((_, index) => (
          <button
            key={index}
            onClick={() => goToImage(index)}
            className={`w-3 h-3 rounded-full transition-all duration-300 ${
              index === currentImageIndex
                ? 'bg-white scale-125 shadow-lg'
                : 'bg-white/40 hover:bg-white/60 hover:scale-110'
            }`}
            aria-label={`Go to image ${index + 1}`}
          />
        ))}
      </div>

      {/* Content with staggered animation */}
      <div className="relative z-10 text-center text-white max-w-4xl mx-auto px-6 md:px-4">
        <h1
          className={`text-[30px] md:text-7xl font-semibold mb-4 md:mb-6 leading-tight font-josefin transition-all duration-700 ${
            isTransitioning ? 'opacity-0 translate-y-4' : 'opacity-100 translate-y-0'
          }`}
        >
          {heroContent.title[currentLang]}
        </h1>
        <p
          className={`text-base md:text-2xl mb-6 md:mb-8 text-white/90 max-w-2xl mx-auto px-2 md:px-0 transition-all duration-700 delay-100 ${
            isTransitioning ? 'opacity-0 translate-y-4' : 'opacity-100 translate-y-0'
          }`}
        >
          {heroContent.subtitle[currentLang]}
        </p>

        <div
          className={`flex flex-col sm:flex-row gap-4 justify-center items-center transition-all duration-700 delay-200 ${
            isTransitioning ? 'opacity-0 translate-y-4' : 'opacity-100 translate-y-0'
          }`}
        >
          {/* <Button
            size="lg"
            className="text-lg px-8 py-4 bg-white text-black hover:bg-white/90 transition-all duration-300 hover:scale-105 hover:shadow-xl"
          >
            {heroContent.ctaText[currentLang]}
          </Button> */}
          {/* View Property Types button disabled temporarily */}
        </div>
      </div>

      {/* Glitch effect overlay (subtle, on image change) */}
      {isTransitioning && (
        <div className="absolute inset-0 z-[15] pointer-events-none animate-pulse bg-white/10" />
      )}
    </section>
  )
}
