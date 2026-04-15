'use client'

import { useEffect, useMemo, useState } from 'react'
import Image from 'next/image'
import { ChevronLeft, ChevronRight, ImageIcon } from 'lucide-react'

interface AnimatedGalleryProps {
  images: string[]
  title: string
}

export function AnimatedGallery({ images, title }: AnimatedGalleryProps) {
  const normalizedImages = useMemo(() => images.filter(Boolean), [images])
  const [activeIndex, setActiveIndex] = useState(0)
  const [isPaused, setIsPaused] = useState(false)

  useEffect(() => {
    if (normalizedImages.length <= 1 || isPaused) return

    const interval = window.setInterval(() => {
      setActiveIndex((prev) => (prev + 1) % normalizedImages.length)
    }, 4500)

    return () => window.clearInterval(interval)
  }, [normalizedImages.length, isPaused])

  if (normalizedImages.length === 0) {
    return (
      <div className="relative h-[420px] w-full rounded-2xl bg-gradient-to-br from-slate-100 to-slate-200 flex items-center justify-center">
        <div className="text-center text-slate-500">
          <ImageIcon className="mx-auto mb-2 h-10 w-10" />
          <p>No gallery images available</p>
        </div>
      </div>
    )
  }

  const goPrev = () => {
    setActiveIndex((prev) => (prev - 1 + normalizedImages.length) % normalizedImages.length)
  }

  const goNext = () => {
    setActiveIndex((prev) => (prev + 1) % normalizedImages.length)
  }

  return (
    <div
      className="space-y-6"
      onMouseEnter={() => setIsPaused(true)}
      onMouseLeave={() => setIsPaused(false)}
    >
      <div className="relative h-[420px] md:h-[520px] w-full overflow-hidden rounded-2xl bg-slate-100 shadow-lg">
        {normalizedImages.map((image, index) => (
          <div
            key={`${image}-${index}`}
            className={`absolute inset-0 transition-opacity duration-[2600ms] ease-in-out ${
              index === activeIndex ? 'opacity-100' : 'opacity-0'
            }`}
          >
            <Image
              src={image}
              alt={`${title} background image ${index + 1}`}
              fill
              className="object-cover blur-md scale-105 opacity-45"
              priority={index === 0}
            />
            <Image
              src={image}
              alt={`${title} main image ${index + 1}`}
              fill
              className={`object-contain p-2 transition-transform duration-[2600ms] ease-in-out ${
                index === activeIndex ? 'animate-[fullThenFloat_2600ms_ease-in-out] hero-cinematic-loop' : ''
              }`}
              priority={index === 0}
            />
          </div>
        ))}
        {normalizedImages.length > 1 && (
          <>
            <button
              type="button"
              onClick={goPrev}
              className="absolute left-4 top-1/2 -translate-y-1/2 rounded-full bg-black/40 p-2 text-white backdrop-blur-sm transition hover:bg-black/60"
              aria-label="Previous image"
            >
              <ChevronLeft className="h-5 w-5" />
            </button>
            <button
              type="button"
              onClick={goNext}
              className="absolute right-4 top-1/2 -translate-y-1/2 rounded-full bg-black/40 p-2 text-white backdrop-blur-sm transition hover:bg-black/60"
              aria-label="Next image"
            >
              <ChevronRight className="h-5 w-5" />
            </button>
          </>
        )}
      </div>

      {normalizedImages.length > 1 && (
        <section className="space-y-3">
          <h3 className="text-lg font-semibold text-slate-900">Gallery</h3>
          <div className="grid grid-cols-2 gap-3 sm:grid-cols-3 md:grid-cols-4 lg:grid-cols-5">
            {normalizedImages.map((image, index) => (
              <button
                type="button"
                key={`${image}-${index}`}
                onClick={() => setActiveIndex(index)}
                onMouseEnter={() => {
                  setIsPaused(true)
                  setActiveIndex(index)
                }}
                className={`group relative aspect-square overflow-hidden rounded-xl transition-all duration-300 ${
                  index === activeIndex
                    ? 'ring-2 ring-violet-500 scale-[1.02]'
                    : 'opacity-90 hover:opacity-100 hover:-translate-y-0.5'
                }`}
                aria-label={`Show image ${index + 1}`}
              >
                <Image
                  src={image}
                  alt={`${title} thumbnail ${index + 1}`}
                  fill
                  className="object-cover transition-transform duration-500 group-hover:scale-110"
                />
                <span className="absolute inset-0 bg-black/0 transition-colors duration-300 group-hover:bg-black/10" />
              </button>
            ))}
          </div>
        </section>
      )}

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
    </div>
  )
}
