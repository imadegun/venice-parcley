# Venice Parcley - Luxury Artistic Apartments

A full-stack web application for booking luxury artistic apartments in Venice. Built with Next.js, Supabase, Stripe, and Tailwind CSS.

## Features

### Guest Features
- Browse luxury artistic apartments with rich media and design details
- Real-time availability calendar
- Complete booking flow with Stripe payments
- Member registration, login, and preference profiles
- Loyalty points system
- Manage reservations (view, modify, cancel)

### Admin Features
- Dashboard with booking overview and metrics
- Apartment CRUD management with image gallery
- Transportation service and driver management
- Content Management System (CMS):
  - **Menu Management** – Create and organize navigation menu items with auto-slug generation
  - **Page Content Management** – Edit rich text content for menu-driven pages (About, Contact, Neighbourhood, How to Get Here) via a simple textarea editor
- Theme customization (header gradient colors, footer color)

### Technical Highlights
- **Stack:** Next.js 14 (App Router), TypeScript, Supabase (PostgreSQL), Stripe, Tailwind CSS, i18next
- **Auth:** Supabase Auth with role-based access control
- **Database:** Row Level Security (RLS) policies for data protection
- **Internationalization:** English/Italian language support
- **Mobile-first responsive design** with custom floating menu UI

## Getting Started

1. Clone the repository
2. Install dependencies:
   ```bash
   npm install
   ```
3. Set up environment variables (copy `.env.example` to `.env.local` and fill in Supabase and Stripe credentials)
4. Run database migrations in `database-schema.sql` on your Supabase instance
5. Start the development server:
   ```bash
   npm run dev
   ```
6. Open [http://localhost:3000](http://localhost:3000)

## Project Structure

- `src/app/` – Next.js app router pages (server and client components)
- `src/components/` – Reusable React components (UI, admin, apartments, etc.)
- `src/lib/` – Utilities, Supabase clients, content services, auth
- `src/types/` – TypeScript type definitions
- `villa-spa/` – Main application (the "spa" domain)
- `_bmad-output/` – Planning and implementation artifacts

## Admin Panel

Access the admin interface at `/admin` (requires admin role). Key sections:
- Dashboard
- Apartment Management
- Booking Management
- Gallery Management
- Content Management (Homepage, About, Contact, Menu, **Page Content**)
- Settings (theme colors)

## Content Management

The CMS allows administrators to:
- **Manage Menu Items** – Add, edit, reorder, activate/deactivate navigation links with automatic URL slug generation from labels.
- **Edit Page Content** – For each menu item (e.g., About, Contact), edit the HTML content that appears on the corresponding public page. Changes are reflected immediately.

## Deployment

Deploy easily on Vercel. Connect your Git repository and set environment variables. Supabase and Stripe credentials are required.

## License

Proprietary – All rights reserved.
