import Link from 'next/link'

export function Footer() {
  return (
    <footer className="bg-gray-900 text-white py-12">
      <div className="container mx-auto px-4">
        <div className="grid grid-cols-1 md:grid-cols-4 gap-8">
          {/* Brand */}
          <div>
            <div className="flex items-center space-x-2 mb-4">
              <div className="h-8 w-8 rounded-full bg-gradient-to-r from-blue-500 to-teal-500"></div>
              <span className="text-xl font-bold font-yellowtail">Venice Parcley</span>
            </div>
            <p className="text-gray-400 text-sm">
              Luxury artistic apartments in Venice for art lovers and creative travelers.
            </p>
          </div>

          {/* Quick Links */}
          <div>
            <h3 className="font-semibold mb-4">Apartments</h3>
            <ul className="space-y-2 text-sm text-gray-400">
              <li><Link href="/apartments" className="hover:text-white">All Apartments</Link></li>
              <li><Link href="/apartments?type=artistic-studio" className="hover:text-white">Artistic Studios</Link></li>
              <li><Link href="/apartments?type=design-loft" className="hover:text-white">Design Lofts</Link></li>
              <li><Link href="/apartments?type=creative-suite" className="hover:text-white">Creative Suites</Link></li>
            </ul>
          </div>

          {/* Services */}
          <div>
            <h3 className="font-semibold mb-4">Services</h3>
            <ul className="space-y-2 text-sm text-gray-400">
              <li><Link href="/about" className="hover:text-white">About Us</Link></li>
              <li><Link href="/contact" className="hover:text-white">Contact</Link></li>
            </ul>
          </div>

          {/* Contact */}
          <div>
            <h3 className="font-semibold mb-4">Contact</h3>
            <ul className="space-y-2 text-sm text-gray-400">
              <li>Venice, Italy</li>
              <li>info@veniceparcley.com</li>
              <li>+39 123 456 7890</li>
            </ul>
          </div>
        </div>

        <div className="border-t border-gray-800 mt-8 pt-8 text-center text-sm text-gray-400">
          <p>&copy; {new Date().getFullYear()} Venice Parcley. All rights reserved.</p>
        </div>
      </div>
    </footer>
  )
}