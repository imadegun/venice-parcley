'use client'

import { useEffect, useState } from 'react'
import Link from 'next/link'
import { Calendar, Menu, X } from 'lucide-react'

export function Header() {
  const [hasScrolled, setHasScrolled] = useState(false)
  const [isMenuOpen, setIsMenuOpen] = useState(false)

  useEffect(() => {
    const handleScroll = () => {
      setHasScrolled(window.scrollY > 24)
    }

    handleScroll()
    window.addEventListener('scroll', handleScroll, { passive: true })

    return () => window.removeEventListener('scroll', handleScroll)
  }, [])

  const toggleMenu = () => {
    setIsMenuOpen(!isMenuOpen)
  }

  const closeMenu = () => {
    setIsMenuOpen(false)
  }

  const menuItems = [
    { href: '/about', label: 'About' },
    { href: '/apartments', label: 'Apartments' },
    { href: '/neighbourhood', label: 'Neighbourhood' },
    { href: '/how-to-get-here', label: 'How to get here' },
    { href: '/contact', label: 'Contact with map' },
  ]

  return (
    <>
      {/* Mobile Header */}
      <header className="mobile-header fixed top-0 left-0 right-0 h-16 bg-[#10223f] px-5 md:hidden z-[250]">
        <div className="flex h-full items-center justify-between">
          <Link
            href="/"
            className={`flex items-center transition-all duration-300 ${
              hasScrolled ? 'opacity-0 -translate-y-2 pointer-events-none' : 'opacity-100 translate-y-0'
            }`}
          >
            <span className="text-xl font-semibold text-white font-serif tracking-wide">Venice Parcley</span>
          </Link>

          <button
            type="button"
            onClick={toggleMenu}
            className="flex items-center gap-2 font-montserrat uppercase tracking-[0.14em] text-sm font-semibold text-white"
            aria-label="Toggle menu"
          >
            <span>Menu</span>
            {isMenuOpen ? <X className="w-5 h-5" /> : <Menu className="w-5 h-5" />}
          </button>
        </div>
      </header>

      <div className="hidden md:block">
      {/* Top Connector Bar */}
      <div className="fixed top-0 left-0 right-0 z-[250] h-2 bg-gradient-to-r from-sky-400 to-purple-500 border-t-2 border-white" />

      {/* Floating Left Tab - BOOK NOW */}
      <div className="fixed top-0 left-0 z-[250]">
        <div className="h-25 px-6 bg-sky-400 text-white flex items-center justify-center border-t-2 border-white shadow-[0_4px_10px_rgba(0,0,0,0.1)] hover:shadow-[0_6px_15px_rgba(0,0,0,0.15)] transition-shadow cursor-pointer" style={{borderRadius: '0 0 50px 0'}}>
          <div className="flex items-center space-x-3 font-montserrat uppercase text-base md:text-lg tracking-wider font-semibold">
            <Calendar className="w-6 h-6 md:w-7 md:h-7" />
            <span>BOOK NOW</span>
          </div>
        </div>
      </div>

      {/* Transparent Center Logo */}
      <div
        className={`fixed top-6 left-1/2 -translate-x-1/2 z-[250] transition-all duration-300 ${
          hasScrolled ? 'opacity-0 -translate-y-3 pointer-events-none' : 'opacity-100 translate-y-0'
        }`}
      >
        <Link href="/" className="flex flex-col items-center gap-1 opacity-90 hover:opacity-100 transition-opacity">
          <span className="text-2xl md:text-3xl font-semibold text-gray-900 font-serif tracking-wide md:tracking-wider">Venice Parcley</span>
          <div className="h-8 w-8 bg-gradient-to-r from-blue-500 to-teal-500" />
        </Link>
      </div>

      {/* Floating Right Tab - MENU */}
      <div className="fixed top-0 right-0 z-[250]">
        <button
          onClick={toggleMenu}
          className="h-25 px-6 bg-purple-500 text-white flex items-center justify-center border-t-2 border-white shadow-[0_4px_10px_rgba(0,0,0,0.1)] hover:shadow-[0_6px_15px_rgba(0,0,0,0.15)] transition-shadow cursor-pointer"
          style={{borderRadius: '0 0 0 50px'}}
          aria-label="Toggle menu"
        >
          <div className="flex items-center space-x-3 font-montserrat uppercase text-base md:text-lg tracking-wider font-semibold">
            <span>MENU</span>
            {isMenuOpen ? <X className="w-6 h-6 md:w-7 md:h-7" /> : <Menu className="w-6 h-6 md:w-7 md:h-7" />}
          </div>
        </button>
      </div>
      </div>

      {/* Mobile Menu Overlay */}
      <div
        className={`fixed top-16 right-0 z-[150] h-screen transition-opacity duration-300 md:hidden ${
          isMenuOpen ? 'opacity-100 pointer-events-auto' : 'opacity-0 pointer-events-none'
        }`}
      >
        <div
          className={`w-80 h-full bg-purple-500/50 shadow-2xl transform transition-transform duration-300 ${
            isMenuOpen ? 'translate-x-0' : 'translate-x-full'
          }`}
        >
          {/* Menu Items */}
          <nav className="py-8">
            <ul className="space-y-1">
              {menuItems.map((item) => (
                <li key={item.href}>
                  <Link
                    href={item.href}
                    onClick={closeMenu}
                    className="block px-6 py-3 text-lg font-medium text-white hover:text-yellow-300 hover:translate-x-2 transition-all duration-200"
                  >
                    › {item.label}
                  </Link>
                </li>
              ))}
            </ul>
          </nav>
        </div>
      </div>

      {/* Desktop Menu Overlay */}
      <div
        className={`hidden md:block fixed top-25 right-0 z-[150] h-screen transition-opacity duration-300 ${
          isMenuOpen ? 'opacity-100 pointer-events-auto' : 'opacity-0 pointer-events-none'
        }`}
      >
        <div
          className={`w-96 h-full bg-purple-500/50 shadow-2xl transform transition-transform duration-300 ${
            isMenuOpen ? 'translate-x-0' : 'translate-x-full'
          }`}
        >
          {/* Menu Items */}
          <nav className="py-16">
            <ul className="space-y-2">
              {menuItems.map((item) => (
                <li key={item.href}>
                  <Link
                    href={item.href}
                    onClick={closeMenu}
                    className="block px-8 py-4 text-xl font-medium text-white hover:text-yellow-300 hover:translate-x-4 transition-all duration-200"
                  >
                    › {item.label}
                  </Link>
                </li>
              ))}
            </ul>
          </nav>
        </div>
      </div>
    </>
  )
}
