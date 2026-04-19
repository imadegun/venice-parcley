'use client'

import { useState, useEffect } from 'react'
import { format, addDays, isSameDay, isToday, isTomorrow, differenceInDays } from 'date-fns'
import { Calendar, Home, Users, Euro } from 'lucide-react'
import { Button } from '@/components/ui/button'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'

import { createClient } from '@/lib/supabase'
import type { Database } from '@/types/database'

type Apartment = Database['public']['Tables']['apartments']['Row']

interface AvailabilityCheckerProps {
  apartmentId: string
  onBookingSelect: (checkIn: Date, checkOut: Date, apartment: Apartment, totalPrice: number) => void
}

export function AvailabilityChecker({ apartmentId, onBookingSelect }: AvailabilityCheckerProps) {
  const [checkInDate, setCheckInDate] = useState<Date>(new Date())
  const [checkOutDate, setCheckOutDate] = useState<Date>(addDays(new Date(), 1))
  const [apartment, setApartment] = useState<Apartment | null>(null)
  const [loading, setLoading] = useState(false)
  const [checkingAvailability, setCheckingAvailability] = useState(false)
  const supabase = createClient()

  // Generate next 30 days for date selection
  const availableDates = Array.from({ length: 30 }, (_, i) => addDays(new Date(), i))

  useEffect(() => {
    loadApartment()
  }, [apartmentId])

  const loadApartment = async () => {
    setLoading(true)
    try {
      const { data, error } = await supabase
        .from('apartments')
        .select('*')
        .eq('id', apartmentId)
        .single()

      if (error) throw error
      setApartment(data)
    } catch (error) {
      console.error('Error loading apartment:', error)
    } finally {
      setLoading(false)
    }
  }

  const checkAvailability = async () => {
    if (!apartment) return false

    setCheckingAvailability(true)
    try {
      // Check if apartment is booked during selected dates
      const { data: bookings, error } = await supabase
        .from('bookings')
        .select('*')
        .eq('apartment_id', apartmentId)
        .eq('status', 'confirmed')
        .or(`and(check_in_date.lte.${format(checkOutDate, 'yyyy-MM-dd')},check_out_date.gte.${format(checkInDate, 'yyyy-MM-dd')})`)

      if (error) throw error

      return !bookings || bookings.length === 0
    } catch (error) {
      console.error('Error checking availability:', error)
      return false
    } finally {
      setCheckingAvailability(false)
    }
  }

  const calculateTotalPrice = () => {
    if (!apartment) return 0
    const nights = differenceInDays(checkOutDate, checkInDate)
    return nights * (apartment.base_price_cents / 100)
  }

  const handleBookingSelect = async () => {
    if (!apartment) return

    const isAvailable = await checkAvailability()
    if (!isAvailable) {
      alert('This apartment is not available for the selected dates.')
      return
    }

    const totalPrice = calculateTotalPrice()
    onBookingSelect(checkInDate, checkOutDate, apartment, totalPrice)
  }

  const formatDateLabel = (date: Date) => {
    if (isToday(date)) return 'Today'
    if (isTomorrow(date)) return 'Tomorrow'
    return format(date, 'EEE, MMM d')
  }

  if (loading) {
    return (
      <div className="text-center py-8">
        <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-blue-600 mx-auto"></div>
        <p className="text-gray-600 mt-2">Loading apartment details...</p>
      </div>
    )
  }

  if (!apartment) {
    return (
      <div className="text-center py-8">
        <Home className="h-12 w-12 text-gray-400 mx-auto mb-4" />
        <p className="text-gray-600">Apartment not found.</p>
      </div>
    )
  }

  const nights = differenceInDays(checkOutDate, checkInDate)
  const totalPrice = calculateTotalPrice()

  return (
    <div className="space-y-6">
      {/* Check-in Date Selection */}
      <Card>
        <CardHeader>
          <CardTitle className="flex items-center gap-2">
            <Calendar className="h-5 w-5" />
            Check-in Date
          </CardTitle>
        </CardHeader>
        <CardContent>
          <div className="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-5 gap-2">
            {availableDates.map((date) => (
              <Button
                key={`checkin-${date.toISOString()}`}
                variant={isSameDay(date, checkInDate) ? "default" : "outline"}
                className="h-auto py-3 px-2 flex flex-col items-center"
                onClick={() => {
                  setCheckInDate(date)
                  if (checkOutDate <= date) {
                    setCheckOutDate(addDays(date, 1))
                  }
                }}
                disabled={date < new Date()}
              >
                <span className="text-sm font-medium">{format(date, 'd')}</span>
                <span className="text-xs">{format(date, 'EEE')}</span>
              </Button>
            ))}
          </div>
          <p className="text-sm text-gray-600 mt-2">
            Check-in: {formatDateLabel(checkInDate)} ({format(checkInDate, 'MMMM d, yyyy')})
          </p>
        </CardContent>
      </Card>

      {/* Check-out Date Selection */}
      <Card>
        <CardHeader>
          <CardTitle className="flex items-center gap-2">
            <Calendar className="h-5 w-5" />
            Check-out Date
          </CardTitle>
        </CardHeader>
        <CardContent>
          <div className="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-5 gap-2">
            {availableDates.slice(1).map((date) => (
              <Button
                key={`checkout-${date.toISOString()}`}
                variant={isSameDay(date, checkOutDate) ? "default" : "outline"}
                className="h-auto py-3 px-2 flex flex-col items-center"
                onClick={() => setCheckOutDate(date)}
                disabled={date <= checkInDate}
              >
                <span className="text-sm font-medium">{format(date, 'd')}</span>
                <span className="text-xs">{format(date, 'EEE')}</span>
              </Button>
            ))}
          </div>
          <p className="text-sm text-gray-600 mt-2">
            Check-out: {formatDateLabel(checkOutDate)} ({format(checkOutDate, 'MMMM d, yyyy')})
          </p>
        </CardContent>
      </Card>

      {/* Booking Summary */}
      <Card>
        <CardHeader>
          <CardTitle className="flex items-center gap-2">
            <Home className="h-5 w-5" />
            Booking Summary
          </CardTitle>
        </CardHeader>
        <CardContent className="space-y-4">
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            <div>
              <h4 className="font-medium text-gray-900">{apartment.name}</h4>
              <p className="text-sm text-gray-600">
                {typeof apartment.location_details === 'object' && apartment.location_details !== null && 'address' in apartment.location_details
                  ? (apartment.location_details as { address?: string }).address || 'Venice, Italy'
                  : 'Venice, Italy'}
              </p>
              <div className="flex items-center gap-2 mt-2">
                <Users className="h-4 w-4 text-gray-400" />
                <span className="text-sm">Up to {apartment.max_guests} guests</span>
              </div>
            </div>
            <div className="text-right">
              <div className="flex items-center justify-end gap-1">
                <Euro className="h-4 w-4" />
                <span className="text-2xl font-bold text-blue-600">
                  {totalPrice.toFixed(2)}
                </span>
              </div>
              <p className="text-sm text-gray-600">
                €{(apartment.base_price_cents / 100).toFixed(0)}/night × {nights} night{nights !== 1 ? 's' : ''}
              </p>
            </div>
          </div>

          <div className="border-t pt-4">
            <Button
              onClick={handleBookingSelect}
              className="w-full"
              disabled={checkingAvailability}
            >
              {checkingAvailability ? (
                <>
                  <div className="animate-spin rounded-full h-4 w-4 border-b-2 border-white mr-2"></div>
                  Checking availability...
                </>
              ) : (
                `Book Now - €${totalPrice.toFixed(2)}`
              )}
            </Button>
          </div>
        </CardContent>
      </Card>
    </div>
  )
}
