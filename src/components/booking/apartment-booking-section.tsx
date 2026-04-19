'use client'

import { useMemo, useState, useEffect } from 'react'
import { format } from 'date-fns'
import type { Database } from '@/types/database'
import { createClient } from '@/lib/supabase'
import { DateRangePicker } from '@/components/booking/date-range-picker'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { Input } from '@/components/ui/input'
import { Label } from '@/components/ui/label'
import { Textarea } from '@/components/ui/textarea'
import { Button } from '@/components/ui/button'

type Apartment = Database['public']['Tables']['apartments']['Row']

interface ApartmentBookingSectionProps {
  apartmentId: string
}

export function ApartmentBookingSection({ apartmentId }: ApartmentBookingSectionProps) {
  const [apartment, setApartment] = useState<Apartment | null>(null)
  const [selection, setSelection] = useState<{ checkIn: Date; checkOut: Date } | null>(null)
  const [guestName, setGuestName] = useState('')
  const [guestEmail, setGuestEmail] = useState('')
  const [guestPhone, setGuestPhone] = useState('')
  const [totalGuests, setTotalGuests] = useState(1)
  const [specialRequests, setSpecialRequests] = useState('')
  const [submitting, setSubmitting] = useState(false)
  const [error, setError] = useState<string | null>(null)

  // Fetch apartment data
  useEffect(() => {
    fetchApartment()
  }, [apartmentId])

  const fetchApartment = async () => {
    try {
      const supabase = createClient()
      const { data, error } = await supabase
        .from('apartments')
        .select('*')
        .eq('id', apartmentId)
        .single()
      if (error) throw error
      setApartment(data)
    } catch (error) {
      console.error('Error fetching apartment:', error)
    }
  }

  const nights = useMemo(() => {
    if (!selection) return 0
    const ms = selection.checkOut.getTime() - selection.checkIn.getTime()
    return Math.max(1, Math.round(ms / (1000 * 60 * 60 * 24)))
  }, [selection])

  const totalPrice = useMemo(() => {
    if (!selection || !apartment) return 0
    return nights * (apartment.base_price_cents / 100)
  }, [selection, apartment, nights])

  const handleCheckout = async () => {
    if (!selection || !apartment) return

    setError(null)

    if (!guestName.trim() || !guestEmail.trim()) {
      setError('Guest name and email are required.')
      return
    }

    setSubmitting(true)
    try {
      const response = await fetch('/api/booking', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          apartmentId: apartment.id,
          checkInDate: format(selection.checkIn, 'yyyy-MM-dd'),
          checkOutDate: format(selection.checkOut, 'yyyy-MM-dd'),
          totalGuests,
          guestName: guestName.trim(),
          guestEmail: guestEmail.trim(),
          guestPhone: guestPhone.trim() || null,
          specialRequests: specialRequests.trim() || null,
        }),
      })

      const payload = await response.json().catch(() => null)

      if (!response.ok) {
        if (response.status === 401 && payload?.loginUrl) {
          window.location.href = payload.loginUrl
          return
        }
        throw new Error(payload?.error || 'Failed to create booking checkout session')
      }

      if (!payload?.checkoutUrl) {
        throw new Error('Missing Stripe checkout URL')
      }

      window.location.href = payload.checkoutUrl
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Unable to start Stripe checkout')
    } finally {
      setSubmitting(false)
    }
  }

  if (!apartment) {
    return (
      <div className="text-center py-8">
        <p className="text-gray-600">Loading apartment details...</p>
      </div>
    )
  }

  return (
    <div className="space-y-6">
      <Card>
        <CardHeader>
          <CardTitle className="flex items-center gap-2">
            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" className="lucide lucide-calendar"><rect width="18" height="18" x="3" y="4" rx="2" ry="2"/><line x1="16" x2="16" y1="2" y2="6"/><line x1="8" x2="8" y1="2" y2="6"/><line x1="3" x2="21" y1="10" y2="10"/></svg>
            Select Your Dates
          </CardTitle>
        </CardHeader>
        <CardContent>
          <DateRangePicker 
            apartment={apartment} 
            onDateRangeSelect={(checkIn, checkOut) => setSelection({ checkIn, checkOut })}
          />
        </CardContent>
      </Card>

      {selection && (
        <Card>
          <CardHeader>
            <CardTitle>Guest Details & Stripe Checkout</CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <div className="grid gap-4 md:grid-cols-2">
              <div className="space-y-2">
                <Label htmlFor="guest-name">Full name</Label>
                <Input id="guest-name" value={guestName} onChange={(e) => setGuestName(e.target.value)} placeholder="John Doe" />
              </div>

              <div className="space-y-2">
                <Label htmlFor="guest-email">Email</Label>
                <Input id="guest-email" type="email" value={guestEmail} onChange={(e) => setGuestEmail(e.target.value)} placeholder="john@example.com" />
              </div>

              <div className="space-y-2">
                <Label htmlFor="guest-phone">Phone</Label>
                <Input id="guest-phone" value={guestPhone} onChange={(e) => setGuestPhone(e.target.value)} placeholder="+65 9000 0000" />
              </div>

              <div className="space-y-2">
                <Label htmlFor="total-guests">Total guests</Label>
                <Input
                  id="total-guests"
                  type="number"
                  min={1}
                  max={apartment.max_guests}
                  value={totalGuests}
                  onChange={(e) => setTotalGuests(Math.max(1, Number(e.target.value) || 1))}
                />
              </div>
            </div>

            <div className="space-y-2">
              <Label htmlFor="special-requests">Special requests</Label>
              <Textarea id="special-requests" value={specialRequests} onChange={(e) => setSpecialRequests(e.target.value)} placeholder="Airport pickup, late check-in, preferences..." />
            </div>

            <div className="rounded-md border p-4 text-sm text-gray-700 space-y-1">
              <p>
                Stay: {format(selection.checkIn, 'EEE, MMM d, yyyy')} → {format(selection.checkOut, 'EEE, MMM d, yyyy')}
              </p>
              <p>Nights: {nights}</p>
              <p>
                Estimated total: <strong>€{totalPrice.toFixed(2)}</strong>
              </p>
            </div>

            {error && <p className="text-sm text-red-600">{error}</p>}

            <Button onClick={handleCheckout} className="w-full" disabled={submitting}>
              {submitting ? 'Redirecting to Stripe…' : 'Continue to secure Stripe payment'}
            </Button>
          </CardContent>
        </Card>
      )}
    </div>
  )
}

