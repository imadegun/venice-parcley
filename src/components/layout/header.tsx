'use client'

import { useState, useEffect } from 'react'
import Link from 'next/link'
import { Calendar, Menu } from 'lucide-react'

export function Header() {
  const [scrolled, setScrolled] = useState(false)

  useEffect(() => {
    const handleScroll = () => setScrolled(window.scrollY > 50)
    window.addEventListener('scroll', handleScroll)
    return () => window.removeEventListener('scroll', handleScroll)
  }, [])

  return (
    <>
      {/* Floating Left Tab - BOOK NOW */}
      <div className={`fixed top-0 left-0 z-50 ${scrolled ? 'scale-90' : ''} transition-transform duration-300`}>
        <div className="h-32 px-6 bg-gradient-to-r from-pink-600 to-blue-900 text-white flex items-center justify-center border-t-2 border-white shadow-[0_4px_10px_rgba(0,0,0,0.1)] hover:shadow-[0_6px_15px_rgba(0,0,0,0.15)] transition-shadow cursor-pointer" style={{borderRadius: '0 0 50px 0'}}>
          <div className="flex items-center space-x-2 font-montserrat uppercase text-sm tracking-wider">
            <Calendar className="w-4 h-4" />
            <span>BOOK NOW</span>
          </div>
        </div>
      </div>

      {/* Transparent Center Logo */}
      <div className="fixed top-6 left-1/2 -translate-x-1/2 z-40">
        <Link href="/" className="flex items-center space-x-2 opacity-90 hover:opacity-100 transition-opacity">
          <div className="h-8 w-8 rounded-full bg-gradient-to-r from-blue-500 to-teal-500"></div>
          <span className="text-xl font-bold text-gray-900 font-yellowtail">Venice Parcley</span>
        </Link>
      </div>

      {/* Floating Right Tab - MENU */}
      <div className={`fixed top-6 right-6 z-50 ${scrolled ? 'scale-90' : ''} transition-transform duration-300`}>
        <div className="bg-gray-800 text-white px-6 py-3 rounded-lg shadow-lg hover:shadow-xl transition-shadow cursor-pointer">
          <div className="flex items-center space-x-2 font-montserrat uppercase text-sm tracking-wider">
            <Menu className="w-4 h-4" />
            <span>MENU</span>
          </div>
        </div>
      </div>
    </>
  )
}