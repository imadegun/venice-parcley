'use server'

import { revalidatePath } from 'next/cache'
import { redirect } from 'next/navigation'
import { z } from 'zod'
import { requireRole } from '@/lib/auth'
import { createServerSupabaseClient } from '@/lib/supabase'

const bookingSchema = z.object({
  user_id: z.string().uuid(),
  apartment_id: z.string().uuid().optional().or(z.literal('')),
  transportation_id: z.string().uuid().optional().or(z.literal('')),
  check_in_date: z.string().optional().or(z.literal('')),
  check_out_date: z.string().optional().or(z.literal('')),
  service_date: z.string().optional().or(z.literal('')),
  service_time: z.string().optional().or(z.literal('')),
  total_guests: z.coerce.number().int().positive().optional(),
  total_cents: z.coerce.number().int().nonnegative(),
  status: z.enum(['pending', 'confirmed', 'cancelled', 'completed']),
  special_requests: z.string().optional().or(z.literal('')),
  contact_info: z.string().optional().default('{}'),
})

function parseContactInfo(input: string) {
  try {
    const parsed = JSON.parse(input || '{}')
    if (parsed && typeof parsed === 'object') return parsed
    return {}
  } catch {
    return {}
  }
}

export async function createBooking(formData: FormData) {
  await requireRole(['admin', 'administrator'])
  const supabase = createServerSupabaseClient()

  const parsed = bookingSchema.safeParse({
    user_id: formData.get('user_id'),
    apartment_id: formData.get('apartment_id')?.toString(),
    transportation_id: formData.get('transportation_id')?.toString(),
    check_in_date: formData.get('check_in_date')?.toString(),
    check_out_date: formData.get('check_out_date')?.toString(),
    service_date: formData.get('service_date')?.toString(),
    service_time: formData.get('service_time')?.toString(),
    total_guests: formData.get('total_guests'),
    total_cents: formData.get('total_cents'),
    status: formData.get('status'),
    special_requests: formData.get('special_requests')?.toString(),
    contact_info: formData.get('contact_info')?.toString(),
  })

  if (!parsed.success) throw new Error(parsed.error.issues[0]?.message || 'Invalid booking data')

  const payload = parsed.data
  const { error } = await supabase.from('bookings').insert({
    user_id: payload.user_id,
    apartment_id: payload.apartment_id || null,
    transportation_id: payload.transportation_id || null,
    check_in_date: payload.check_in_date || null,
    check_out_date: payload.check_out_date || null,
    service_date: payload.service_date || null,
    service_time: payload.service_time || null,
    total_guests: payload.total_guests || null,
    total_cents: payload.total_cents,
    status: payload.status,
    special_requests: payload.special_requests || null,
    contact_info: parseContactInfo(payload.contact_info),
  })

  if (error) throw new Error(error.message)
  revalidatePath('/admin/bookings')
}

export async function updateBooking(formData: FormData) {
  await requireRole(['admin', 'administrator'])
  const supabase = createServerSupabaseClient()
  const id = formData.get('id')?.toString()
  if (!id) throw new Error('Booking id is required')

  const parsed = bookingSchema.safeParse({
    user_id: formData.get('user_id'),
    apartment_id: formData.get('apartment_id')?.toString(),
    transportation_id: formData.get('transportation_id')?.toString(),
    check_in_date: formData.get('check_in_date')?.toString(),
    check_out_date: formData.get('check_out_date')?.toString(),
    service_date: formData.get('service_date')?.toString(),
    service_time: formData.get('service_time')?.toString(),
    total_guests: formData.get('total_guests'),
    total_cents: formData.get('total_cents'),
    status: formData.get('status'),
    special_requests: formData.get('special_requests')?.toString(),
    contact_info: formData.get('contact_info')?.toString(),
  })

  if (!parsed.success) throw new Error(parsed.error.issues[0]?.message || 'Invalid booking data')

  const payload = parsed.data
  const { error } = await supabase
    .from('bookings')
    .update({
      user_id: payload.user_id,
      apartment_id: payload.apartment_id || null,
      transportation_id: payload.transportation_id || null,
      check_in_date: payload.check_in_date || null,
      check_out_date: payload.check_out_date || null,
      service_date: payload.service_date || null,
      service_time: payload.service_time || null,
      total_guests: payload.total_guests || null,
      total_cents: payload.total_cents,
      status: payload.status,
      special_requests: payload.special_requests || null,
      contact_info: parseContactInfo(payload.contact_info),
    })
    .eq('id', id)

  if (error) throw new Error(error.message)
  revalidatePath('/admin/bookings')
}

export async function updateBookingStatus(formData: FormData) {
  await requireRole(['admin', 'administrator'])
  const supabase = createServerSupabaseClient()
  const bookingId = formData.get('bookingId')?.toString()
  const status = formData.get('status')?.toString()

  if (!bookingId) throw new Error('Booking ID is required')
  if (!status || !['pending', 'confirmed', 'cancelled', 'completed'].includes(status)) {
    throw new Error('Valid status is required')
  }

  const { error } = await supabase
    .from('bookings')
    .update({
      status: status as any,
      updated_at: new Date().toISOString()
    })
    .eq('id', bookingId)

  if (error) throw new Error(error.message)

  // Force revalidation and redirect to ensure UI updates
  revalidatePath('/admin/bookings')
  redirect('/admin/bookings')
}

export async function deleteBooking(formData: FormData) {
  await requireRole(['admin', 'administrator'])
  const supabase = createServerSupabaseClient()
  const id = formData.get('id')?.toString()
  if (!id) throw new Error('Booking id is required')

  const { error } = await supabase.from('bookings').delete().eq('id', id)
  if (error) throw new Error(error.message)

  revalidatePath('/admin/bookings')
}
