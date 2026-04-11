import { createInstance } from 'i18next'
import { initReactI18next } from 'react-i18next'

// Language detection
const getBrowserLanguage = (): string => {
  if (typeof window === 'undefined') return 'en'

  const browserLang = navigator.language || 'en'
  const country = browserLang.split('-')[1]?.toLowerCase()

  // Auto-detect Italian for Italy
  if (country === 'it' || browserLang.startsWith('it')) {
    return 'it'
  }

  return 'en'
}

const resources = {
  en: {
    translation: {
      // Navigation
      nav: {
        apartments: 'Apartments',
        transportation: 'Transportation',
        about: 'About',
        contact: 'Contact',
        signIn: 'Sign In',
        signUp: 'Sign Up',
        account: 'Account',
        myBookings: 'My Bookings',
        profile: 'Profile',
        signOut: 'Sign Out',
        browseTreatments: 'Browse Treatments'
      },
      // Hero
      hero: {
        title: 'Discover Artistic Living Spaces',
        subtitle: 'Luxury apartments designed for art lovers and creative souls',
        cta: 'Explore Apartments'
      },
      // Apartments
      apartments: {
        title: 'Our Artistic Apartments',
        subtitle: 'Unique spaces crafted for creativity and inspiration',
        filterBy: 'Filter by',
        allCategories: 'All Categories',
        artisticStudios: 'Artistic Studios',
        designLofts: 'Design Lofts',
        creativeSuites: 'Creative Suites',
        artistResidences: 'Artist Residences',
        bookNow: 'Book Now',
        perNight: 'per night',
        guests: 'guests',
        bedrooms: 'bedrooms',
        bathrooms: 'bathrooms',
        sqm: 'sqm'
      },
      // Booking
      booking: {
        selectDates: 'Select Dates',
        checkIn: 'Check-in',
        checkOut: 'Check-out',
        guests: 'Guests',
        bookNow: 'Book Now',
        confirmBooking: 'Confirm Booking',
        bookingSummary: 'Booking Summary',
        total: 'Total',
        nights: 'nights'
      },
      // Footer
      footer: {
        apartments: 'Apartments',
        transportation: 'Transportation',
        services: 'Services',
        support: 'Support',
        concierge: 'Concierge',
        support247: '24/7 Support',
        bookingHelp: 'Booking Help',
        terms: 'Terms of Service',
        rights: 'All rights reserved'
      },
      // Common
      common: {
        loading: 'Loading...',
        error: 'An error occurred',
        retry: 'Try Again',
        cancel: 'Cancel',
        confirm: 'Confirm',
        save: 'Save',
        edit: 'Edit',
        delete: 'Delete',
        close: 'Close',
        next: 'Next',
        previous: 'Previous',
        submit: 'Submit'
      }
    }
  },
  it: {
    translation: {
      // Navigation
      nav: {
        apartments: 'Appartamenti',
        transportation: 'Trasporto',
        about: 'Chi Siamo',
        contact: 'Contatti',
        signIn: 'Accedi',
        signUp: 'Registrati',
        account: 'Account',
        myBookings: 'Le Mie Prenotazioni',
        profile: 'Profilo',
        signOut: 'Esci',
        browseTreatments: 'Sfoglia Trattamenti'
      },
      // Hero
      hero: {
        title: 'Scopri Spazi di Vita Artistici',
        subtitle: 'Appartamenti di lusso progettati per amanti dell\'arte e anime creative',
        cta: 'Esplora Appartamenti'
      },
      // Apartments
      apartments: {
        title: 'I Nostri Appartamenti Artistici',
        subtitle: 'Spazi unici creati per creatività e ispirazione',
        filterBy: 'Filtra per',
        allCategories: 'Tutte le Categorie',
        artisticStudios: 'Studi Artistici',
        designLofts: 'Loft di Design',
        creativeSuites: 'Suite Creative',
        artistResidences: 'Residenze d\'Artista',
        bookNow: 'Prenota Ora',
        perNight: 'per notte',
        guests: 'ospiti',
        bedrooms: 'camere',
        bathrooms: 'bagni',
        sqm: 'mq'
      },
      // Booking
      booking: {
        selectDates: 'Seleziona Date',
        checkIn: 'Check-in',
        checkOut: 'Check-out',
        guests: 'Ospiti',
        bookNow: 'Prenota Ora',
        confirmBooking: 'Conferma Prenotazione',
        bookingSummary: 'Riepilogo Prenotazione',
        total: 'Totale',
        nights: 'notti'
      },
      // Footer
      footer: {
        apartments: 'Appartamenti',
        transportation: 'Trasporto',
        services: 'Servizi',
        support: 'Supporto',
        concierge: 'Concierge',
        support247: 'Supporto 24/7',
        bookingHelp: 'Aiuto Prenotazione',
        terms: 'Termini di Servizio',
        rights: 'Tutti i diritti riservati'
      },
      // Common
      common: {
        loading: 'Caricamento...',
        error: 'Si è verificato un errore',
        retry: 'Riprova',
        cancel: 'Annulla',
        confirm: 'Conferma',
        save: 'Salva',
        edit: 'Modifica',
        delete: 'Elimina',
        close: 'Chiudi',
        next: 'Avanti',
        previous: 'Indietro',
        submit: 'Invia'
      }
    }
  }
}

const i18n = createInstance({
  resources,
  lng: getBrowserLanguage(),
  fallbackLng: 'en',
  interpolation: {
    escapeValue: false,
  },
})

i18n.use(initReactI18next).init()

export default i18n
export { getBrowserLanguage }