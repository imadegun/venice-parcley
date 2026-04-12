export type Json =
  | string
  | number
  | boolean
  | null
  | { [key: string]: Json | undefined }
  | Json[]

export interface Database {
  public: {
    Tables: {
      apartments: {
        Row: {
          id: string
          created_at: string
          updated_at: string
          name: string
          description: string
          type: 'artistic_studio' | 'design_loft' | 'creative_suite' | 'artist_residence'
          address: string
          city: string
          country: string
          price_per_night: number
          max_guests: number
          bedrooms: number
          bathrooms: number
          size_sqm: number
          amenities: string[]
          images: string[]
          is_available: boolean
          owner_id: string
        }
        Insert: {
          id?: string
          created_at?: string
          updated_at?: string
          name: string
          description: string
          type: 'artistic_studio' | 'design_loft' | 'creative_suite' | 'artist_residence'
          address: string
          city: string
          country: string
          price_per_night: number
          max_guests: number
          bedrooms: number
          bathrooms: number
          size_sqm: number
          amenities: string[]
          images: string[]
          is_available?: boolean
          owner_id: string
        }
        Update: {
          id?: string
          created_at?: string
          updated_at?: string
          name?: string
          description?: string
          type?: 'artistic_studio' | 'design_loft' | 'creative_suite' | 'artist_residence'
          address?: string
          city?: string
          country?: string
          price_per_night?: number
          max_guests?: number
          bedrooms?: number
          bathrooms?: number
          size_sqm?: number
          amenities?: string[]
          images?: string[]
          is_available?: boolean
          owner_id?: string
        }
      }
      transportation_services: {
        Row: {
          id: string
          created_at: string
          updated_at: string
          name: string
          type: 'car' | 'taxi' | 'chauffeur' | 'airport_transfer'
          description: string
          base_price: number
          price_per_km: number
          price_per_hour: number
          max_passengers: number
          is_available: boolean
          provider_id: string
        }
        Insert: {
          id?: string
          created_at?: string
          updated_at?: string
          name: string
          type: 'car' | 'taxi' | 'chauffeur' | 'airport_transfer'
          description: string
          base_price: number
          price_per_km: number
          price_per_hour: number
          max_passengers: number
          is_available?: boolean
          provider_id: string
        }
        Update: {
          id?: string
          created_at?: string
          updated_at?: string
          name?: string
          type?: 'car' | 'taxi' | 'chauffeur' | 'airport_transfer'
          description?: string
          base_price?: number
          price_per_km?: number
          price_per_hour?: number
          max_passengers?: number
          is_available?: boolean
          provider_id?: string
        }
      }
      bookings: {
        Row: {
          id: string
          created_at: string
          updated_at: string
          user_id: string
          apartment_id?: string
          transportation_id?: string
          check_in_date?: string
          check_out_date?: string
          service_date?: string
          service_time?: string
          total_guests?: number
          total_cents: number
          status: 'pending' | 'confirmed' | 'cancelled' | 'completed'
          special_requests?: string
          contact_info: Json
        }
        Insert: {
          id?: string
          created_at?: string
          updated_at?: string
          user_id: string
          apartment_id?: string
          transportation_id?: string
          check_in_date?: string
          check_out_date?: string
          service_date?: string
          service_time?: string
          total_guests?: number
          total_cents: number
          status?: 'pending' | 'confirmed' | 'cancelled' | 'completed'
          special_requests?: string
          contact_info: Json
        }
        Update: {
          id?: string
          created_at?: string
          updated_at?: string
          user_id?: string
          apartment_id?: string
          transportation_id?: string
          check_in_date?: string
          check_out_date?: string
          service_date?: string
          service_time?: string
          total_guests?: number
          total_cents?: number
          status?: 'pending' | 'confirmed' | 'cancelled' | 'completed'
          special_requests?: string
          contact_info?: Json
        }
      }
      user_profiles: {
        Row: {
          id: string
          created_at: string
          updated_at: string
          user_id: string
          full_name: string
          phone?: string
          date_of_birth?: string
          nationality?: string
          passport_number?: string
          emergency_contact?: Json
          preferences: Json
          role: 'user' | 'admin' | 'administrator'
        }
        Insert: {
          id?: string
          created_at?: string
          updated_at?: string
          user_id: string
          full_name: string
          phone?: string
          date_of_birth?: string
          nationality?: string
          passport_number?: string
          emergency_contact?: Json
          preferences?: Json
          role?: 'user' | 'admin' | 'administrator'
        }
        Update: {
          id?: string
          created_at?: string
          updated_at?: string
          user_id?: string
          full_name?: string
          phone?: string
          date_of_birth?: string
          nationality?: string
          passport_number?: string
          emergency_contact?: Json
          preferences?: Json
          role?: 'user' | 'admin' | 'administrator'
        }
      }
      content_sections: {
        Row: {
          id: string
          key: 'homepage' | 'about' | 'contact'
          payload: Json
          status: 'draft' | 'published'
          version: number
          created_by?: string
          updated_by?: string
          created_at: string
          updated_at: string
        }
        Insert: {
          id?: string
          key: 'homepage' | 'about' | 'contact'
          payload: Json
          status?: 'draft' | 'published'
          version?: number
          created_by?: string
          updated_by?: string
          created_at?: string
          updated_at?: string
        }
        Update: {
          id?: string
          key?: 'homepage' | 'about' | 'contact'
          payload?: Json
          status?: 'draft' | 'published'
          version?: number
          created_by?: string
          updated_by?: string
          created_at?: string
          updated_at?: string
        }
      }
      content_revisions: {
        Row: {
          id: string
          section_id: string
          key: 'homepage' | 'about' | 'contact'
          payload: Json
          version: number
          published_by?: string
          published_at: string
        }
        Insert: {
          id?: string
          section_id: string
          key: 'homepage' | 'about' | 'contact'
          payload: Json
          version: number
          published_by?: string
          published_at?: string
        }
        Update: {
          id?: string
          section_id?: string
          key?: 'homepage' | 'about' | 'contact'
          payload?: Json
          version?: number
          published_by?: string
          published_at?: string
        }
      }
    }
    Views: {
      [_ in never]: never
    }
    Functions: {
      [_ in never]: never
    }
    Enums: {
      [_ in never]: never
    }
    CompositeTypes: {
      [_ in never]: never
    }
  }
}
