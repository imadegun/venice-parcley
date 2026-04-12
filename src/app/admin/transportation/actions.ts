'use server'

import { revalidatePath } from 'next/cache'
import { z } from 'zod'
import { requireRole } from '@/lib/auth'
import { createServerSupabaseClient } from '@/lib/supabase'

const transportationSchema = z.object({
  name: z.string().min(2),
  type: z.enum(['car', 'taxi', 'chauffeur', 'airport_transfer']),
  description: z.string().min(10),
  base_price: z.coerce.number().nonnegative(),
  price_per_km: z.coerce.number().nonnegative(),
  price_per_hour: z.coerce.number().nonnegative(),
  max_passengers: z.coerce.number().int().positive(),
  provider_id: z.string().uuid(),
  is_available: z.coerce.boolean().optional().default(true),
})

export async function createTransportationService(formData: FormData) {
  await requireRole(['admin', 'administrator'])
  const supabase = createServerSupabaseClient()

  const parsed = transportationSchema.safeParse({
    name: formData.get('name'),
    type: formData.get('type'),
    description: formData.get('description'),
    base_price: formData.get('base_price'),
    price_per_km: formData.get('price_per_km'),
    price_per_hour: formData.get('price_per_hour'),
    max_passengers: formData.get('max_passengers'),
    provider_id: formData.get('provider_id'),
    is_available: formData.get('is_available') === 'on',
  })

  if (!parsed.success) {
    throw new Error(parsed.error.issues[0]?.message || 'Invalid transportation service data')
  }

  const { error } = await supabase.from('transportation_services').insert(parsed.data)
  if (error) throw new Error(error.message)

  revalidatePath('/admin/transportation')
}

export async function updateTransportationService(formData: FormData) {
  await requireRole(['admin', 'administrator'])
  const supabase = createServerSupabaseClient()
  const id = formData.get('id')?.toString()

  if (!id) throw new Error('Transportation service id is required')

  const parsed = transportationSchema.safeParse({
    name: formData.get('name'),
    type: formData.get('type'),
    description: formData.get('description'),
    base_price: formData.get('base_price'),
    price_per_km: formData.get('price_per_km'),
    price_per_hour: formData.get('price_per_hour'),
    max_passengers: formData.get('max_passengers'),
    provider_id: formData.get('provider_id'),
    is_available: formData.get('is_available') === 'on',
  })

  if (!parsed.success) {
    throw new Error(parsed.error.issues[0]?.message || 'Invalid transportation service data')
  }

  const { error } = await supabase
    .from('transportation_services')
    .update(parsed.data)
    .eq('id', id)

  if (error) throw new Error(error.message)

  revalidatePath('/admin/transportation')
}

export async function deleteTransportationService(formData: FormData) {
  await requireRole(['admin', 'administrator'])
  const supabase = createServerSupabaseClient()
  const id = formData.get('id')?.toString()

  if (!id) throw new Error('Transportation service id is required')

  const { error } = await supabase.from('transportation_services').delete().eq('id', id)
  if (error) throw new Error(error.message)

  revalidatePath('/admin/transportation')
}
