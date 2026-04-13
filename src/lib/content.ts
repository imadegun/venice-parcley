// Content Management System
// Simple in-memory CMS for website content management

export interface HeroContent {
  title: {
    en: string
    it: string
  }
  subtitle: {
    en: string
    it: string
  }
  ctaText: {
    en: string
    it: string
  }
  backgroundImages: string[]
}

export interface AboutContent {
  title: {
    en: string
    it: string
  }
  description: {
    en: string
    it: string
  }
  features: Array<{
    title: {
      en: string
      it: string
    }
    description: {
      en: string
      it: string
    }
    icon: string
  }>
}

export interface PropertyType {
  id: string
  name: {
    en: string
    it: string
  }
  description: {
    en: string
    it: string
  }
  heroImage: string
  features: {
    en: string[]
    it: string[]
  }
}

export interface HomepageContent {
  hero: HeroContent
  featured: {
    title: string
    description: string
  }
  about: {
    title: string
    content: string
  }
}

// Website Content Database
export const websiteContent = {
  hero: {
    title: {
      en: 'Discover Artistic Living Spaces',
      it: 'Scopri Spazi di Vita Artistici'
    },
    subtitle: {
      en: 'Luxury apartments designed for art lovers and creative souls',
      it: 'Appartamenti di lusso progettati per amanti dell\'arte e anime creative'
    },
    ctaText: {
      en: 'Explore Apartments',
      it: 'Esplora Appartamenti'
    },
    backgroundImages: [
      'https://images.unsplash.com/photo-1545324418-cc1a3fa00c00?w=1920',
      'https://images.unsplash.com/photo-1564013799919-ab600027ffc6?w=1920',
      'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=1920',
      'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=1920'
    ]
  } as HeroContent,

  about: {
    title: {
      en: 'About Venice Parcley',
      it: 'Chi Siamo'
    },
    description: {
      en: 'Venice Parcley is dedicated to providing unique artistic living experiences in the heart of Venice. Our curated collection of apartments showcases distinctive design and creative spaces for art lovers, designers, and discerning travelers seeking authentic Venetian experiences.',
      it: 'Venice Parcley è dedicata a fornire esperienze di vita artistica uniche nel cuore di Venezia. La nostra collezione curata di appartamenti mostra design distintivi e spazi creativi per amanti dell\'arte, designer e viaggiatori esigenti che cercano esperienze veneziane autentiche.'
    },
    features: [
      {
        title: {
          en: 'Artistic Design',
          it: 'Design Artistico'
        },
        description: {
          en: 'Each apartment is uniquely designed with artistic elements and creative inspiration.',
          it: 'Ogni appartamento è progettato in modo unico con elementi artistici e ispirazione creativa.'
        },
        icon: 'palette'
      },
      {
        title: {
          en: 'Prime Locations',
          it: 'Ubicazioni Prime'
        },
        description: {
          en: 'Located in the most artistic and cultural areas of Venice.',
          it: 'Situati nelle aree più artistiche e culturali di Venezia.'
        },
        icon: 'map-pin'
      },
      {
        title: {
          en: 'Concierge Service',
          it: 'Servizio Concierge'
        },
        description: {
          en: 'Personal concierge services to enhance your artistic journey.',
          it: 'Servizi concierge personali per migliorare il tuo viaggio artistico.'
        },
        icon: 'user-check'
      }
    ]
  } as AboutContent,

  propertyTypes: [
    {
      id: 'artistic-studios',
      name: {
        en: 'Artistic Studios',
        it: 'Studi Artistici'
      },
      description: {
        en: 'Intimate creative spaces perfect for individual artists and designers.',
        it: 'Spazi creativi intimi perfetti per artisti e designer individuali.'
      },
      heroImage: 'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=800',
      features: {
        en: [
          'Natural lighting optimized for creativity',
          'Compact yet functional workspaces',
          'Authentic Venetian architectural details',
          'Modern amenities in historic settings'
        ],
        it: [
          'Illuminazione naturale ottimizzata per la creatività',
          'Spazi di lavoro compatti ma funzionali',
          'Dettagli architettonici veneziani autentici',
          'Servizi moderni in ambienti storici'
        ]
      }
    },
    {
      id: 'design-lofts',
      name: {
        en: 'Design Lofts',
        it: 'Loft di Design'
      },
      description: {
        en: 'Spacious loft apartments with industrial-chic design elements.',
        it: 'Ampii appartamenti loft con elementi di design industrial-chic.'
      },
      heroImage: 'https://images.unsplash.com/photo-1564013799919-ab600027ffc6?w=800',
      features: {
        en: [
          'High ceilings with exposed architectural elements',
          'Open-plan living spaces',
          'Eclectic art collections',
          'Rooftop terraces available'
        ],
        it: [
          'Alti soffitti con elementi architettonici esposti',
          'Spazi living open-plan',
          'Collezioni d\'arte eclettiche',
          'Terrazze sul tetto disponibili'
        ]
      }
    },
    {
      id: 'creative-suites',
      name: {
        en: 'Creative Suites',
        it: 'Suite Creative'
      },
      description: {
        en: 'Luxurious suites designed for creative professionals and small groups.',
        it: 'Suite lussuose progettate per professionisti creativi e piccoli gruppi.'
      },
      heroImage: 'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=800',
      features: {
        en: [
          'Dedicated creative workspaces',
          'Premium furnishings and art installations',
          'Multiple rooms for collaborative work',
          'Soundproofing for focused creativity'
        ],
        it: [
          'Spazi di lavoro creativi dedicati',
          'Arredamenti premium e installazioni artistiche',
          'Più stanze per lavoro collaborativo',
          'Insonorizzazione per creatività focalizzata'
        ]
      }
    },
    {
      id: 'artist-residences',
      name: {
        en: 'Artist Residences',
        it: 'Residenze d\'Artista'
      },
      description: {
        en: 'Exclusive residences for established artists and long-term creative stays.',
        it: 'Residenze esclusive per artisti affermati e soggiorni creativi a lungo termine.'
      },
      heroImage: 'https://images.unsplash.com/photo-1545324418-cc1a3fa00c00?w=800',
      features: {
        en: [
          'Professional art studios with northern light',
          'Private galleries for exhibitions',
          'Artist-in-residence programs',
          'Extended stay discounts available'
        ],
        it: [
          'Studi d\'arte professionali con luce nordica',
          'Gallerie private per mostre',
          'Programmi di residenza artistica',
          'Sconti per soggiorni prolungati disponibili'
        ]
      }
    }
  ] as PropertyType[]
}

export const defaultHomepageContent: HomepageContent = {
  hero: websiteContent.hero,
  featured: {
    title: 'Featured Apartments',
    description:
      'Experience Venice like never before in our carefully curated collection of artistic apartments.'
  },
  about: {
    title: 'About Venice Parcley',
    content:
      'We connect art lovers with extraordinary living spaces in Venice, offering a unique blend of luxury accommodation and artistic inspiration.'
  }
}

// Content Management Functions
export function getHeroContent(): HeroContent {
  return websiteContent.hero
}

export function getAboutContent(): AboutContent {
  return websiteContent.about
}

export function getPropertyTypes(): PropertyType[] {
  return websiteContent.propertyTypes
}

export function getPropertyTypeById(id: string): PropertyType | undefined {
  return websiteContent.propertyTypes.find(type => type.id === id)
}

export async function getHomepageContent(): Promise<HomepageContent> {
  try {
    const { getPublishedContentSection } = await import('@/lib/content-service')
    const section = await getPublishedContentSection('homepage')

    if (section?.payload && typeof section.payload === 'object' && !Array.isArray(section.payload)) {
      return section.payload as unknown as HomepageContent
    }
  } catch {
    // Fallback to default content when DB is unavailable
  }

  return defaultHomepageContent
}

// In a real CMS, these would update a database
export function updateHeroContent(updates: Partial<HeroContent>): void {
  Object.assign(websiteContent.hero, updates)
}

export function updateAboutContent(updates: Partial<AboutContent>): void {
  Object.assign(websiteContent.about, updates)
}

export function updatePropertyType(id: string, updates: Partial<PropertyType>): void {
  const index = websiteContent.propertyTypes.findIndex(type => type.id === id)
  if (index !== -1) {
    Object.assign(websiteContent.propertyTypes[index], updates)
  }
}
