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
- **Full Content Management System (CMS):**
  - **Menu Management** – Create, edit, delete, and reorder navigation items with auto-slug generation from labels
  - **Page Content Editor** – Edit rich text/HTML content for any menu-driven page (About, Contact, Neighbourhood, How to Get Here)
  - **Map Embed Support** – Add Google Maps embed code to the Contact page
  - **System Page Filtering** – Apartments, login, register, and admin pages are automatically excluded
- Theme customization (header gradient colors, footer color)

### UI/UX Enhancements
- **Configurable Container Spacing** – Adjustable vertical padding (none, sm, md, lg, xl) for ideal content spacing
- **Header Entrance Animation** – Smooth slide-down with fade-in effect on page load
- **Title Text Animations** – Modern fade-in-up effect with staggered delays for multi-section pages
- **GPU-accelerated animations** using transform and opacity for optimal performance
- **Accessibility-aware** – Respects `prefers-reduced-motion` settings

### Technical Highlights
- **Stack:** Next.js 14 (App Router), TypeScript, Supabase (PostgreSQL), Stripe, Tailwind CSS, i18next
- **Auth:** Supabase Auth with role-based access control
- **Database:** Row Level Security (RLS) policies for data protection
- **Internationalization:** English/Italian language support
- **Mobile-first responsive design** with custom floating menu UI
- **Dynamic Page Rendering** – Content fetched from database and rendered on-demand

## Getting Started

1. Clone the repository
2. Install dependencies:
   ```bash
   npm install
   ```
3. Set up environment variables (copy `.env.example` to `.env.local` and fill in Supabase and Stripe credentials)
4. **Apply database migrations:**
   - Run the SQL files in `migrations/` on your Supabase instance (see `MIGRATION_GUIDE.md`)
   - Or run the full `database-schema.sql` to set up all tables
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
- `migrations/` – Database migration SQL files
- `scripts/` – Utility scripts (schema checker, etc.)

## Admin Panel

Access the admin interface at `/admin` (requires admin role). Key sections:
- **Dashboard** – Overview with metrics and quick actions
- **Apartment Management** – CRUD for luxury apartments
- **Booking Management** – View and manage all reservations
- **Gallery Management** – Image upload and organization
- **Content Management:**
  - **Menu** – Manage navigation structure
  - **Pages** – Edit content for About, Contact, Neighbourhood, How to Get Here
- **Settings** – Theme colors and configuration

## Content Management

The CMS provides full control over website content:

### Menu Management (`/admin/content/menu`)
- Create menu items with label, URL, and display order
- Auto-generates URL-friendly slugs from labels
- Edit, delete, and reorder items
- Toggle active/inactive status

### Page Content (`/admin/content/pages`)
- List of all editable pages with content status badges
- Edit rich text/HTML content in a textarea
- Add Google Maps embed code (Contact page)
- System pages (apartments, login, register, admin) are hidden
- Changes reflect immediately on the frontend

### Dynamic Pages
The following pages are dynamically generated from `menu_items` content:
- `/about`
- `/contact` (with optional map embed)
- `/neighbourhood`
- `/how-to-get-here`

## UI/UX Features

### Container Spacing
The `Container` component supports configurable vertical padding:
```tsx
<Container spacing="xl">  // none, sm, md, lg, xl
  {/* content */}
</Container>
```

### Animations
- **Header:** Slides down from top on page load (0.6s ease-out)
- **Titles:** Fade in and slide up (0.8s ease-out) with optional staggered delays
- Applied to all major page titles and admin sections

See `UI_IMPROVEMENTS.md` for full details.

## Database Migrations

**Important:** The content management features require two new columns in the `menu_items` table:

1. `content TEXT` – Stores rich text/HTML for page content
2. `map_embed TEXT` – Stores Google Maps iframe embed code

See `MIGRATION_GUIDE.md` for step-by-step instructions on applying these migrations to your Supabase instance.

## Deployment

Deploy easily on Vercel. Connect your Git repository and set environment variables. Supabase and Stripe credentials are required.

## Documentation

- `MIGRATION_GUIDE.md` – Database migration instructions
- `UI_IMPROVEMENTS.md` – UI/UX enhancement details
- `note_marcello.txt` – Project notes and reminders
- `_bmad-output/planning-artifacts/` – Full project planning documents (PRD, architecture, epics, implementation status)

## License

Proprietary – All rights reserved.
