'use client'

import { useState, useEffect } from 'react'
import { format, addDays, isSameDay, isToday, isTomorrow } from 'date-fns'
import { Calendar, Clock, Users } from 'lucide-react'
import { Button } from '@/components/ui/button'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { Badge } from '@/components/ui/badge'
import { createClient } from '@/lib/supabase'
import type { Database } from '@/types/database'

type Therapist = Database['public']['Tables']['therapists']['Row']
type AvailabilitySlot = Database['public']['Tables']['availability_slots']['Row']

interface AvailabilityCheckerProps {
  treatmentId: string
  onSlotSelect: (slot: AvailabilitySlot, therapist: Therapist) => void
}

export function AvailabilityChecker({ treatmentId, onSlotSelect }: AvailabilityCheckerProps) {
  const [selectedDate, setSelectedDate] = useState<Date>(new Date())
  const [availableSlots, setAvailableSlots] = useState<Array<AvailabilitySlot & { therapist: Therapist }>>([])
  const [loading, setLoading] = useState(false)
  const supabase = createClient()

  // Generate next 14 days for date selection
  const availableDates = Array.from({ length: 14 }, (_, i) => addDays(new Date(), i))

  useEffect(() => {
    loadAvailability()
  }, [selectedDate, treatmentId])

  const loadAvailability = async () => {
    setLoading(true)
    try {
      // Get all therapists who can perform this treatment
      const { data: treatmentTherapists, error: ttError } = await supabase
        .from('treatment_therapists')
        .select('therapist_id')
        .eq('treatment_id', treatmentId)

      if (ttError || !treatmentTherapists) {
        setAvailableSlots([])
        return
      }

      const therapistIds = treatmentTherapists.map(tt => tt.therapist_id)

      // Get available slots for selected date and therapists
      const { data: slots, error: slotsError } = await supabase
        .from('availability_slots')
        .select(`
          *,
          therapists (*)
        `)
        .in('therapist_id', therapistIds)
        .eq('date', format(selectedDate, 'yyyy-MM-dd'))
        .eq('is_booked', false)
        .order('start_time')

      if (slotsError) {
        console.error('Error loading availability:', slotsError)
        setAvailableSlots([])
        return
      }

      setAvailableSlots(slots || [])
    } catch (error) {
      console.error('Error loading availability:', error)
      setAvailableSlots([])
    } finally {
      setLoading(false)
    }
  }

  const formatDateLabel = (date: Date) => {
    if (isToday(date)) return 'Today'
    if (isTomorrow(date)) return 'Tomorrow'
    return format(date, 'EEE, MMM d')
  }

  const formatTimeRange = (startTime: string, endTime: string) => {
    const start = format(new Date(`2000-01-01T${startTime}`), 'h:mm a')
    const end = format(new Date(`2000-01-01T${endTime}`), 'h:mm a')
    return `${start} - ${end}`
  }

  return (
    <div className="space-y-6">
      {/* Date Selection */}
      <Card>
        <CardHeader>
          <CardTitle className="flex items-center gap-2">
            <Calendar className="h-5 w-5" />
            Select Date
          </CardTitle>
        </CardHeader>
        <CardContent>
          <div className="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-7 gap-2">
            {availableDates.map((date) => (
              <Button
                key={date.toISOString()}
                variant={isSameDay(date, selectedDate) ? "default" : "outline"}
                className="h-auto py-3 px-2 flex flex-col items-center"
                onClick={() => setSelectedDate(date)}
              >
                <span className="text-sm font-medium">{format(date, 'd')}</span>
                <span className="text-xs">{format(date, 'EEE')}</span>
              </Button>
            ))}
          </div>
          <p className="text-sm text-gray-600 mt-2">
            Selected: {formatDateLabel(selectedDate)} ({format(selectedDate, 'MMMM d, yyyy')})
          </p>
        </CardContent>
      </Card>

      {/* Available Slots */}
      <Card>
        <CardHeader>
          <CardTitle className="flex items-center gap-2">
            <Clock className="h-5 w-5" />
            Available Times
          </CardTitle>
        </CardHeader>
        <CardContent>
          {loading ? (
            <div className="text-center py-8">
              <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-purple-600 mx-auto"></div>
              <p className="text-gray-600 mt-2">Loading available times...</p>
            </div>
          ) : availableSlots.length === 0 ? (
            <div className="text-center py-8">
              <Clock className="h-12 w-12 text-gray-400 mx-auto mb-4" />
              <p className="text-gray-600">No available times for this date.</p>
              <p className="text-sm text-gray-500 mt-1">Try selecting a different date.</p>
            </div>
          ) : (
            <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-3">
              {availableSlots.map((slot) => (
                <Button
                  key={slot.id}
                  variant="outline"
                  className="h-auto p-4 flex flex-col items-start hover:bg-purple-50"
                  onClick={() => onSlotSelect(slot, slot.therapists)}
                >
                  <div className="flex items-center gap-2 w-full mb-2">
                    <Clock className="h-4 w-4 text-purple-600" />
                    <span className="font-medium">
                      {formatTimeRange(slot.start_time, slot.end_time)}
                    </span>
                  </div>
                  <div className="flex items-center gap-2 w-full">
                    <Users className="h-4 w-4 text-gray-400" />
                    <span className="text-sm text-gray-600">
                      {slot.therapists?.name || 'Therapist'}
                    </span>
                  </div>
                </Button>
              ))}
            </div>
          )}
        </CardContent>
      </Card>
    </div>
  )
}