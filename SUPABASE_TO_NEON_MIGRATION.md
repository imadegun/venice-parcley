# Supabase to Neon PostgreSQL Migration Guide with Prisma ORM

## Migration Status: In Progress ✅

---

## Step 1: Preparation

### 1.1 Install Dependencies
```bash
npm install prisma --save-dev
npm install @prisma/client
```

### 1.2 Configure Environment Variables
Add these variables to `.env.local`:
```env
# Neon Database Connection
DATABASE_URL="postgresql://user:password@ep-example-123456.us-east-2.aws.neon.tech/neondb?sslmode=require"
DIRECT_URL="postgresql://user:password@ep-example-123456.us-east-2.aws.neon.tech/neondb?sslmode=require"

# Auth (you can keep Supabase Auth or migrate to NextAuth)
NEXT_PUBLIC_SUPABASE_URL=
NEXT_PUBLIC_SUPABASE_ANON_KEY=
SUPABASE_SERVICE_ROLE_KEY=
```

---

## Step 2: Database Migration

### 2.1 Export Data from Supabase
1. Go to Supabase Dashboard → Settings → Database
2. Download full database backup (SQL dump)
3. Or use `pg_dump`:
```bash
pg_dump postgresql://supabase_user:password@db.supabase.co:5432/postgres > supabase_dump.sql
```

### 2.2 Import to Neon Database
```bash
psql postgresql://neon_user:password@ep-example-123456.us-east-2.aws.neon.tech/neondb < supabase_dump.sql
```

### 2.3 Introspect Database with Prisma
```bash
npx prisma db pull
```

### 2.4 Generate Prisma Client
```bash
npx prisma generate
```

---

## Step 3: Code Migration Plan

| Component | Status | Notes |
|-----------|--------|-------|
| Prisma Schema | ✅ Created | Complete schema matching existing tables |
| Database Client | ✅ Created | Singleton Prisma client at `/src/lib/db.ts` |
| Menu API Routes | ⏳ Pending | Update `/api/admin/menu/*` |
| Content API Routes | ⏳ Pending | Update `/api/admin/content/*` |
| Booking API Routes | ⏳ Pending | Update `/api/booking/*` |
| Admin Actions | ⏳ Pending | Update server actions |
| Authentication | ⏳ Pending | Supabase Auth can remain |
| Frontend Queries | ⏳ Pending | Replace Supabase client usage |

---

## Step 4: Migration Checklist

- [x] Prisma ORM installed and configured
- [x] Database schema defined in `prisma/schema.prisma`
- [x] Prisma database client implemented
- [ ] Database migrated from Supabase to Neon
- [ ] Prisma client generated
- [ ] All API routes updated to use Prisma
- [ ] All server actions updated
- [ ] Authentication verified working
- [ ] Full end-to-end testing
- [ ] Supabase dependencies removed (if not using Auth)
- [ ] Application deployed and verified

---

## Step 5: Example Query Conversion

### Before (Supabase):
```typescript
const { data, error } = await supabase
  .from('menu_items')
  .select('*')
  .eq('is_active', true)
  .order('order_index')
```

### After (Prisma):
```typescript
const data = await db.menuItem.findMany({
  where: { isActive: true },
  orderBy: { orderIndex: 'asc' }
})
```

---

## Next Actions

1. Run `npm install prisma --save-dev && npm install @prisma/client`
2. Add Neon database credentials to `.env.local`
3. Run `npx prisma generate`
4. Begin migrating API routes one by one
5. Test each endpoint after migration

---

**Migration Guide Created: 2026-04-21**
