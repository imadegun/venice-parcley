'use client'

import { useState, useEffect } from 'react'
import { format } from 'date-fns'
import type { Database } from '@/types/database'
import { createClient } from '@/lib/supabase'
import { DateRangePicker } from '@/components/booking/date-range-picker'
import { StripePaymentForm } from '@/components/booking/stripe-payment-form'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { Input } from '@/components/ui/input'
import { Label } from '@/components/ui/label'
import { Textarea } from '@/components/ui/textarea'
import { Button } from '@/components/ui/button'
import { Alert, AlertDescription } from '@/components/ui/alert'
import { Calendar, CreditCard, Users, Euro, CheckCircle, AlertCircle } from 'lucide-react'

type Apartment = Database['public']['Tables']['apartments']['Row']

interface EmbeddedBookingFlowProps {
  apartmentId: string
}

export function EmbeddedBookingFlow({ apartmentId }: EmbeddedBookingFlowProps) {
  const [apartment, setApartment] = useState<Apartment | null>(null)
  const [selectedDates, setSelectedDates] = useState<{ checkIn: Date; checkOut: Date } | null>(null)
  const [clientSecret, setClientSecret] = useState<string>('')
  const [bookingId, setBookingId] = useState<string>('')

  // Guest details
  const [guestName, setGuestName] = useState('')
  const [guestEmail, setGuestEmail] = useState('')
  const [guestPhone, setGuestPhone] = useState('')
  const [totalGuests, setTotalGuests] = useState(1)
  const [specialRequests, setSpecialRequests] = useState('')

  // UI state
  const [step, setStep] = useState<'dates' | 'details' | 'payment' | 'confirmation'>('dates')
  const [loading, setLoading] = useState(false)
  const [error, setError] = useState<string>('')
  const [paymentSuccess, setPaymentSuccess] = useState(false)

  // Calculate pricing
  const nights = selectedDates ? Math.ceil((selectedDates.checkOut.getTime() - selectedDates.checkIn.getTime()) / (1000 * 60 * 60 * 24)) : 0
  const totalPrice = selectedDates && apartment ? nights * (apartment.base_price_cents / 100) : 0

  const handleDateRangeSelect = async (checkIn: Date, checkOut: Date) => {
    setSelectedDates({ checkIn, checkOut })
    setStep('details')
  }

  const handleProceedToPayment = async () => {
    if (!selectedDates || !apartment) return

    setError('')
    setLoading(true)

    if (!guestName.trim() || !guestEmail.trim()) {
      setError('Guest name and email are required.')
      setLoading(false)
      return
    }

    try {
      const response = await fetch('/api/booking/create-payment-intent', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          apartmentId: apartment.id,
          checkInDate: format(selectedDates.checkIn, 'yyyy-MM-dd'),
          checkOutDate: format(selectedDates.checkOut, 'yyyy-MM-dd'),
          totalGuests,
          guestName: guestName.trim(),
          guestEmail: guestEmail.trim(),
          guestPhone: guestPhone.trim() || null,
          specialRequests: specialRequests.trim() || null,
        }),
      })

      const payload = await response.json()

      if (!response.ok) {
        if (response.status === 401 && payload?.loginUrl) {
          window.location.href = payload.loginUrl
          return
        }
        throw new Error(payload?.error || 'Failed to create booking')
      }

      setClientSecret(payload.clientSecret)
      setBookingId(payload.bookingId)
      setStep('payment')
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Unable to proceed to payment')
    } finally {
      setLoading(false)
    }
  }

  const handlePaymentSuccess = async (paymentIntent: any) => {
    setPaymentSuccess(true)
    setStep('confirmation')

    // Redirect to confirmation page after a short delay
    setTimeout(() => {
      window.location.href = `/booking/confirmation/${bookingId}`
    }, 2000)
  }

  const handlePaymentError = (error: string) => {
    setError(error)
  }

  // Load apartment data
  useEffect(() => {
    const loadApartment = async () => {
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
        console.error('Error loading apartment:', error)
      }
    }
    loadApartment()
  }, [apartmentId])

  if (!apartment) {
    return (
      <div className="text-center py-8">
        <p className="text-gray-600">Loading apartment details...</p>
      </div>
    )
  }

  return (
    <div className="max-w-6xl mx-auto">
      {/* Progress Steps */}
      <div className="flex items-center justify-center mb-8">
        <div className="flex items-center space-x-4">
          {[
            { step: 'dates', label: 'Select Dates', icon: Calendar },
            { step: 'details', label: 'Guest Details', icon: Users },
            { step: 'payment', label: 'Payment', icon: CreditCard },
            { step: 'confirmation', label: 'Confirmation', icon: CheckCircle },
          ].map(({ step: stepName, label, icon: Icon }, index) => (
            <div key={stepName} className="flex items-center">
              <div className={`flex items-center gap-2 px-4 py-2 rounded-full text-sm font-medium ${
                step === stepName ? 'bg-blue-600 text-white' :
                step === 'confirmation' && paymentSuccess ? 'bg-green-600 text-white' :
                ['dates', 'details', 'payment'].includes(step) && ['dates', 'details', 'payment'].indexOf(step) > index ? 'bg-green-600 text-white' :
                'bg-gray-200 text-gray-600'
              }`}>
                <Icon className="h-4 w-4" />
                <span>{label}</span>
              </div>
              {index < 3 && <div className="w-8 h-0.5 bg-gray-300 mx-2"></div>}
            </div>
          ))}
        </div>
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-2 gap-8">
        {/* Left Column: Date Picker & Details */}
        <div className="space-y-6">
          {step === 'dates' && (
            <Card>
              <CardHeader>
                <CardTitle>Select Your Dates</CardTitle>
              </CardHeader>
              <CardContent>
                <DateRangePicker
                  apartment={apartment}
                  onDateRangeSelect={handleDateRangeSelect}
                />
              </CardContent>
            </Card>
          )}

          {step === 'details' && selectedDates && (
            <Card>
              <CardHeader>
                <CardTitle>Guest Details</CardTitle>
              </CardHeader>
              <CardContent className="space-y-4">
                <div className="grid gap-4 md:grid-cols-2">
                  <div className="space-y-2">
                    <Label htmlFor="guest-name">Full name *</Label>
                    <Input
                      id="guest-name"
                      value={guestName}
                      onChange={(e) => setGuestName(e.target.value)}
                      placeholder="John Doe"
                    />
                  </div>

                  <div className="space-y-2">
                    <Label htmlFor="guest-email">Email *</Label>
                    <Input
                      id="guest-email"
                      type="email"
                      value={guestEmail}
                      onChange={(e) => setGuestEmail(e.target.value)}
                      placeholder="john@example.com"
                    />
                  </div>

                  <div className="space-y-2">
                    <Label htmlFor="guest-phone">Phone</Label>
                    <Input
                      id="guest-phone"
                      value={guestPhone}
                      onChange={(e) => setGuestPhone(e.target.value)}
                      placeholder="+65 9000 0000"
                    />
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
                  <Textarea
                    id="special-requests"
                    value={specialRequests}
                    onChange={(e) => setSpecialRequests(e.target.value)}
                    placeholder="Airport pickup, late check-in, preferences..."
                  />
                </div>

                <Button onClick={handleProceedToPayment} className="w-full" disabled={loading} size="lg">
                  {loading ? 'Creating booking...' : 'Continue to Payment'}
                </Button>
              </CardContent>
            </Card>
          )}

          {/* Booking Summary - Always visible on left */}
          {selectedDates && (
            <Card>
              <CardHeader>
                <CardTitle className="flex items-center gap-2">
                  <Euro className="h-5 w-5" />
                  Booking Summary
                </CardTitle>
              </CardHeader>
              <CardContent className="space-y-4">
                <div>
                  <h4 className="font-medium text-gray-900">{apartment.name}</h4>
                  <p className="text-sm text-gray-600">Venice, Italy</p>
                </div>

                <div className="space-y-2">
                  <div className="flex justify-between text-sm">
                    <span>Check-in</span>
                    <span className="font-medium">{format(selectedDates.checkIn, 'EEE, MMM d, yyyy')}</span>
                  </div>
                  <div className="flex justify-between text-sm">
                    <span>Check-out</span>
                    <span className="font-medium">{format(selectedDates.checkOut, 'EEE, MMM d, yyyy')}</span>
                  </div>
                  <div className="flex justify-between text-sm">
                    <span>Nights</span>
                    <span className="font-medium">{nights}</span>
                  </div>
                  <div className="flex justify-between text-sm">
                    <span>Guests</span>
                    <span className="font-medium">{totalGuests}</span>
                  </div>
                </div>

                <div className="border-t pt-4">
                  <div className="flex justify-between items-center">
                    <span className="text-lg font-medium">Total</span>
                    <span className="text-2xl font-bold text-blue-600">€{totalPrice.toFixed(2)}</span>
                  </div>
                  <p className="text-sm text-gray-600 mt-1">
                    €{(apartment.base_price_cents / 100).toFixed(0)} per night × {nights} night{nights !== 1 ? 's' : ''}
                  </p>
                </div>
              </CardContent>
            </Card>
          )}
        </div>

        {/* Right Column: Payment Form */}
        <div className="space-y-6">
          {step === 'payment' && clientSecret && (
            <Card>
              <CardHeader>
                <CardTitle className="flex items-center gap-2">
                  <CreditCard className="h-5 w-5" />
                  Secure Payment
                </CardTitle>
              </CardHeader>
              <CardContent>
                <StripePaymentForm
                  clientSecret={clientSecret}
                  onPaymentSuccess={handlePaymentSuccess}
                  onPaymentError={handlePaymentError}
                  amount={totalPrice * 100}
                />
              </CardContent>
            </Card>
          )}

          {step === 'confirmation' && paymentSuccess && (
            <Card>
              <CardHeader>
                <CardTitle className="flex items-center gap-2 text-green-600">
                  <CheckCircle className="h-5 w-5" />
                  Payment Successful!
                </CardTitle>
              </CardHeader>
              <CardContent className="text-center space-y-4">
                <div className="w-16 h-16 bg-green-100 rounded-full flex items-center justify-center mx-auto">
                  <CheckCircle className="h-8 w-8 text-green-600" />
                </div>
                <p className="text-gray-600">
                  Your booking has been confirmed. Redirecting to confirmation page...
                </p>
              </CardContent>
            </Card>
          )}

          {error && (
            <Alert variant="destructive">
              <AlertCircle className="h-4 w-4" />
              <AlertDescription>{error}</AlertDescription>
            </Alert>
          )}
        </div>
      </div>
    </div>
  )
}
