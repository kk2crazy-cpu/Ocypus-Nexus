# Database Migration Strategy

**Project:** Ocypus Nexus

**Document Version:** 1.0

**Status:** Released

---

# 1. Purpose

This document defines the database migration strategy for Ocypus Nexus.

The migration system must guarantee:

- Repeatable deployments
- Zero manual SQL execution
- Safe rollback
- Data integrity
- Environment consistency

All schema changes must be managed through version-controlled migration scripts.

---

# 2. Supported Databases

Development

- SQLite

Production

- PostgreSQL

The migration process must support both databases using the same migration history.

---

# 3. Migration Tool

Official Tool

Alembic

Responsibilities

- Schema Migration
- Version Tracking
- Upgrade
- Downgrade
- Data Migration
- Seed Data

Direct SQL modifications are prohibited.

---

# 4. Migration Workflow

```
Developer

↓

Modify SQLAlchemy Models

↓

Generate Migration

↓

Review Migration

↓

Execute Local Tests

↓

Commit Migration

↓

CI Validation

↓

Deploy

↓

Production Upgrade
```

Every migration must pass automated testing before deployment.

---

# 5. Migration Version Naming

Version Format

```
YYYYMMDD_HHMM_description
```

Example

```
20260723_093000_create_product_tables

20260723_154500_add_excel_template
```

Every migration must contain:

- Revision ID
- Parent Revision
- Description
- Creation Time

---

# 6. Migration Rules

Allowed

- Create Table
- Drop Table (Development Only)
- Add Column
- Rename Column
- Add Index
- Remove Index
- Add Constraint
- Remove Constraint
- Data Migration

Forbidden

- Manual Production SQL
- Direct Database Editing
- Schema Drift

---

# 7. Rollback Strategy

Every migration must support downgrade.

Example

```
Upgrade

↓

Create Table

↓

Downgrade

↓

Drop Table
```

Rollback must restore the previous schema without data corruption.

---

# 8. Seed Data

Initial data is maintained separately from schema migrations.

Seed Categories

- Administrator Account
- Roles
- Permissions
- Languages
- Units
- Product Categories
- Default Attribute Groups

Seed scripts must be idempotent.

---

# 9. Metadata Upgrade

Metadata changes are version-controlled.

Supported operations

- Add Attribute
- Remove Attribute
- Rename Display Name
- Modify Validation Rule
- Add Enumeration
- Update Template

Historical metadata remains available.

---

# 10. Product Data Migration

Schema changes affecting product data require migration scripts.

Examples

```
Old Field

↓

New Field

↓

Transform

↓

Validate

↓

Save
```

Migration scripts must preserve all historical revisions.

---

# 11. Excel Template Migration

Excel templates are versioned independently.

Example

```
Template v1

↓

Template v2

↓

Template v3
```

Existing products continue using the template version assigned at release unless explicitly upgraded.

---

# 12. Data Validation

Before applying a migration:

- Validate Foreign Keys
- Validate Unique Constraints
- Validate Required Fields
- Validate Metadata Integrity
- Validate Template Mapping

Migration aborts if validation fails.

---

# 13. CI/CD Integration

Pipeline

```
Checkout

↓

Install Dependencies

↓

Run Unit Tests

↓

Run Migration

↓

Verify Schema

↓

Run Integration Tests

↓

Package

↓

Deploy
```

Deployment stops immediately on migration failure.

---

# 14. Environment Strategy

Supported environments:

- Local
- Development
- Testing
- Staging
- Production

Each environment maintains its own migration history.

---

# 15. Backup Strategy

Before every production migration:

- Full Database Backup
- Migration Snapshot
- Export Migration Log

Backups must be verified before execution.

---

# 16. Failure Recovery

If migration fails:

1. Stop deployment
2. Restore backup
3. Execute rollback
4. Notify administrator
5. Record failure in migration history

No partial migrations are allowed.

---

# 17. Compatibility Policy

Every migration must maintain compatibility with:

- Existing REST APIs (where applicable)
- Existing Excel Templates
- Existing Product Data
- Existing Metadata

Breaking changes require a major version upgrade.

---

# 18. Migration Log

Each migration execution records:

| Field | Description |
|-------|-------------|
| Migration ID | Revision Identifier |
| Version | Migration Version |
| Started At | Start Time |
| Finished At | Finish Time |
| Duration | Execution Time |
| Status | Success / Failed |
| Operator | User or CI Pipeline |
| Environment | Local / Dev / Test / Prod |

Migration logs are immutable.

---

# 19. Best Practices

- One logical change per migration
- Small, incremental migrations
- No mixed schema and business logic
- Test upgrade and downgrade
- Review generated SQL before commit
- Never edit applied migrations

---

# 20. Definition of Done

The migration strategy is complete when:

- Every schema change is version-controlled.
- Upgrade and downgrade are supported.
- CI validates every migration.
- Seed data is managed independently.
- Metadata upgrades are supported.
- Excel template versions are preserved.
- Production backups are mandatory.
- Rollback procedures are documented.

---

# Document Information

| Item | Value |
|------|-------|
| Document | 04_Migration_Strategy.md |
| Version | 1.0 |
| Status | Released |
| Owner | Ocypus Engineering Team |
| Last Updated | 2026-07-23 |
