'use server'

import { revalidatePath } from 'next/cache'
import { z } from 'zod'
import { requireRole } from '@/lib/auth'
import { createServerSupabaseClient } from '@/lib/supabase'

const apartmentSchema = z.object({
  slug: z.string().min(2),
  name: z.string().min(2),
  description: z.string().min(10),
  short_description: z.string().optional().default(''),
  category: z.enum(['artistic_studio', 'design_loft', 'creative_suite', 'artist_residence']),
  base_price_cents: z.coerce.number().int().nonnegative(),
  max_guests: z.coerce.number().int().positive(),
  bedrooms: z.coerce.number().int().nonnegative(),
  bathrooms: z.coerce.number().nonnegative(),
  size_sqm: z.coerce.number().int().positive(),
  amenities: z.string().optional().default(''),
  gallery_images: z.string().optional().default(''),
  artistic_features: z.string().optional().default(''),
  image_url: z.string().optional().default(''),
  is_active: z.coerce.boolean().optional().default(true),
})

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
      fd.append(key, String(value ?? ''))
      return fd
    }, new FormData())
  await requireRole(['admin', 'administrator'])
  const supabase = createServerSupabaseClient()

  const parsed = apartmentSchema.safeParse({
    slug: formData.get('slug'),
    name: formData.get('name'),
    description: formData.get('description'),
    short_description: formData.get('short_description')?.toString(),
    category: formData.get('category'),
    base_price_cents: formData.get('base_price_cents'),
    max_guests: formData.get('max_guests'),
    bedrooms: formData.get('bedrooms'),
    bathrooms: formData.get('bathrooms'),
    size_sqm: formData.get('size_sqm'),
    amenities: formData.get('amenities')?.toString(),
    gallery_images: formData.get('gallery_images')?.toString(),
    artistic_features: formData.get('artistic_features')?.toString(),
    image_url: formData.get('image_url')?.toString(),
    is_active: formData.get('is_active') === 'on',
  })

  if (!parsed.success) {
    throw new Error(parsed.error.issues[0]?.message || 'Invalid apartment form data')
  }

  const payload = parsed.data

  const { error } = await supabase.from('apartments').insert({
    slug: payload.slug,
    name: payload.name,
    description: payload.description,
    short_description: payload.short_description || null,
    category: payload.category,
    base_price_cents: payload.base_price_cents,
    max_guests: payload.max_guests,
    bedrooms: payload.bedrooms,
    bathrooms: payload.bathrooms,
    size_sqm: payload.size_sqm,
    amenities: toStringArray(payload.amenities),
    gallery_images: toStringArray(payload.gallery_images),
    artistic_features: toStringArray(payload.artistic_features),
    image_url: payload.image_url || null,
    is_active: payload.is_active,
  })

  if (error) throw new Error(error.message)

  revalidatePath('/admin/apartments')
}

export async function updateApartment(data: FormData | Record<string, unknown>) {
  const formData = data instanceof FormData ? data : 
    Object.entries(data).reduce((fd, [key, value]) => {
      fd.append(key, String(value ?? ''))
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
    category: formData.get('category'),
    base_price_cents: formData.get('base_price_cents'),
    max_guests: formData.get('max_guests'),
    bedrooms: formData.get('bedrooms'),
    bathrooms: formData.get('bathrooms'),
    size_sqm: formData.get('size_sqm'),
    amenities: formData.get('amenities')?.toString(),
    gallery_images: formData.get('gallery_images')?.toString(),
    artistic_features: formData.get('artistic_features')?.toString(),
    image_url: formData.get('image_url')?.toString(),
    is_active: formData.get('is_active') === 'on',
  })

  if (!parsed.success) {
    throw new Error(parsed.error.issues[0]?.message || 'Invalid apartment form data')
  }

  const payload = parsed.data

  const { error } = await supabase
    .from('apartments')
    .update({
      slug: payload.slug,
      name: payload.name,
      description: payload.description,
      short_description: payload.short_description || null,
      category: payload.category,
      base_price_cents: payload.base_price_cents,
      max_guests: payload.max_guests,
      bedrooms: payload.bedrooms,
      bathrooms: payload.bathrooms,
      size_sqm: payload.size_sqm,
      amenities: toStringArray(payload.amenities),
      gallery_images: toStringArray(payload.gallery_images),
      artistic_features: toStringArray(payload.artistic_features),
      image_url: payload.image_url || null,
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

  const { error } = await supabase.from('apartments').delete().eq('id', id)
  if (error) throw new Error(error.message)

  revalidatePath('/admin/apartments')
}
