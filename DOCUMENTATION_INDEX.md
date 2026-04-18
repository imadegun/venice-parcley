# Documentation Index – Venice Parcley

This index provides a complete guide to all project documentation, both in the main project directory and in `_bmad-output/planning-artifacts/`.

---

## Quick Start

**New to the project?** Start here:
1. [`README.md`](README.md) – Project overview, features, getting started
2. [`IMPLEMENTATION_SUMMARY.md`](IMPLEMENTATION_SUMMARY.md) – What's been built, current status, next steps
3. [`MIGRATION_GUIDE.md`](MIGRATION_GUIDE.md) – **Critical:** Database migrations required

---

## Project Documentation (Root Level)

| Document | Purpose | Audience |
|----------|---------|----------|
| [README.md](README.md) | Main project README with features, setup, structure | Everyone |
| [IMPLEMENTATION_SUMMARY.md](IMPLEMENTATION_SUMMARY.md) | Comprehensive implementation summary, file inventory, testing checklist | Developers, reviewers |
| [MIGRATION_GUIDE.md](MIGRATION_GUIDE.md) | Step-by-step database migration instructions | Developers, DevOps |
| [UI_IMPROVEMENTS.md](UI_IMPROVEMENTS.md) | Detailed UI/UX enhancement specifications | Developers, designers |
| [note_marcello.txt](note_marcello.txt) | Project notes, todo list, questions for stakeholder | Project manager, stakeholders |
| [DATABASE_SCHEMA.md](database-schema.sql) | Full database schema (generate from SQL) | Developers, DBAs |
| [DOCUMENTATION_INDEX.md](DOCUMENTATION_INDEX.md) | This file – navigation guide | Everyone |

---

## Planning Artifacts (`_bmad-output/planning-artifacts/`)

### Strategic Documents

| File | Description | Status |
|------|-------------|--------|
| [prd.md](_bmad-output/planning-artifacts/prd.md) | Product Requirements Document – user journeys, functional & non-functional requirements | ✅ Complete |
| [architecture.md](_bmad-output/planning-artifacts/architecture.md) | Technical architecture – stack, DB schema, API design, patterns | ✅ Complete |
| [epics-and-stories.md](_bmad-output/planning-artifacts/epics-and-stories.md) | Epics and user stories with acceptance criteria, sprint planning | ✅ Complete |
| [implementation-readiness-report-2026-04-08.md](_bmad-output/planning-artifacts/implementation-readiness-report-2026-04-08.md) | Progress report, completed features, next steps | 🟡 In Progress |

### How to Use These Documents

**For Product Managers:**
- Start with `prd.md` to understand requirements
- Check `implementation-readiness-report*.md` for current status
- Review `epics-and-stories.md` for backlog and priorities

**For Architects/Developers:**
- Read `architecture.md` for technical decisions
- Reference `prd.md` for functional requirements mapping
- Use `implementation-readiness-report*.md` to see what's done and what's next

**For New Team Members:**
- Read `README.md` (root) for quick start
- Then `IMPLEMENTATION_SUMMARY.md` for what's built
- Then `architecture.md` for system design
- Then `epics-and-stories.md` for feature details

---

## Code Documentation

### API Documentation
- **Admin Menu API:** See `src/app/api/admin/menu/route.ts` and `[id]/route.ts` for endpoint details
- **Content Service:** See `src/lib/content-service.ts` for content fetching logic
- **Auth:** See `src/lib/auth.ts` for Supabase auth helpers

### Component Documentation
- **Container:** `src/components/layout/container.tsx` – spacing prop documentation
- **Header:** `src/components/layout/header.tsx` – animation classes
- **Button:** `src/components/ui/button.tsx` – custom button variant

### Database Migrations
- `migrations/001_add_content_to_menu_items.sql` – Adds `content` column
- `migrations/002_add_map_embed_to_menu_items.sql` – Adds `map_embed` column
- `database-schema.sql` – Full schema reference (includes all tables)

---

## Feature Mapping

### Content Management (EPIC-5)
| Feature | User Stories | Admin UI | API | Frontend |
|---------|--------------|----------|-----|----------|
| Menu CRUD | STORY-5.1 | `/admin/content/menu` | `/api/admin/menu/*` | N/A |
| Page Content | STORY-5.2, 5.3 | `/admin/content/pages` | Reuses menu API | `/about`, `/contact`, etc. |
| Map Embed | STORY-5.4 | Same as Page Content | Same as Page Content | `/contact` (conditional) |

### UI/UX Enhancements (EPIC-6)
| Feature | Story | Components | Pages Affected |
|---------|-------|------------|----------------|
| Container Spacing | STORY-6.1 | `Container` | All pages |
| Header Animation | STORY-6.2 | `Header` | All pages |
| Title Animations | STORY-6.3 | CSS classes | All page titles |

---

## Status Legend

- ✅ Complete – Implemented, tested, documented
- 🟡 In Progress – Partially done, some tasks remaining
- ⏳ Pending – Not started, ready to begin
- ❌ Blocked – Waiting on external dependency or decision

---

## Quick Links by Role

### Developer
- [IMPLEMENTATION_SUMMARY.md](IMPLEMENTATION_SUMMARY.md) – What's built
- [architecture.md](_bmad-output/planning-artifacts/architecture.md) – How it's built
- [MIGRATION_GUIDE.md](MIGRATION_GUIDE.md) – Setup steps
- [UI_IMPROVEMENTS.md](UI_IMPROVEMENTS.md) – Animation details

### Product Manager
- [prd.md](_bmad-output/planning-artifacts/prd.md) – Requirements
- [epics-and-stories.md](_bmad-output/planning-artifacts/epics-and-stories.md) – Backlog
- [implementation-readiness-report-2026-04-08.md](_bmad-output/planning-artifacts/implementation-readiness-report-2026-04-08.md) – Progress

### Designer/UX
- [UI_IMPROVEMENTS.md](UI_IMPROVEMENTS.md) – Animation specs
- [architecture.md](_bmad-output/planning-artifacts/architecture.md) – Component architecture

### Stakeholder
- [README.md](README.md) – High-level overview
- [IMPLEMENTATION_SUMMARY.md](IMPLEMENTATION_SUMMARY.md) – Progress snapshot
- [note_marcello.txt](note_marcello.txt) – Questions and decisions

---

## Document Maintenance

**When to update:**
- `README.md` – When adding major features or changing setup
- `IMPLEMENTATION_SUMMARY.md` – After each sprint or major milestone
- `note_marcello.txt` – As questions arise or decisions are made
- Planning artifacts – During sprint planning or requirement changes

**Versioning:**
- Planning documents use semantic versioning (currently 1.0)
- Implementation reports are dated (YYYY-MM-DD)
- Keep old versions in `_bmad-output/planning-artifacts/` if needed

---

## Support

For questions about documentation:
1. Check this index first
2. Review the relevant document's table of contents
3. Search for keywords across all docs in `_bmad-output/planning-artifacts/`
4. Ask in project chat or create an issue

---

**Last Updated:** 2026-04-18  
**Maintained By:** Development Team  
**Next Review:** After Sprint 2 completion
