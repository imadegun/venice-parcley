'use server'

import { revalidatePath } from 'next/cache'
import { z } from 'zod'
import { requireRole } from '@/lib/auth'
import { createServerSupabaseClient } from '@/lib/supabase'

const apartmentSchema = z.object({
  name: z.string().min(2),
  description: z.string().min(10),
  type: z.enum(['artistic_studio', 'design_loft', 'creative_suite', 'artist_residence']),
  address: z.string().min(3),
  city: z.string().min(2),
  country: z.string().min(2),
  price_per_night: z.coerce.number().int().nonnegative(),
  max_guests: z.coerce.number().int().positive(),
  bedrooms: z.coerce.number().int().nonnegative(),
  bathrooms: z.coerce.number().nonnegative(),
  size_sqm: z.coerce.number().int().positive(),
  amenities: z.string().optional().default(''),
  images: z.string().optional().default(''),
  is_available: z.coerce.boolean().optional().default(true),
})

function toStringArray(input?: string) {
  if (!input) return []
  return input
    .split(',')
    .map((v) => v.trim())
    .filter(Boolean)
}

export async function createApartment(formData: FormData) {
  await requireRole(['admin', 'administrator'])
  const supabase = createServerSupabaseClient()

  const parsed = apartmentSchema.safeParse({
    name: formData.get('name'),
    description: formData.get('description'),
    type: formData.get('type'),
    address: formData.get('address'),
    city: formData.get('city'),
    country: formData.get('country'),
    price_per_night: formData.get('price_per_night'),
    max_guests: formData.get('max_guests'),
    bedrooms: formData.get('bedrooms'),
    bathrooms: formData.get('bathrooms'),
    size_sqm: formData.get('size_sqm'),
    amenities: formData.get('amenities')?.toString(),
    images: formData.get('images')?.toString(),
    is_available: formData.get('is_available') === 'on',
  })

  if (!parsed.success) {
    throw new Error(parsed.error.issues[0]?.message || 'Invalid apartment form data')
  }

  const payload = parsed.data

  const { error } = await supabase.from('apartments').insert({
    name: payload.name,
    description: payload.description,
    type: payload.type,
    address: payload.address,
    city: payload.city,
    country: payload.country,
    price_per_night: payload.price_per_night,
    max_guests: payload.max_guests,
    bedrooms: payload.bedrooms,
    bathrooms: payload.bathrooms,
    size_sqm: payload.size_sqm,
    amenities: toStringArray(payload.amenities),
    images: toStringArray(payload.images),
    is_available: payload.is_available,
    owner_id: '00000000-0000-0000-0000-000000000000',
  })

  if (error) throw new Error(error.message)

  revalidatePath('/admin/apartments')
}

export async function updateApartment(formData: FormData) {
  await requireRole(['admin', 'administrator'])
  const supabase = createServerSupabaseClient()
  const id = formData.get('id')?.toString()

  if (!id) throw new Error('Apartment id is required')

  const parsed = apartmentSchema.safeParse({
    name: formData.get('name'),
    description: formData.get('description'),
    type: formData.get('type'),
    address: formData.get('address'),
    city: formData.get('city'),
    country: formData.get('country'),
    price_per_night: formData.get('price_per_night'),
    max_guests: formData.get('max_guests'),
    bedrooms: formData.get('bedrooms'),
    bathrooms: formData.get('bathrooms'),
    size_sqm: formData.get('size_sqm'),
    amenities: formData.get('amenities')?.toString(),
    images: formData.get('images')?.toString(),
    is_available: formData.get('is_available') === 'on',
  })

  if (!parsed.success) {
    throw new Error(parsed.error.issues[0]?.message || 'Invalid apartment form data')
  }

  const payload = parsed.data

  const { error } = await supabase
    .from('apartments')
    .update({
      name: payload.name,
      description: payload.description,
      type: payload.type,
      address: payload.address,
      city: payload.city,
      country: payload.country,
      price_per_night: payload.price_per_night,
      max_guests: payload.max_guests,
      bedrooms: payload.bedrooms,
      bathrooms: payload.bathrooms,
      size_sqm: payload.size_sqm,
      amenities: toStringArray(payload.amenities),
      images: toStringArray(payload.images),
      is_available: payload.is_available,
    })
    .eq('id', id)

  if (error) throw new Error(error.message)

  revalidatePath('/admin/apartments')
}

export async function deleteApartment(formData: FormData) {
  await requireRole(['admin', 'administrator'])
  const supabase = createServerSupabaseClient()
  const id = formData.get('id')?.toString()

  if (!id) throw new Error('Apartment id is required')

  const { error } = await supabase.from('apartments').delete().eq('id', id)
  if (error) throw new Error(error.message)

  revalidatePath('/admin/apartments')
}
