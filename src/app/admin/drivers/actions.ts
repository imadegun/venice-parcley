'use server'

import { revalidatePath } from 'next/cache'
import { z } from 'zod'
import { requireRole } from '@/lib/auth'
import { createServerSupabaseClient } from '@/lib/supabase'

const driverSchema = z.object({
  name: z.string().min(2),
  bio: z.string().min(10).optional().or(z.literal('')),
  image_url: z.string().url().optional().or(z.literal('')),
  license_number: z.string().min(3).optional().or(z.literal('')),
  specialties: z.string().optional().default(''),
  is_active: z.coerce.boolean().optional().default(true),
})

function splitCommaList(input?: string) {
  if (!input) return []
  return input.split(',').map(v => v.trim()).filter(Boolean)
}

export async function createDriver(formData: FormData) {
  await requireRole(['admin', 'administrator'])
  const supabase = createServerSupabaseClient()

  const parsed = driverSchema.safeParse({
    name: formData.get('name'),
    bio: formData.get('bio')?.toString(),
    image_url: formData.get('image_url')?.toString(),
    license_number: formData.get('license_number')?.toString(),
    specialties: formData.get('specialties')?.toString(),
    is_active: formData.get('is_active') === 'on',
  })

  if (!parsed.success) throw new Error(parsed.error.issues[0]?.message || 'Invalid driver data')
  const payload = parsed.data

  const { error } = await supabase.from('drivers').insert({
    name: payload.name,
    bio: payload.bio || null,
    image_url: payload.image_url || null,
    license_number: payload.license_number || null,
    specialties: splitCommaList(payload.specialties),
    is_active: payload.is_active,
  })

  if (error) throw new Error(error.message)
  revalidatePath('/admin/drivers')
}

export async function updateDriver(formData: FormData) {
  await requireRole(['admin', 'administrator'])
  const supabase = createServerSupabaseClient()
  const id = formData.get('id')?.toString()
  if (!id) throw new Error('Driver id is required')

  const parsed = driverSchema.safeParse({
    name: formData.get('name'),
    bio: formData.get('bio')?.toString(),
    image_url: formData.get('image_url')?.toString(),
    license_number: formData.get('license_number')?.toString(),
    specialties: formData.get('specialties')?.toString(),
    is_active: formData.get('is_active') === 'on',
  })

  if (!parsed.success) throw new Error(parsed.error.issues[0]?.message || 'Invalid driver data')
  const payload = parsed.data

  const { error } = await supabase
    .from('drivers')
    .update({
      name: payload.name,
      bio: payload.bio || null,
      image_url: payload.image_url || null,
      license_number: payload.license_number || null,
      specialties: splitCommaList(payload.specialties),
      is_active: payload.is_active,
    })
    .eq('id', id)

  if (error) throw new Error(error.message)
  revalidatePath('/admin/drivers')
}

export async function deleteDriver(formData: FormData) {
  await requireRole(['admin', 'administrator'])
  const supabase = createServerSupabaseClient()
  const id = formData.get('id')?.toString()
  if (!id) throw new Error('Driver id is required')

  const { error } = await supabase.from('drivers').delete().eq('id', id)
  if (error) throw new Error(error.message)

  revalidatePath('/admin/drivers')
}
