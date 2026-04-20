import { pgTable, uuid, text, integer, boolean, jsonb, date, timestamp, pgEnum, index } from 'drizzle-orm/pg-core';

export const bookingStatusEnum = pgEnum('booking_status', ['confirmed', 'cancelled', 'completed']);
export const userRoleEnum = pgEnum('user_role', ['guest', 'member', 'admin']);
export const loyaltyPointTypeEnum = pgEnum('loyalty_point_type', ['earned', 'spent']);

export const apartments = pgTable('apartments', {
  id: uuid('id').primaryKey().defaultRandom(),
  slug: text('slug').unique().notNull(),
  name: text('name').notNull(),
  description: text('description').notNull(),
  shortDescription: text('short_description'),
  maxGuests: integer('max_guests').notNull(),
  bedrooms: integer('bedrooms').notNull(),
  basePriceCents: integer('base_price_cents').notNull(),
  imageUrl: text('image_url'),
  galleryImages: text('gallery_images').array(),
  amenities: text('amenities').array(),
  locationDetails: jsonb('location_details'),
  isActive: boolean('is_active').default(true),
  createdAt: timestamp('created_at', { withTimezone: true }).defaultNow(),
  updatedAt: timestamp('updated_at', { withTimezone: true }).defaultNow(),
}, (table) => ({
  idxApartmentsActive: index('idx_apartments_active').on(table.isActive),
}));

export const bookings = pgTable('bookings', {
  id: uuid('id').primaryKey().defaultRandom(),
  userId: uuid('user_id'), // Note: auth.users not available, may need to create users table
  apartmentId: uuid('apartment_id').references(() => apartments.id, { onDelete: 'cascade' }),
  checkInDate: date('check_in_date').notNull(),
  checkOutDate: date('check_out_date').notNull(),
  totalGuests: integer('total_guests').notNull(),
  status: bookingStatusEnum('status').default('confirmed'),
  totalCents: integer('total_cents').notNull(),
  specialRequests: text('special_requests'),
  cancellationReason: text('cancellation_reason'),
  cancelledAt: timestamp('cancelled_at', { withTimezone: true }),
  createdAt: timestamp('created_at', { withTimezone: true }).defaultNow(),
  updatedAt: timestamp('updated_at', { withTimezone: true }).defaultNow(),
}, (table) => ({
  idxBookingsUser: index('idx_bookings_user').on(table.userId),
  idxBookingsApartment: index('idx_bookings_apartment').on(table.apartmentId),
  idxBookingsDates: index('idx_bookings_dates').on(table.checkInDate, table.checkOutDate),
  idxBookingsStatus: index('idx_bookings_status').on(table.status),
}));

export const loyaltyPoints = pgTable('loyalty_points', {
  id: uuid('id').primaryKey().defaultRandom(),
  userId: uuid('user_id'), // Reference to users table if created
  points: integer('points').notNull(),
  type: loyaltyPointTypeEnum('type').notNull(),
  bookingId: uuid('booking_id').references(() => bookings.id, { onDelete: 'set null' }),
  description: text('description'),
  createdAt: timestamp('created_at', { withTimezone: true }).defaultNow(),
}, (table) => ({
  idxLoyaltyUser: index('idx_loyalty_user').on(table.userId),
}));

export const profiles = pgTable('profiles', {
  id: uuid('id').primaryKey(), // References users table
  email: text('email').notNull(),
  fullName: text('full_name'),
  phone: text('phone'),
  role: userRoleEnum('role').default('guest'),
  notificationPreferences: jsonb('notification_preferences').default({ email: true, sms: false }),
  createdAt: timestamp('created_at', { withTimezone: true }).defaultNow(),
  updatedAt: timestamp('updated_at', { withTimezone: true }).defaultNow(),
}, (table) => ({
  idxProfilesEmail: index('idx_profiles_email').on(table.email),
}));

export const contentSections = pgTable('content_sections', {
  id: uuid('id').primaryKey().defaultRandom(),
  key: text('key').notNull().unique(),
  payload: jsonb('payload').notNull(),
  status: text('status').notNull().default('draft'),
  version: integer('version').notNull().default(1),
  createdBy: uuid('created_by'),
  updatedBy: uuid('updated_by'),
  createdAt: timestamp('created_at', { withTimezone: true }).defaultNow(),
  updatedAt: timestamp('updated_at', { withTimezone: true }).defaultNow(),
}, (table) => ({
  idxContentSectionsKeyStatus: index('idx_content_sections_key_status').on(table.key, table.status),
}));

export const contentRevisions = pgTable('content_revisions', {
  id: uuid('id').primaryKey().defaultRandom(),
  sectionId: uuid('section_id').notNull().references(() => contentSections.id, { onDelete: 'cascade' }),
  key: text('key').notNull(),
  payload: jsonb('payload').notNull(),
  version: integer('version').notNull(),
  publishedBy: uuid('published_by'),
  publishedAt: timestamp('published_at', { withTimezone: true }).defaultNow(),
}, (table) => ({
  idxContentRevisionsSection: index('idx_content_revisions_section').on(table.sectionId, table.version),
}));

export const menuItems = pgTable('menu_items', {
  id: uuid('id').primaryKey().defaultRandom(),
  label: text('label').notNull(),
  href: text('href').notNull(),
  isActive: boolean('is_active').default(true),
  sortOrder: integer('sort_order').default(0),
  content: text('content'),
  mapEmbed: text('map_embed'),
  createdAt: timestamp('created_at', { withTimezone: true }).defaultNow(),
  updatedAt: timestamp('updated_at', { withTimezone: true }).defaultNow(),
}, (table) => ({
  idxMenuItemsActiveOrder: index('idx_menu_items_active_order').on(table.isActive, table.sortOrder),
}));

export const settings = pgTable('settings', {
  id: uuid('id').primaryKey().defaultRandom(),
  key: text('key').unique().notNull(),
  value: jsonb('value'),
  createdAt: timestamp('created_at', { withTimezone: true }).defaultNow(),
  updatedAt: timestamp('updated_at', { withTimezone: true }).defaultNow(),
});

export const gallery = pgTable('gallery', {
  id: uuid('id').primaryKey().defaultRandom(),
  title: text('title').notNull(),
  description: text('description'),
  imageUrl: text('image_url').notNull(),
  category: text('category'),
  isActive: boolean('is_active').default(true),
  sortOrder: integer('sort_order').default(0),
  createdAt: timestamp('created_at', { withTimezone: true }).defaultNow(),
  updatedAt: timestamp('updated_at', { withTimezone: true }).defaultNow(),
});

export const users = pgTable('users', {
  id: uuid('id').primaryKey().defaultRandom(),
  email: text('email').unique().notNull(),
  passwordHash: text('password_hash'),
  emailConfirmedAt: timestamp('email_confirmed_at', { withTimezone: true }),
  createdAt: timestamp('created_at', { withTimezone: true }).defaultNow(),
  updatedAt: timestamp('updated_at', { withTimezone: true }).defaultNow(),
});

export const userProfiles = pgTable('user_profiles', {
  id: uuid('id').primaryKey().references(() => users.id),
  email: text('email').notNull(),
  fullName: text('full_name'),
  role: userRoleEnum('role').default('guest'),
  createdAt: timestamp('created_at', { withTimezone: true }).defaultNow(),
  updatedAt: timestamp('updated_at', { withTimezone: true }).defaultNow(),
});