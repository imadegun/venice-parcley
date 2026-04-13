'use client'

import { useState } from 'react'
import Image from 'next/image'
import { X, ChevronLeft, ChevronRight, ZoomIn } from 'lucide-react'
import { Button } from '@/components/ui/button'
import { Dialog, DialogContent } from '@/components/ui/dialog'

interface PhotoGalleryProps {
  images: string[]
  alt: string
  className?: string
}

export function PhotoGallery({ images, alt, className = '' }: PhotoGalleryProps) {
  const [currentImageIndex, setCurrentImageIndex] = useState(0)
  const [isLightboxOpen, setIsLightboxOpen] = useState(false)

  if (!images || images.length === 0) {
    return (
      <div className={`bg-gray-200 rounded-lg flex items-center justify-center h-64 ${className}`}>
        <p className="text-gray-500">No images available</p>
      </div>
    )
  }

  const openLightbox = (index: number) => {
    setCurrentImageIndex(index)
    setIsLightboxOpen(true)
  }

  const closeLightbox = () => {
    setIsLightboxOpen(false)
  }

  const nextImage = () => {
    setCurrentImageIndex((prev) => (prev + 1) % images.length)
  }

  const prevImage = () => {
    setCurrentImageIndex((prev) => (prev - 1 + images.length) % images.length)
  }

  const handleKeyDown = (e: KeyboardEvent) => {
    if (e.key === 'ArrowLeft') prevImage()
    if (e.key === 'ArrowRight') nextImage()
    if (e.key === 'Escape') closeLightbox()
  }

  // Main gallery grid
  if (images.length === 1) {
    return (
      <div className={`relative group cursor-pointer ${className}`}>
        <Image
          src={images[0]}
          alt={alt}
          fill
          className="object-cover rounded-lg"
          onClick={() => openLightbox(0)}
        />
        <div className="absolute inset-0 bg-black/0 group-hover:bg-black/20 transition-all duration-300 rounded-lg flex items-center justify-center opacity-0 group-hover:opacity-100">
          <ZoomIn className="w-8 h-8 text-white" />
        </div>
        <Lightbox
          images={images}
          currentIndex={currentImageIndex}
          isOpen={isLightboxOpen}
          onClose={closeLightbox}
          onNext={nextImage}
          onPrev={prevImage}
           _onKeyDown={handleKeyDown}
          alt={alt}
        />
      </div>
    )
  }

  // Multiple images - grid layout
  return (
    <div className={`space-y-4 ${className}`}>
      {/* Main large image */}
      <div className="relative group cursor-pointer aspect-[16/10] overflow-hidden rounded-lg">
        <Image
          src={images[0]}
          alt={`${alt} - Main view`}
          fill
          className="object-cover"
          onClick={() => openLightbox(0)}
        />
        <div className="absolute inset-0 bg-black/0 group-hover:bg-black/20 transition-all duration-300 flex items-center justify-center opacity-0 group-hover:opacity-100">
          <ZoomIn className="w-8 h-8 text-white" />
        </div>
      </div>

      {/* Thumbnail grid */}
      {images.length > 1 && (
        <div className="grid grid-cols-4 gap-2">
          {images.slice(1, 5).map((image, index) => (
            <div
              key={index + 1}
              className="relative group cursor-pointer aspect-square overflow-hidden rounded-lg"
              onClick={() => openLightbox(index + 1)}
            >
              <Image
                src={image}
                alt={`${alt} - View ${index + 2}`}
                fill
                className="object-cover hover:scale-105 transition-transform duration-300"
              />
              <div className="absolute inset-0 bg-black/0 group-hover:bg-black/20 transition-all duration-300 flex items-center justify-center opacity-0 group-hover:opacity-100">
                <ZoomIn className="w-4 h-4 text-white" />
              </div>
              {images.length > 5 && index === 3 && (
                <div className="absolute inset-0 bg-black/60 flex items-center justify-center">
                  <span className="text-white font-semibold">+{images.length - 5}</span>
                </div>
              )}
            </div>
          ))}
        </div>
      )}

      <Lightbox
        images={images}
        currentIndex={currentImageIndex}
        isOpen={isLightboxOpen}
        onClose={closeLightbox}
        onNext={nextImage}
        onPrev={prevImage}
           _onKeyDown={handleKeyDown}
        alt={alt}
      />
    </div>
  )
}

// Lightbox component
interface LightboxProps {
  images: string[]
  currentIndex: number
  isOpen: boolean
  onClose: () => void
  onNext: () => void
  onPrev: () => void
  _onKeyDown: (e: KeyboardEvent) => void
  alt: string
}

function Lightbox({
  images,
  currentIndex,
  isOpen,
  onClose,
  onNext,
  onPrev,
  _onKeyDown,
  alt
}: LightboxProps) {
  if (!isOpen) return null

  return (
    <Dialog open={isOpen} onOpenChange={onClose}>
      <DialogContent className="max-w-7xl w-full h-full max-h-screen p-0 bg-black/95">
        <div className="relative w-full h-full flex items-center justify-center">
          {/* Close button */}
          <Button
            variant="ghost"
            size="sm"
            className="absolute top-4 right-4 z-50 text-white hover:bg-white/20"
            onClick={onClose}
          >
            <X className="w-6 h-6" />
          </Button>

          {/* Navigation buttons */}
          {images.length > 1 && (
            <>
              <Button
                variant="ghost"
                size="sm"
                className="absolute left-4 top-1/2 -translate-y-1/2 z-50 text-white hover:bg-white/20"
                onClick={onPrev}
              >
                <ChevronLeft className="w-8 h-8" />
              </Button>
              <Button
                variant="ghost"
                size="sm"
                className="absolute right-4 top-1/2 -translate-y-1/2 z-50 text-white hover:bg-white/20"
                onClick={onNext}
              >
                <ChevronRight className="w-8 h-8" />
              </Button>
            </>
          )}

          {/* Main image */}
          <div className="relative w-full h-full max-w-5xl max-h-full">
            <Image
              src={images[currentIndex]}
              alt={`${alt} - Image ${currentIndex + 1}`}
              fill
              className="object-contain"
              quality={95}
              sizes="(max-width: 768px) 100vw, (max-width: 1200px) 80vw, 70vw"
              priority
            />
          </div>

          {/* Image counter */}
          {images.length > 1 && (
            <div className="absolute bottom-4 left-1/2 -translate-x-1/2 bg-black/60 text-white px-3 py-1 rounded-full text-sm">
              {currentIndex + 1} / {images.length}
            </div>
          )}

          {/* Thumbnail strip */}
          {images.length > 1 && (
            <div className="absolute bottom-20 left-1/2 -translate-x-1/2 flex gap-2 max-w-2xl overflow-x-auto">
              {images.map((image, index) => (
                <button
                  key={index}
                  className={`flex-shrink-0 w-16 h-16 rounded border-2 overflow-hidden ${
                    index === currentIndex ? 'border-white' : 'border-gray-600'
                  }`}
                  onClick={() => {
                    // This would need to be passed down
                  }}
                >
                  <Image
                    src={image}
                    alt={`${alt} - Thumbnail ${index + 1}`}
                    width={64}
                    height={64}
                    className="object-cover w-full h-full"
                  />
                </button>
              ))}
            </div>
          )}
        </div>
      </DialogContent>
    </Dialog>
  )
}