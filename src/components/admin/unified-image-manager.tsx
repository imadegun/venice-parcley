'use client'

import { useState, useCallback, useRef } from 'react'
import { Upload, X, Image as ImageIcon, Star, StarOff } from 'lucide-react'
import { Button } from '@/components/ui/button'
import { Card } from '@/components/ui/card'
import { cn } from '@/lib/utils'

interface UnifiedImageManagerProps {
  value: {
    images: string[]
    mainImageIndex: number
  }
  onChange: (data: { images: string[], mainImageIndex: number }) => void
  maxFiles?: number
  accept?: string
}

export function UnifiedImageManager({
  value = { images: [], mainImageIndex: 0 },
  onChange,
  maxFiles = 10,
  accept = 'image/*'
}: UnifiedImageManagerProps) {
  const [isDragging, setIsDragging] = useState(false)
  const [uploading, setUploading] = useState(false)
  const fileInputRef = useRef<HTMLInputElement>(null)

  const { images, mainImageIndex } = value

  const handleDragOver = useCallback((e: React.DragEvent) => {
    e.preventDefault()
    setIsDragging(true)
  }, [])

  const handleDragLeave = useCallback((e: React.DragEvent) => {
    e.preventDefault()
    setIsDragging(false)
  }, [])

  const handleDrop = useCallback((e: React.DragEvent) => {
    e.preventDefault()
    setIsDragging(false)
    const files = Array.from(e.dataTransfer.files)
    handleFiles(files)
  }, [])

  const handleFileSelect = (e: React.ChangeEvent<HTMLInputElement>) => {
    if (e.target.files) {
      const files = Array.from(e.target.files)
      handleFiles(files)
    }
  }

  const handleFiles = async (files: File[]) => {
    setUploading(true)
    // TODO: Implement actual file upload to storage
    // For now, create object URLs
    const newUrls = files.map(file => URL.createObjectURL(file))
    const updatedImages = [...images, ...newUrls].slice(0, maxFiles)
    onChange({
      images: updatedImages,
      mainImageIndex: images.length === 0 ? 0 : Math.min(mainImageIndex, updatedImages.length - 1)
    })
    setUploading(false)
  }

  const removeImage = (index: number) => {
    const updatedImages = images.filter((_, i) => i !== index)
    let newMainIndex = mainImageIndex

    // Adjust main image index if necessary
    if (mainImageIndex === index) {
      newMainIndex = 0
    } else if (mainImageIndex > index) {
      newMainIndex = mainImageIndex - 1
    }

    onChange({
      images: updatedImages,
      mainImageIndex: newMainIndex
    })
  }

  const setMainImage = (index: number) => {
    onChange({
      images,
      mainImageIndex: index
    })
  }

  return (
    <div className="space-y-6">
      {/* Upload Zone */}
      <div
        onDragOver={handleDragOver}
        onDragLeave={handleDragLeave}
        onDrop={handleDrop}
        className={cn(
          "border-2 border-dashed rounded-lg p-8 transition-colors text-center",
          isDragging ? "border-primary bg-primary/5" : "border-gray-300 hover:border-gray-400"
        )}
      >
        <div className="flex flex-col items-center gap-2">
          <Upload className="h-12 w-12 text-gray-400" />
          <h3 className="text-lg font-medium">Drag and drop images here</h3>
          <p className="text-sm text-gray-600">
            or click to select files
          </p>
          <input
            ref={fileInputRef}
            type="file"
            multiple
            accept={accept}
            onChange={handleFileSelect}
            className="hidden"
          />
          <Button
            variant="secondary"
            onClick={() => fileInputRef.current?.click()}
            disabled={uploading || images.length >= maxFiles}
          >
            {uploading ? <Upload className="mr-2 h-4 w-4 animate-spin" /> : <Upload className="mr-2 h-4 w-4" />}
            Choose Files
          </Button>
          <p className="text-xs text-gray-400">
            Supports: JPG, PNG, WebP. Max {maxFiles} images.
          </p>
        </div>
      </div>

      {/* Images Grid */}
      {images.length > 0 && (
        <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4">
          {images.map((url, index) => (
            <Card key={index} className={cn(
              "relative group overflow-hidden aspect-square",
              mainImageIndex === index && "ring-2 ring-yellow-400 ring-offset-2"
            )}>
              <img
                src={url}
                alt={`Image ${index + 1}`}
                className="w-full h-full object-cover cursor-pointer"
                onClick={() => setMainImage(index)}
              />

              {/* Overlay */}
              <div className="absolute inset-0 bg-black/50 opacity-0 group-hover:opacity-100 transition-opacity flex items-center justify-center gap-2">
                <Button
                  variant="secondary"
                  size="icon"
                  onClick={() => setMainImage(index)}
                  className="h-8 w-8 bg-white/90 hover:bg-white"
                  title={mainImageIndex === index ? "Main image" : "Set as main image"}
                >
                  {mainImageIndex === index ? (
                    <Star className="h-4 w-4 text-yellow-500 fill-yellow-500" />
                  ) : (
                    <StarOff className="h-4 w-4 text-gray-600" />
                  )}
                </Button>
                <Button
                  variant="destructive"
                  size="icon"
                  onClick={() => removeImage(index)}
                  className="h-8 w-8"
                >
                  <X className="h-4 w-4" />
                </Button>
              </div>

              {/* Main Image Badge */}
              {mainImageIndex === index && (
                <div className="absolute top-2 left-2 bg-yellow-400 text-yellow-900 text-xs font-medium px-2 py-1 rounded-full flex items-center gap-1">
                  <Star className="h-3 w-3 fill-current" />
                  Main
                </div>
              )}

              {/* Image Number */}
              <div className="absolute bottom-2 right-2 bg-black/70 text-white text-xs font-medium px-2 py-1 rounded">
                {index + 1}
              </div>
            </Card>
          ))}

          {/* Add More Card */}
          {images.length < maxFiles && (
            <Card className="border-dashed border-2 hover:border-blue-400 transition-colors aspect-square">
              <div className="w-full h-full flex items-center justify-center">
                <Button
                  variant="ghost"
                  onClick={() => fileInputRef.current?.click()}
                  disabled={uploading}
                  className="flex flex-col items-center gap-2 text-gray-500 hover:text-gray-700"
                >
                  <Upload className="h-8 w-8" />
                  <span className="text-sm">Add more</span>
                </Button>
              </div>
            </Card>
          )}
        </div>
      )}

      {/* Stats */}
      <div className="flex items-center justify-between text-sm text-gray-600">
        <span>{images.length} of {maxFiles} images uploaded</span>
        {images.length > 0 && (
          <span>Main image: #{mainImageIndex + 1} (click any image or star icon to change)</span>
        )}
      </div>
    </div>
  )
}
