'use client'

import { useEffect, useState } from 'react'
import Link from 'next/link'
import { Calendar, Menu } from 'lucide-react'

export function Header() {
  const [hasScrolled, setHasScrolled] = useState(false)

  useEffect(() => {
    const handleScroll = () => {
      setHasScrolled(window.scrollY > 24)
    }

    handleScroll()
    window.addEventListener('scroll', handleScroll, { passive: true })

    return () => window.removeEventListener('scroll', handleScroll)
  }, [])

  return (
    <>
      {/* Mobile Header */}
      <header className="mobile-header fixed top-0 left-0 right-0 h-16 bg-[#10223f] px-5 md:hidden">
        <div className="flex h-full items-center justify-between">
          <Link
            href="/"
            className={`flex items-center transition-all duration-300 ${
              hasScrolled ? 'opacity-0 -translate-y-2 pointer-events-none' : 'opacity-100 translate-y-0'
            }`}
          >
            <span className="text-xl font-semibold text-white font-yellowtail tracking-wide">Venice Parcley</span>
          </Link>

          <button
            type="button"
            className="flex items-center gap-2 font-montserrat uppercase tracking-[0.14em] text-sm font-semibold text-white"
            aria-label="Open menu"
          >
            <span>Menu</span>
            <Menu className="w-5 h-5" />
          </button>
        </div>
      </header>

      <div className="hidden md:block">
      {/* Top Connector Bar */}
      <div className="fixed top-0 left-0 right-0 z-[100] h-2 bg-gradient-to-r from-sky-400 to-purple-500 border-t-2 border-white" />

      {/* Floating Left Tab - BOOK NOW */}
      <div className="fixed top-0 left-0 z-[100]">
        <div className="h-25 px-6 bg-sky-400 text-white flex items-center justify-center border-t-2 border-white shadow-[0_4px_10px_rgba(0,0,0,0.1)] hover:shadow-[0_6px_15px_rgba(0,0,0,0.15)] transition-shadow cursor-pointer" style={{borderRadius: '0 0 50px 0'}}>
          <div className="flex items-center space-x-3 font-montserrat uppercase text-base md:text-lg tracking-wider font-semibold">
            <Calendar className="w-6 h-6 md:w-7 md:h-7" />
            <span>BOOK NOW</span>
          </div>
        </div>
      </div>

      {/* Transparent Center Logo */}
      <div
        className={`fixed top-6 left-1/2 -translate-x-1/2 z-[100] transition-all duration-300 ${
          hasScrolled ? 'opacity-0 -translate-y-3 pointer-events-none' : 'opacity-100 translate-y-0'
        }`}
      >
        <Link href="/" className="flex flex-col items-center gap-1 opacity-90 hover:opacity-100 transition-opacity">
          <span className="text-2xl md:text-3xl font-semibold text-gray-900 font-yellowtail tracking-wide md:tracking-wider">Venice Parcley</span>
          <div className="h-8 w-8 bg-gradient-to-r from-blue-500 to-teal-500" />
        </Link>
      </div>

      {/* Floating Right Tab - MENU */}
      <div className="fixed top-0 right-0 z-[100]">
        <div className="h-25 px-6 bg-purple-500 text-white flex items-center justify-center border-t-2 border-white shadow-[0_4px_10px_rgba(0,0,0,0.1)] hover:shadow-[0_6px_15px_rgba(0,0,0,0.15)] transition-shadow cursor-pointer" style={{borderRadius: '0 0 0 50px'}}>
          <div className="flex items-center space-x-3 font-montserrat uppercase text-base md:text-lg tracking-wider font-semibold">
            <span>MENU</span>
            <Menu className="w-6 h-6 md:w-7 md:h-7" />
          </div>
        </div>
      </div>
      </div>
    </>
  )
}
