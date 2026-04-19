'use client'

import { useEffect, useRef, useState, ReactNode } from 'react'
import { cn } from '@/lib/utils'

interface ScrollRevealProps {
  children: ReactNode
  className?: string
  delay?: number // 0, 100, 200, 300, etc.
  direction?: 'up' | 'down' | 'left' | 'right' | 'scale'
  duration?: 500 | 700 | 1000 | 1200
  once?: boolean // Whether to animate only once
  threshold?: number // 0-1, how much of element must be visible to trigger
}

export function ScrollReveal({
  children,
  className,
  delay = 0,
  direction = 'up',
  duration = 700,
  once = true,
  threshold = 0.1,
}: ScrollRevealProps) {
  const ref = useRef<HTMLDivElement>(null)
  const [isVisible, setIsVisible] = useState(false)

  useEffect(() => {
    const observer = new IntersectionObserver(
      ([entry]) => {
        if (entry.isIntersecting) {
          setIsVisible(true)
          if (once) {
            observer.disconnect()
          }
        } else if (!once) {
          setIsVisible(false)
        }
      },
      {
        threshold,
        rootMargin: '0px 0px -50px 0px', // Trigger slightly before element enters viewport
      }
    )

    const currentRef = ref.current
    if (currentRef) {
      observer.observe(currentRef)
    }

    return () => {
      if (currentRef) {
        observer.unobserve(currentRef)
      }
    }
  }, [once, threshold])

  // Define animation variants
  const getAnimationStyles = () => {
    if (isVisible) {
      return {
        opacity: 1,
        transform: 'translate(0, 0) scale(1)',
      }
    }

    switch (direction) {
      case 'up':
        return {
          opacity: 0,
          transform: 'translateY(40px)',
        }
      case 'down':
        return {
          opacity: 0,
          transform: 'translateY(-40px)',
        }
      case 'left':
        return {
          opacity: 0,
          transform: 'translateX(40px)',
        }
      case 'right':
        return {
          opacity: 0,
          transform: 'translateX(-40px)',
        }
      case 'scale':
        return {
          opacity: 0,
          transform: 'scale(0.9)',
        }
      default:
        return {
          opacity: 0,
          transform: 'translateY(40px)',
        }
    }
  }

  const animationStyles = getAnimationStyles()

  return (
    <div
      ref={ref}
      className={cn('transition-all ease-out', className)}
      style={{
        opacity: animationStyles.opacity,
        transform: animationStyles.transform,
        transitionDuration: `${duration}ms`,
        transitionDelay: `${delay}ms`,
        willChange: 'opacity, transform',
      }}
    >
      {children}
    </div>
  )
}
