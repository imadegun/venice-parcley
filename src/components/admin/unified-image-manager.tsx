'use client'

import { useState, useCallback, useRef } from 'react'
import { Upload, X, GripVertical, Star, Loader2 } from 'lucide-react'
import { Button } from '@/components/ui/button'
import { Card } from '@/components/ui/card'
import { cn } from '@/lib/utils'
import { deleteApartmentImages, uploadApartmentImages } from '@/app/admin/apartments/actions'

interface UnifiedImageManagerProps {
  value: {
    images: string[]
    mainImageIndex: number
  }
  onChange: (data: { images: string[], mainImageIndex: number }) => void
  slug?: string
  maxFiles?: number
  accept?: string
}

export function UnifiedImageManager({
  value = { images: [], mainImageIndex: 0 },
  onChange,
  slug,
  maxFiles = 10,
  accept = 'image/*'
}: UnifiedImageManagerProps) {
  const [isDragging, setIsDragging] = useState(false)
  const [uploading, setUploading] = useState(false)
  const [deletingIndex, setDeletingIndex] = useState<number | null>(null)
  const [hoveredIndex, setHoveredIndex] = useState<number | null>(null)
  const [draggedIndex, setDraggedIndex] = useState<number | null>(null)
  const fileInputRef = useRef<HTMLInputElement>(null)

  const { images, mainImageIndex } = value
  const previewIndex = hoveredIndex ?? mainImageIndex
  const previewImage = images[previewIndex]

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
    void handleFiles(files)
  }, [images, mainImageIndex])

  const handleFileSelect = (e: React.ChangeEvent<HTMLInputElement>) => {
    if (e.target.files) {
      const files = Array.from(e.target.files)
      void handleFiles(files)
    }
  }

  const handleFiles = async (files: File[]) => {
    if (files.length === 0) return

    // Validate file sizes
    const maxSizeBytes = 50 * 1024 * 1024 // 50MB
    const oversizedFiles = files.filter(file => file.size > maxSizeBytes)

    if (oversizedFiles.length > 0) {
      alert(`Some files are too large. Maximum file size is 50MB. Large files: ${oversizedFiles.map(f => f.name).join(', ')}`)
      return
    }

    // Warn about large files
    const largeFiles = files.filter(file => file.size > 2 * 1024 * 1024) // 2MB
    if (largeFiles.length > 0) {
      const proceed = confirm(`Some files are larger than 2MB (${largeFiles.map(f => `${f.name}: ${(f.size / 1024 / 1024).toFixed(1)}MB`).join(', ')}). This may affect page load speed. Continue?`)
      if (!proceed) return
    }

    setUploading(true)
    try {
      const remainingSlots = Math.max(0, maxFiles - images.length)
      const filesToUpload = files.slice(0, remainingSlots)
      if (filesToUpload.length === 0) return

      const uploadedUrls: string[] = []
      for (const file of filesToUpload) {
        const formData = new FormData()
        formData.append('slug', (slug || 'apartment').trim())
        formData.append('files', file)
        const { urls } = await uploadApartmentImages(formData)
        uploadedUrls.push(...urls)
      }

      const updatedImages = [...images, ...uploadedUrls].slice(0, maxFiles)

      onChange({
        images: updatedImages,
        mainImageIndex: images.length === 0 ? 0 : Math.min(mainImageIndex, updatedImages.length - 1)
      })
    } finally {
      setUploading(false)
    }
  }

  const removeImage = async (index: number) => {
    const imageToDelete = images[index]
    if (!imageToDelete) return

    setDeletingIndex(index)
    try {
      await deleteApartmentImages([imageToDelete])

      const updatedImages = images.filter((_, i) => i !== index)
      let newMainIndex = mainImageIndex

      if (mainImageIndex === index) {
        newMainIndex = 0
      } else if (mainImageIndex > index) {
        newMainIndex = mainImageIndex - 1
      }

      onChange({
        images: updatedImages,
        mainImageIndex: updatedImages.length === 0 ? 0 : Math.min(newMainIndex, updatedImages.length - 1)
      })
    } finally {
      setDeletingIndex(null)
    }
  }

  const setMainImage = (index: number) => {
    onChange({
      images,
      mainImageIndex: index
    })
  }

  const moveImage = (fromIndex: number, toIndex: number) => {
    if (fromIndex === toIndex) return

    const reordered = [...images]
    const [moved] = reordered.splice(fromIndex, 1)
    reordered.splice(toIndex, 0, moved)

    let nextMainIndex = mainImageIndex
    if (mainImageIndex === fromIndex) {
      nextMainIndex = toIndex
    } else if (fromIndex < mainImageIndex && toIndex >= mainImageIndex) {
      nextMainIndex -= 1
    } else if (fromIndex > mainImageIndex && toIndex <= mainImageIndex) {
      nextMainIndex += 1
    }

    onChange({
      images: reordered,
      mainImageIndex: nextMainIndex
    })
  }

  return (
    <div className="space-y-6">
      {images.length > 0 && previewImage && (
        <div className="relative overflow-hidden rounded-lg border bg-black/5 w-32 h-20">
          <img
            key={`${previewImage}-${previewIndex}`}
            src={previewImage}
            alt={`Main preview ${previewIndex + 1}`}
            className="w-full h-full object-cover"
          />
          <div className="absolute bottom-1 left-1 bg-black/70 text-white text-xs px-1 py-0.5 rounded">
            #{previewIndex + 1}
          </div>
        </div>
      )}

      <div
        onDragOver={handleDragOver}
        onDragLeave={handleDragLeave}
        onDrop={handleDrop}
        className={cn(
          'border-2 border-dashed rounded-lg p-8 transition-colors text-center',
          isDragging ? 'border-primary bg-primary/5' : 'border-gray-300 hover:border-gray-400'
        )}
      >
        <div className="flex flex-col items-center gap-2">
          <Upload className="h-12 w-12 text-gray-400" />
          <h3 className="text-lg font-medium">Drag and drop images here</h3>
          <p className="text-sm text-gray-600">or click to select files</p>
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
            onClick={(e) => { e.preventDefault(); fileInputRef.current?.click() }}
            disabled={uploading || images.length >= maxFiles}
          >
            {uploading ? <Loader2 className="mr-2 h-4 w-4 animate-spin" /> : <Upload className="mr-2 h-4 w-4" />}
            Choose Files
          </Button>
          <div className="text-xs text-gray-400 space-y-1">
            <p>Supports: JPG, PNG, WebP, GIF, AVIF. Max {maxFiles} images.</p>
            <p>Recommended sizes: Hero images 1920×1080px (max 2MB), Thumbnails 800×600px (max 500KB)</p>
          </div>
        </div>
      </div>

      {images.length > 0 && (
        <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4">
          {images.map((url, index) => (
            <Card
              key={`${url}-${index}`}
              draggable
              onDragStart={() => setDraggedIndex(index)}
              onDragOver={(e) => e.preventDefault()}
              onDrop={() => {
                if (draggedIndex === null) return
                moveImage(draggedIndex, index)
                setDraggedIndex(null)
              }}
              onDragEnd={() => setDraggedIndex(null)}
              onMouseEnter={() => setHoveredIndex(index)}
              onMouseLeave={() => setHoveredIndex(null)}
              className={cn(
                'relative group overflow-hidden aspect-square',
                mainImageIndex === index && 'ring-2 ring-yellow-400 ring-offset-2',
                draggedIndex === index && 'opacity-60 scale-[0.98]'
              )}
            >
              <img
                src={url}
                alt={`Image ${index + 1}`}
                className="w-full h-full object-cover cursor-pointer transition-transform duration-500 group-hover:scale-105"
                onClick={() => setMainImage(index)}
              />

              <div className="absolute inset-0 bg-black/50 opacity-0 group-hover:opacity-100 transition-opacity flex items-center justify-center gap-2">
                <Button
                  variant="secondary"
                  size="icon"
                  onClick={() => setMainImage(index)}
                  className="h-8 w-8 bg-white/90 hover:bg-white"
                  title={mainImageIndex === index ? 'Main image' : 'Set as main image'}
                >
                  <Star className={cn('h-4 w-4', mainImageIndex === index ? 'text-yellow-500 fill-yellow-500' : 'text-gray-600')} />
                </Button>
                <Button
                  variant="destructive"
                  size="icon"
                  onClick={() => void removeImage(index)}
                  className="h-8 w-8"
                  disabled={deletingIndex === index}
                >
                  {deletingIndex === index ? <Loader2 className="h-4 w-4 animate-spin" /> : <X className="h-4 w-4" />}
                </Button>
              </div>

              <div className="absolute top-2 right-2 bg-black/65 text-white text-[10px] px-2 py-1 rounded-full flex items-center gap-1">
                <GripVertical className="h-3 w-3" /> Drag
              </div>

              {mainImageIndex === index && (
                <div className="absolute top-2 left-2 bg-yellow-400 text-yellow-900 text-xs font-medium px-2 py-1 rounded-full flex items-center gap-1">
                  <Star className="h-3 w-3 fill-current" />
                  Main
                </div>
              )}

              <div className="absolute bottom-2 right-2 bg-black/70 text-white text-xs font-medium px-2 py-1 rounded">
                {index + 1}
              </div>
            </Card>
          ))}

          {images.length < maxFiles && (
            <Card className="border-dashed border-2 hover:border-blue-400 transition-colors aspect-square">
              <div className="w-full h-full flex items-center justify-center">
                  <Button
                    variant="ghost"
                    onClick={(e) => { e.preventDefault(); fileInputRef.current?.click() }}
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

      <div className="flex items-center justify-between text-sm text-gray-600">
        <span>{images.length} of {maxFiles} images uploaded</span>
        {images.length > 0 && (
          <span>Main image: #{mainImageIndex + 1} (drag to reorder, hover thumbnail to preview)</span>
        )}
      </div>


    </div>
  )
}
