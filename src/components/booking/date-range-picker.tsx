'use client'

import { useState, useEffect, useMemo } from 'react'
import { format, addDays, addMonths, startOfMonth, endOfMonth, eachDayOfInterval, isSameMonth, isSameDay, isBefore, startOfDay, isWithinInterval, isAfter } from 'date-fns'
import { ChevronLeft, ChevronRight, Calendar as CalendarIcon } from 'lucide-react'
import { Button } from '@/components/ui/button'
import { createClient } from '@/lib/supabase'
import type { Database } from '@/types/database'

type Apartment = Database['public']['Tables']['apartments']['Row']

interface DateRangePickerProps {
  apartment: Apartment
  onDateRangeSelect: (checkIn: Date, checkOut: Date) => void
}

export function DateRangePicker({ apartment, onDateRangeSelect }: DateRangePickerProps) {
  const [currentMonth, setCurrentMonth] = useState(new Date())
  const [checkIn, setCheckIn] = useState<Date | null>(null)
  const [checkOut, setCheckOut] = useState<Date | null>(null)
  const [hoverDate, setHoverDate] = useState<Date | null>(null)
  const [bookedDates, setBookedDates] = useState<Set<string>>(new Set())
  const [loading, setLoading] = useState(true)

  // Fetch booked dates for this apartment
  useEffect(() => {
    const fetchBookedDates = async () => {
      try {
        if (!process.env.NEXT_PUBLIC_SUPABASE_URL || !process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY) {
          console.warn('Supabase environment variables not set - booked dates unavailable')
          setLoading(false)
          return
        }

        const supabase = createClient()
        const { data, error } = await supabase
          .from('bookings')
          .select('check_in_date, check_out_date')
          .eq('apartment_id', apartment.id)
          .eq('status', 'confirmed')

        if (error) {
          console.error('Supabase error:', error)
          setBookedDates(new Set())
          return
        }

        const dates = new Set<string>()
        data?.forEach(booking => {
          const start = new Date(booking.check_in_date)
          const end = new Date(booking.check_out_date)
          const days = eachDayOfInterval({ start, end })
          days.forEach(day => dates.add(format(day, 'yyyy-MM-dd')))
        })
        setBookedDates(dates)
      } catch (error) {
        console.error('Error fetching booked dates:', error)
        setBookedDates(new Set())
      } finally {
        setLoading(false)
      }
    }

    fetchBookedDates()
  }, [apartment.id])

  const monthStart = startOfMonth(currentMonth)
  const monthEnd = endOfMonth(currentMonth)
  const monthDays = eachDayOfInterval({ start: monthStart, end: monthEnd })

  const startPadding = monthStart.getDay()
  const endPadding = 6 - monthEnd.getDay()

  const prevMonthDays = startPadding > 0 
    ? eachDayOfInterval({ start: addDays(monthStart, -startPadding), end: addDays(monthStart, -1) })
    : []

  const nextMonthDays = endPadding > 0
    ? eachDayOfInterval({ start: addDays(monthEnd, 1), end: addDays(monthEnd, endPadding) })
    : []

  const allDays = [...prevMonthDays, ...monthDays, ...nextMonthDays]

  const isDateBooked = (date: Date) => bookedDates.has(format(date, 'yyyy-MM-dd'))
  const isDateDisabled = (date: Date) => isBefore(date, startOfDay(new Date())) || isDateBooked(date)

  const handleDateClick = (date: Date) => {
    if (isDateDisabled(date)) return

    if (!checkIn) {
      // First click: set check-in
      setCheckIn(date)
      setCheckOut(null)
    } else if (checkIn && !checkOut) {
      // Second click: set check-out (must be after check-in)
      if (isAfter(date, checkIn)) {
        setCheckOut(date)
      } else {
        // If clicked before check-in, reset check-in to new date
        setCheckIn(date)
      }
    } else if (checkIn && checkOut) {
      // Third click: reset and start new selection
      setCheckIn(date)
      setCheckOut(null)
    }
  }

  const handleDateMouseEnter = (date: Date) => {
    if (checkIn && !checkOut && !isDateDisabled(date) && isAfter(date, checkIn)) {
      setHoverDate(date)
    }
  }

  const handleDateMouseLeave = () => {
    setHoverDate(null)
  }

  const getDateClassName = (date: Date) => {
    const isCurrentMonth = isSameMonth(date, currentMonth)
    const isDisabled = isDateDisabled(date)
    const isCheckIn = checkIn && isSameDay(date, checkIn)
    const isCheckOut = checkOut && isSameDay(date, checkOut)
    const isInRange = checkIn && (hoverDate || checkOut) && isWithinInterval(date, {
      start: checkIn,
      end: hoverDate || checkOut || checkIn
    })

    let className = 'relative h-10 w-10 p-0 text-sm font-medium rounded-md transition-all '

    if (!isCurrentMonth) {
      className += 'text-gray-300 '
    } else if (isDisabled) {
      className += 'text-gray-300 cursor-not-allowed bg-gray-100 '
    } else {
      className += 'text-gray-900 hover:bg-blue-50 cursor-pointer '
    }

    if (isCheckIn) {
      className += 'bg-blue-600 text-white hover:bg-blue-700 font-semibold shadow-md '
    } else if (isCheckOut) {
      className += 'bg-blue-600 text-white hover:bg-blue-700 font-semibold shadow-md '
    } else if (isInRange && isCurrentMonth && !isDisabled) {
      className += 'bg-blue-100 text-blue-900 '
    }

    return className.trim()
  }

  const goToPrevMonth = () => setCurrentMonth(addMonths(currentMonth, -1))
  const goToNextMonth = () => setCurrentMonth(addMonths(currentMonth, 1))

  const confirmSelection = () => {
    if (checkIn && checkOut) {
      onDateRangeSelect(checkIn, checkOut)
    }
  }

  const nights = checkIn && checkOut ? Math.ceil((checkOut.getTime() - checkIn.getTime()) / (1000 * 60 * 60 * 24)) : 0
  const totalPrice = checkIn && checkOut && nights > 0 ? nights * (apartment.base_price_cents / 100) : 0

  const displayCheckIn = checkIn ? format(checkIn, 'MMM d, yyyy') : null
  const displayCheckOut = checkOut ? format(checkOut, 'MMM d, yyyy') : null

  return (
    <div className="space-y-4">
      {/* Step indicator */}
      <div className="flex items-center gap-2 text-sm text-gray-600 mb-2">
        <div className={`flex items-center gap-2 ${checkIn ? 'text-blue-600' : ''}`}>
          <div className={`w-6 h-6 rounded-full flex items-center justify-center text-xs font-medium ${checkIn ? 'bg-blue-600 text-white' : 'bg-gray-200 text-gray-600'}`}>1</div>
          <span>Select check-in</span>
        </div>
        <div className="w-8 h-0.5 bg-gray-300"></div>
        <div className={`flex items-center gap-2 ${checkOut ? 'text-blue-600' : ''}`}>
          <div className={`w-6 h-6 rounded-full flex items-center justify-center text-xs font-medium ${checkOut ? 'bg-blue-600 text-white' : 'bg-gray-200 text-gray-600'}`}>2</div>
          <span>Select check-out</span>
        </div>
      </div>

      {/* Selected dates display */}
      <div className="flex items-center gap-3 p-3 bg-gray-50 rounded-lg border">
        <div className="flex items-center gap-2">
          <CalendarIcon className="h-5 w-5 text-blue-600" />
          <div>
            <p className="text-xs text-gray-500 uppercase tracking-wide">Check-in</p>
            <p className="font-medium text-gray-900">
              {displayCheckIn || <span className="text-gray-400">Select date</span>}
            </p>
          </div>
        </div>
        <div className="w-px h-8 bg-gray-300"></div>
        <div className="flex items-center gap-2">
          <div>
            <p className="text-xs text-gray-500 uppercase tracking-wide">Check-out</p>
            <p className="font-medium text-gray-900">
              {displayCheckOut || <span className="text-gray-400">Select date</span>}
            </p>
          </div>
        </div>
        {nights > 0 && (
          <>
            <div className="w-px h-8 bg-gray-300"></div>
            <div className="text-right">
              <p className="text-xs text-gray-500 uppercase tracking-wide">Duration</p>
              <p className="font-medium text-gray-900">{nights} night{nights !== 1 ? 's' : ''}</p>
            </div>
          </>
        )}
      </div>

      {/* Month Navigation */}
      <div className="flex items-center justify-between">
        <Button variant="outline" size="icon" onClick={goToPrevMonth} className="h-9 w-9">
          <ChevronLeft className="h-4 w-4" />
        </Button>
        <h3 className="text-base font-semibold text-gray-900">
          {format(currentMonth, 'MMMM yyyy')}
        </h3>
        <Button variant="outline" size="icon" onClick={goToNextMonth} className="h-9 w-9">
          <ChevronRight className="h-4 w-4" />
        </Button>
      </div>

      {/* Calendar Grid */}
      <div className="grid grid-cols-7 gap-1">
        {/* Day headers */}
        {['S', 'M', 'T', 'W', 'T', 'F', 'S'].map((day, i) => (
          <div key={i} className="h-9 flex items-center justify-center text-xs font-semibold text-gray-500">
            {day}
          </div>
        ))}

        {/* Calendar days */}
        {allDays.map((date, idx) => {
          const isCurrentMonth = isSameMonth(date, currentMonth)
          const isDisabled = isDateDisabled(date)
          const isCheckIn = checkIn && isSameDay(date, checkIn)
          const isCheckOut = checkOut && isSameDay(date, checkOut)
          const isInRange = checkIn && (hoverDate || checkOut) && isWithinInterval(date, {
            start: checkIn,
            end: hoverDate || checkOut || checkIn
          })

          return (
            <button
              key={idx}
              onClick={() => handleDateClick(date)}
              onMouseEnter={() => handleDateMouseEnter(date)}
              onMouseLeave={handleDateMouseLeave}
              disabled={isDisabled}
              className={`
                relative h-10 w-10 p-0 text-sm font-medium rounded-md transition-all
                ${!isCurrentMonth ? 'text-gray-300' : ''}
                ${isDisabled ? 'text-gray-300 cursor-not-allowed bg-gray-100' : 'text-gray-900 hover:bg-blue-50 cursor-pointer'}
                ${isCheckIn ? 'bg-blue-600 text-white hover:bg-blue-700 font-semibold shadow-md' : ''}
                ${isCheckOut ? 'bg-blue-600 text-white hover:bg-blue-700 font-semibold shadow-md' : ''}
                ${isInRange && isCurrentMonth && !isDisabled ? 'bg-blue-100 text-blue-900' : ''}
              `}
              title={
                isDisabled && isDateBooked(date)
                  ? 'Not available'
                  : isDisabled && isBefore(date, startOfDay(new Date()))
                  ? 'Past date'
                  : format(date, 'MMMM d, yyyy')
              }
            >
              {format(date, 'd')}
              {isDateBooked(date) && isCurrentMonth && (
                <div className="absolute bottom-0 left-1/2 -translate-x-1/2 w-1 h-1 bg-red-400 rounded-full"></div>
              )}
            </button>
          )
        })}
      </div>

      {/* Legend */}
      <div className="flex items-center justify-center gap-4 text-xs text-gray-500">
        <div className="flex items-center gap-1.5">
          <div className="w-3 h-3 rounded-sm bg-blue-600"></div>
          <span>Selected</span>
        </div>
        <div className="flex items-center gap-1.5">
          <div className="w-3 h-3 rounded-sm bg-blue-100"></div>
          <span>Your stay</span>
        </div>
        <div className="flex items-center gap-1.5">
          <div className="w-3 h-3 rounded-sm bg-gray-100 border border-gray-200"></div>
          <span>Unavailable</span>
        </div>
      </div>

      {/* Action buttons */}
      {checkIn && checkOut && (
        <div className="border-t pt-4 space-y-3">
          <div className="flex items-center justify-between text-sm">
            <div>
              <p className="text-gray-600">Check-in</p>
              <p className="font-medium text-gray-900">{format(checkIn, 'EEE, MMM d, yyyy')}</p>
            </div>
            <div className="text-right">
              <p className="text-gray-600">Check-out</p>
              <p className="font-medium text-gray-900">{format(checkOut, 'EEE, MMM d, yyyy')}</p>
            </div>
          </div>
          <div className="flex items-center justify-between">
            <span className="text-gray-600">
              {nights} night{nights !== 1 ? 's' : ''} × €{(apartment.base_price_cents / 100).toFixed(0)}
            </span>
            <span className="text-xl font-bold text-gray-900">€{totalPrice.toFixed(2)}</span>
          </div>
          <Button onClick={confirmSelection} className="w-full" size="lg">
            Continue to Guest Details
          </Button>
        </div>
      )}

      {checkIn && !checkOut && (
        <p className="text-sm text-blue-600 text-center py-2 flex items-center justify-center gap-2">
          <div className="w-2 h-2 rounded-full bg-blue-600 animate-pulse"></div>
          Now select your check-out date
        </p>
      )}

      {!checkIn && (
        <p className="text-sm text-gray-500 text-center py-2">
          Select a check-in date to begin
        </p>
      )}
    </div>
  )
}
