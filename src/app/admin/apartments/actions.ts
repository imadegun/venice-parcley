'use server'

import { revalidatePath } from 'next/cache'
import { z } from 'zod'
import { requireRole } from '@/lib/auth'
import { createServerSupabaseClient } from '@/lib/supabase'

const APARTMENT_IMAGES_BUCKET = 'apartment-images'

const apartmentSchema = z.object({
  slug: z.string().min(2),
  name: z.string().min(2),
  description: z.string().min(10),
  short_description: z.string().optional().default(''),
  base_price_cents: z.coerce.number().int().nonnegative(),
  max_guests: z.coerce.number().int().positive(),
  bedrooms: z.coerce.number().int().nonnegative(),
  amenities: z.string().optional().default(''),
  unified_images: z.object({
    images: z.array(z.string()),
    mainImageIndex: z.number().int().min(0)
  }).optional().default({ images: [], mainImageIndex: 0 }),
  is_active: z.coerce.boolean().optional().default(true),
})

const defaultUnifiedImages = { images: [], mainImageIndex: 0 }

function getStoragePublicMarker() {
  return `/storage/v1/object/public/${APARTMENT_IMAGES_BUCKET}/`
}

function isApartmentStorageUrl(url: string) {
  return url.includes(getStoragePublicMarker())
}

function getStoragePathFromPublicUrl(url: string) {
  try {
    const parsed = new URL(url)
    const marker = `/object/public/${APARTMENT_IMAGES_BUCKET}/`
    const index = parsed.pathname.indexOf(marker)
    if (index === -1) return null
    return decodeURIComponent(parsed.pathname.slice(index + marker.length))
  } catch {
    return null
  }
}

async function ensureApartmentBucketConfig() {
  const supabase = createServerSupabaseClient()

  try {
    // Check if bucket exists and get its config
    const { data: buckets, error: listError } = await supabase.storage.listBuckets()

    if (listError) throw new Error(listError.message)

    const bucketExists = buckets?.some(bucket => bucket.name === APARTMENT_IMAGES_BUCKET)

    if (!bucketExists) {
      // Create bucket with proper settings
      const { error: createError } = await supabase.storage.createBucket(APARTMENT_IMAGES_BUCKET, {
        public: true,
        fileSizeLimit: '50MB',
        allowedMimeTypes: ['image/jpeg', 'image/png', 'image/webp', 'image/gif', 'image/avif'],
      })

      if (createError && !createError.message.toLowerCase().includes('already exists')) {
        throw new Error(createError.message)
      }
    } else {
      // Bucket exists, try to update settings (this might not work with Supabase JS client)
      // For now, we'll just proceed and hope the existing bucket has proper limits
      console.log('Apartment images bucket already exists, using existing configuration')
    }
  } catch (error) {
    console.warn('Could not verify bucket configuration:', error)
  }
}

async function uploadFileToApartmentStorage(file: File, slug: string) {
  // Ensure bucket is properly configured before upload
  await ensureApartmentBucketConfig()

  const supabase = createServerSupabaseClient()
  const extension = file.name.includes('.') ? file.name.split('.').pop() : 'jpg'
  const filePath = `apartments/${slug}/${crypto.randomUUID()}-${Date.now()}.${extension}`

  const uploadOptions = {
    upsert: false,
    cacheControl: '31536000',
    contentType: file.type || 'image/jpeg',
  }

  let { error: uploadError } = await supabase.storage
    .from(APARTMENT_IMAGES_BUCKET)
    .upload(filePath, file, uploadOptions)

  if (uploadError?.message?.toLowerCase().includes('bucket not found')) {
    const { error: createBucketError } = await supabase.storage.createBucket(APARTMENT_IMAGES_BUCKET, {
      public: true,
      fileSizeLimit: '50MB',
      allowedMimeTypes: ['image/jpeg', 'image/png', 'image/webp', 'image/gif', 'image/avif'],
    })

    if (createBucketError && !createBucketError.message.toLowerCase().includes('already exists')) {
      throw new Error(createBucketError.message)
    }

    const retry = await supabase.storage
      .from(APARTMENT_IMAGES_BUCKET)
      .upload(filePath, file, uploadOptions)

    uploadError = retry.error
  }

  if (uploadError) throw new Error(uploadError.message)

  const { data: publicData } = supabase.storage
    .from(APARTMENT_IMAGES_BUCKET)
    .getPublicUrl(filePath)

  return publicData.publicUrl
}

async function migrateExternalImageToStorage(url: string, slug: string) {
  const response = await fetch(url)
  if (!response.ok) {
    throw new Error(`Failed to migrate image from external URL: ${url}`)
  }

  const blob = await response.blob()
  const extensionFromType = blob.type.split('/')[1] || 'jpg'
  const file = new File([blob], `migrated-${Date.now()}.${extensionFromType}`, {
    type: blob.type || 'image/jpeg',
  })

  return uploadFileToApartmentStorage(file, slug)
}

async function ensureStorageImageUrls(images: string[], slug: string) {
  const normalizedSlug = slug || 'apartment'
  const migrated: string[] = []

  for (const url of images) {
    if (isApartmentStorageUrl(url)) {
      migrated.push(url)
      continue
    }
    migrated.push(await migrateExternalImageToStorage(url, normalizedSlug))
  }

  return migrated
}

function parseUnifiedImages(input: FormDataEntryValue | null) {
  if (!input) return defaultUnifiedImages

  try {
    const value = typeof input === 'string' ? JSON.parse(input) : input
    const parsed = apartmentSchema.shape.unified_images.safeParse(value)
    if (!parsed.success) {
      throw new Error(parsed.error.issues[0]?.message || 'Invalid unified_images payload')
    }
    return parsed.data
  } catch {
    throw new Error('Invalid unified_images JSON payload')
  }
}

function parseIsActive(input: FormDataEntryValue | null) {
  if (input === null) return true
  const value = input.toString().toLowerCase().trim()
  return ['true', '1', 'on', 'yes'].includes(value)
}

function toStringArray(input?: string) {
  if (!input) return []
  return input
    .split(',')
    .map((v) => v.trim())
    .filter(Boolean)
}

export async function createApartment(data: FormData | Record<string, unknown>) {
  const formData = data instanceof FormData ? data :
    Object.entries(data).reduce((fd, [key, value]) => {
      if (key === 'unified_images' && typeof value === 'object' && value !== null) {
        fd.append(key, JSON.stringify(value))
      } else {
        fd.append(key, String(value ?? ''))
      }
      return fd
    }, new FormData())
  await requireRole(['admin', 'administrator'])
  const supabase = createServerSupabaseClient()

  const parsed = apartmentSchema.safeParse({
    slug: formData.get('slug'),
    name: formData.get('name'),
    description: formData.get('description'),
    short_description: formData.get('short_description')?.toString(),
    base_price_cents: formData.get('base_price_cents'),
    max_guests: formData.get('max_guests'),
    bedrooms: formData.get('bedrooms'),
    amenities: formData.get('amenities')?.toString(),
    unified_images: parseUnifiedImages(formData.get('unified_images')),
    is_active: parseIsActive(formData.get('is_active')),
  })

  if (!parsed.success) {
    throw new Error(parsed.error.issues[0]?.message || 'Invalid apartment form data')
  }

  const payload = parsed.data
  const storageImages = await ensureStorageImageUrls(payload.unified_images.images, payload.slug)

  const { error } = await supabase.from('apartments').insert({
    slug: payload.slug,
    name: payload.name,
    description: payload.description,
    short_description: payload.short_description || null,
    base_price_cents: payload.base_price_cents,
    max_guests: payload.max_guests,
    bedrooms: payload.bedrooms,
    amenities: toStringArray(payload.amenities),
    gallery_images: storageImages,
    image_url: storageImages[payload.unified_images.mainImageIndex] || null,
    is_active: payload.is_active,
  })

  if (error) throw new Error(error.message)

  revalidatePath('/admin/apartments')
}

export async function updateApartment(data: FormData | Record<string, unknown>) {
  const formData = data instanceof FormData ? data :
    Object.entries(data).reduce((fd, [key, value]) => {
      if (key === 'unified_images' && typeof value === 'object' && value !== null) {
        fd.append(key, JSON.stringify(value))
      } else {
        fd.append(key, String(value ?? ''))
      }
      return fd
    }, new FormData())
  await requireRole(['admin', 'administrator'])
  const supabase = createServerSupabaseClient()
  const id = formData.get('id')?.toString()

  if (!id) throw new Error('Apartment id is required')

  const parsed = apartmentSchema.safeParse({
    slug: formData.get('slug'),
    name: formData.get('name'),
    description: formData.get('description'),
    short_description: formData.get('short_description')?.toString(),
    base_price_cents: formData.get('base_price_cents'),
    max_guests: formData.get('max_guests'),
    bedrooms: formData.get('bedrooms'),
    amenities: formData.get('amenities')?.toString(),
    unified_images: parseUnifiedImages(formData.get('unified_images')),
    is_active: parseIsActive(formData.get('is_active')),
  })

  if (!parsed.success) {
    throw new Error(parsed.error.issues[0]?.message || 'Invalid apartment form data')
  }

  const payload = parsed.data

  const { data: currentApartment } = await supabase
    .from('apartments')
    .select('gallery_images')
    .eq('id', id)
    .single()

  const storageImages = await ensureStorageImageUrls(payload.unified_images.images, payload.slug)

  const removedImages = (currentApartment?.gallery_images || []).filter(
    (url: string) => !storageImages.includes(url)
  )

  const removedPaths = removedImages
    .map((url: string) => getStoragePathFromPublicUrl(url))
    .filter((value: string | null): value is string => Boolean(value))

  if (removedPaths.length > 0) {
    await supabase.storage.from(APARTMENT_IMAGES_BUCKET).remove(removedPaths)
  }

  const { error } = await supabase
    .from('apartments')
    .update({
      slug: payload.slug,
      name: payload.name,
      description: payload.description,
      short_description: payload.short_description || null,
      base_price_cents: payload.base_price_cents,
      max_guests: payload.max_guests,
      bedrooms: payload.bedrooms,
      amenities: toStringArray(payload.amenities),
      gallery_images: storageImages,
      image_url: storageImages[payload.unified_images.mainImageIndex] || null,
      is_active: payload.is_active,
    })
    .eq('id', id)

  if (error) throw new Error(error.message)

  revalidatePath('/admin/apartments')
}

export async function deleteApartment(data: FormData | string) {
  const formData = typeof data === 'string' 
    ? (() => { const fd = new FormData(); fd.append('id', data); return fd; })()
    : data instanceof FormData ? data : 
      Object.entries(data).reduce((fd, [key, value]) => {
        fd.append(key, String(value ?? ''))
        return fd
      }, new FormData())
  await requireRole(['admin', 'administrator'])
  const supabase = createServerSupabaseClient()
  const id = formData.get('id')?.toString()

  if (!id) throw new Error('Apartment id is required')

  const { data: apartment } = await supabase
    .from('apartments')
    .select('gallery_images')
    .eq('id', id)
    .single()

  const storagePaths = (apartment?.gallery_images || [])
    .map((url: string) => getStoragePathFromPublicUrl(url))
    .filter((value: string | null): value is string => Boolean(value))

  if (storagePaths.length > 0) {
    await supabase.storage.from(APARTMENT_IMAGES_BUCKET).remove(storagePaths)
  }

  const { error } = await supabase.from('apartments').delete().eq('id', id)
  if (error) throw new Error(error.message)

  revalidatePath('/admin/apartments')
}

export async function uploadApartmentImages(formData: FormData) {
  await requireRole(['admin', 'administrator'])

  const slug = formData.get('slug')?.toString() || 'apartment'
  const files = formData
    .getAll('files')
    .filter((value): value is File => value instanceof File)

  if (files.length === 0) {
    return { urls: [] as string[] }
  }

  const urls: string[] = []
  for (const file of files) {
    urls.push(await uploadFileToApartmentStorage(file, slug))
  }

  return { urls }
}

export async function deleteApartmentImages(urls: string[]) {
  await requireRole(['admin', 'administrator'])
  const supabase = createServerSupabaseClient()

  const paths = urls
    .map(getStoragePathFromPublicUrl)
    .filter((value): value is string => Boolean(value))

  if (paths.length === 0) return

  const { error } = await supabase.storage.from(APARTMENT_IMAGES_BUCKET).remove(paths)
  if (error?.message?.toLowerCase().includes('bucket not found')) return
  if (error) throw new Error(error.message)
}
