'use client'

import { useEffect, useState } from 'react'
import Link from 'next/link'
import { Calendar, Menu, X } from 'lucide-react'

interface MenuItem {
  id: string
  title: Record<string, string>
  href: string
  is_active: boolean
  sort_order: number
}

interface ThemeSettings {
  theme_colors: {
    header_bg_left: string
    header_bg_right: string
    footer_color: string
  }
}

export function Header() {
  const [hasScrolled, setHasScrolled] = useState(false)
  const [isMenuOpen, setIsMenuOpen] = useState(false)
  const [menuItems, setMenuItems] = useState<MenuItem[]>([])
  const [themeSettings, setThemeSettings] = useState<ThemeSettings | null>(null)

  useEffect(() => {
    const handleScroll = () => {
      setHasScrolled(window.scrollY > 24)
    }

    handleScroll()
    window.addEventListener('scroll', handleScroll, { passive: true })

    // Fetch menu items and settings
    fetchMenuItems()
    fetchThemeSettings()

    return () => window.removeEventListener('scroll', handleScroll)
  }, [])

  const fetchMenuItems = async () => {
    try {
      const response = await fetch('/api/admin/menu')
      if (response.ok) {
        const data = await response.json()
        setMenuItems(data)
      }
    } catch (error) {
      console.error('Error fetching menu items:', error)
      // Fallback to default menu items
      setMenuItems([
        { id: '1', href: '/about', title: { en: 'About' }, is_active: true, sort_order: 1 },
        { id: '2', href: '/apartments', title: { en: 'Apartments' }, is_active: true, sort_order: 2 },
        { id: '3', href: '/neighbourhood', title: { en: 'Neighbourhood' }, is_active: true, sort_order: 3 },
        { id: '4', href: '/how-to-get-here', title: { en: 'How to get here' }, is_active: true, sort_order: 4 },
        { id: '5', href: '/contact', title: { en: 'Contact with map' }, is_active: true, sort_order: 5 },
      ])
    }
  }

  const fetchThemeSettings = async () => {
    try {
      const response = await fetch('/api/admin/settings')
      if (response.ok) {
        const data = await response.json()
        setThemeSettings(data)
      }
    } catch (error) {
      console.error('Error fetching theme settings:', error)
    }
  }

  const toggleMenu = () => {
    setIsMenuOpen(!isMenuOpen)
  }

  const closeMenu = () => {
    setIsMenuOpen(false)
  }

  return (
    <>
      {/* Mobile Header */}
      <header
        className="mobile-header fixed top-0 left-0 right-0 h-16 px-5 md:hidden z-[250] animate-header-entrance"
        style={{ backgroundColor: themeSettings?.theme_colors?.header_bg_left || '#10223f' }}
      >
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
            className="flex items-center gap-2 font-montserrat uppercase tracking-[0.14em] text-sm font-semibold text-white group"
            aria-label="Toggle menu"
          >
            <span className="transition-all duration-300 group-hover:tracking-widest">Menu</span>
            {isMenuOpen ? <X className="w-5 h-5" /> : <Menu className="w-5 h-5" />}
          </button>
        </div>
      </header>

      <div className="hidden md:block">
      {/* Top Connector Bar */}
      <div
        className="fixed top-0 left-0 right-0 z-[250] h-2 border-t-2 animate-header-entrance"
        style={{
          background: themeSettings ? `linear-gradient(to right, ${themeSettings.theme_colors.header_bg_left}, ${themeSettings.theme_colors.header_bg_right})` : 'linear-gradient(to right, #003049, #1b211a)'
        }}
      />

       {/* Floating Left Tab - BOOK NOW with elegant hover animation */}
       <Link href="/apartments" className="fixed top-0 left-0 z-[250] group">
          <div
            className="h-25 px-6 text-white flex items-center justify-center border-t-2 border-white shadow-[0_4px_10px_rgba(0,0,0,0.1)] hover:shadow-[0_6px_20px_rgba(0,0,0,0.25)] transition-all duration-500 ease-out hover:scale-105"
            style={{
              backgroundColor: themeSettings?.theme_colors?.header_bg_left || '#003049',
              borderRadius: '0 0 50px 0'
            }}
          >
            <div className="flex items-center space-x-3 font-montserrat uppercase text-base md:text-lg tracking-wider font-semibold">
              <Calendar className="w-6 h-6 md:w-7 md:h-7 transition-transform duration-500 ease-out group-hover:rotate-12 group-hover:scale-110" />
              <span className="relative inline-block overflow-hidden">
                <span className="relative block transition-all duration-500 ease-out group-hover:tracking-[0.2em] group-hover:text-yellow-200">
                  BOOK NOW
                </span>
                {/* Elegant underline reveal */}
                <span className="absolute bottom-0 left-0 w-full h-0.5 bg-yellow-300 transform scale-x-0 origin-left transition-transform duration-500 ease-out group-hover:scale-x-100" />
              </span>
            </div>
          </div>
        </Link>

      {/* Transparent Center Logo */}
      <div
        className={`fixed top-6 left-1/2 -translate-x-1/2 z-[250] transition-all duration-300 ${
          hasScrolled ? 'opacity-0 -translate-y-3 pointer-events-none' : 'opacity-100 translate-y-0'
        }`}
      >
        <Link href="/" className="flex flex-col items-center gap-1 opacity-90 hover:opacity-100 transition-opacity">
          <span className="text-2xl md:text-3xl font-semibold text-gray-900 font-serif tracking-wide md:tracking-wider">Venice Parsley</span>
           
        </Link>
      </div>

      {/* Floating Right Tab - MENU with elegant hover animation */}
      <div className="fixed top-0 right-0 z-[250] group">
        <button
          onClick={toggleMenu}
          className="h-25 px-6 text-white flex items-center justify-center border-t-2 border-white shadow-[0_4px_10px_rgba(0,0,0,0.1)] hover:shadow-[0_6px_20px_rgba(0,0,0,0.25)] transition-all duration-500 ease-out hover:scale-105 cursor-pointer"
          style={{
            backgroundColor: themeSettings?.theme_colors?.header_bg_right || '#1b211a',
            borderRadius: '0 0 0 50px'
          }}
          aria-label="Toggle menu"
        >
          <div className="flex items-center space-x-3 font-montserrat uppercase text-base md:text-lg tracking-wider font-semibold">
            <span className="relative inline-block overflow-hidden">
              <span className="relative block transition-all duration-500 ease-out group-hover:tracking-[0.2em] group-hover:text-yellow-200">
                MENU
              </span>
              {/* Elegant underline reveal */}
              <span className="absolute bottom-0 left-0 w-full h-0.5 bg-yellow-300 transform scale-x-0 origin-left transition-transform duration-500 ease-out group-hover:scale-x-100" />
            </span>
            {isMenuOpen ? <X className="w-6 h-6 md:w-7 md:h-7 transition-transform duration-500 ease-out group-hover:rotate-12 group-hover:scale-110" /> : <Menu className="w-6 h-6 md:w-7 md:h-7 transition-transform duration-500 ease-out group-hover:rotate-12 group-hover:scale-110" />}
          </div>
        </button>
      </div>
      </div>

      {/* Mobile Menu Overlay */}
      <div
        className={`fixed top-16 left-0 right-0 bottom-0 z-[150] transition-opacity duration-300 md:hidden ${
          isMenuOpen ? 'opacity-100 pointer-events-auto' : 'opacity-0 pointer-events-none'
        }`}
        onClick={closeMenu}
      >
        {/* Menu layer */}
        <div
          className={`absolute top-0 right-0 w-80 h-auto shadow-2xl transform transition-transform duration-300 rounded-tl-lg ${
            isMenuOpen ? 'translate-x-0' : 'translate-x-full'
          }`}
          style={{
            backgroundColor: themeSettings ? `${themeSettings.theme_colors.header_bg_right}80` : 'rgba(168, 85, 247, 0.5)'
          }}
          onClick={(e) => e.stopPropagation()}
        >
          {/* Menu Items */}
          <nav className="py-4">
            <ul className="space-y-1">
              {menuItems.map((item) => (
                <li key={item.href}>
                  <Link
                    href={item.href}
                    onClick={closeMenu}
                    className="block px-6 py-2 text-lg font-medium text-white hover:text-yellow-300 hover:translate-x-2 transition-all duration-200"
                  >
                    › {item.title?.en}
                  </Link>
                </li>
              ))}
            </ul>
          </nav>
        </div>
      </div>

      {/* Desktop Menu Overlay */}
      <div
        className={`hidden md:block fixed top-25 left-0 right-0 bottom-0 z-[150] transition-opacity duration-300 ${
          isMenuOpen ? 'opacity-100 pointer-events-auto' : 'opacity-0 pointer-events-none'
        }`}
        onClick={closeMenu}
      >
        {/* Menu layer */}
        <div
          className={`absolute top-0 right-0 w-96 h-auto shadow-2xl transform transition-transform duration-300 rounded-tl-lg ${
            isMenuOpen ? 'translate-x-0' : 'translate-x-full'
          }`}
          style={{
            backgroundColor: themeSettings ? `${themeSettings.theme_colors.header_bg_right}80` : 'rgba(168, 85, 247, 0.5)'
          }}
          onClick={(e) => e.stopPropagation()}
        >
          {/* Menu Items */}
          <nav className="py-6">
            <ul className="space-y-2">
              {menuItems.map((item) => (
                <li key={item.href}>
                  <Link
                    href={item.href}
                    onClick={closeMenu}
                    className="block px-8 py-3 text-xl font-medium text-white hover:text-yellow-300 hover:translate-x-4 transition-all duration-200"
                  >
                    › {item.title?.en}
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
