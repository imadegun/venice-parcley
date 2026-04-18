import { cn } from "@/lib/utils"

interface ContainerProps {
  children: React.ReactNode
  className?: string
  spacing?: 'none' | 'sm' | 'md' | 'lg' | 'xl' | 'xxl'
  maxWidth?: 'sm' | 'md' | 'lg' | 'xl' | '2xl' | '3xl' | '4xl' | '5xl' | '6xl' | 'full'
}

export function Container({ 
  children, 
  className, 
  spacing = 'lg',
  maxWidth = '4xl'
}: ContainerProps) {
  const spacingClasses = {
    none: '',
    sm: 'py-4',
    md: 'py-8',
    lg: 'py-12',
    xl: 'py-16',
    xxl: 'py-36' // Extra padding to clear fixed header (144px = 9rem) - matches apartments page pt-36
  }

  const maxWidthClasses = {
    sm: 'max-w-sm',
    md: 'max-w-md',
    lg: 'max-w-lg',
    xl: 'max-w-xl',
    '2xl': 'max-w-2xl',
    '3xl': 'max-w-3xl',
    '4xl': 'max-w-4xl',
    '5xl': 'max-w-5xl',
    '6xl': 'max-w-6xl',
    full: 'max-w-full'
  }

  return (
    <div className={cn(
      "container mx-auto px-4 sm:px-6 lg:px-8",
      spacingClasses[spacing],
      maxWidthClasses[maxWidth],
      className
    )}>
      {children}
    </div>
  )
}