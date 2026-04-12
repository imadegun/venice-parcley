'use client'

import { usePathname } from 'next/navigation'
import { Header } from '@/components/layout/header'
import { Footer } from '@/components/layout/footer'

export function RouteShell({ children }: { children: React.ReactNode }) {
  const pathname = usePathname()
  const isBackendRoute = pathname.startsWith('/admin') || pathname.startsWith('/login') || pathname.startsWith('/register')

  if (isBackendRoute) {
    return <>{children}</>
  }

  return (
    <>
      <Header />
      <main className="flex-1">{children}</main>
      <Footer />
    </>
  )
}
