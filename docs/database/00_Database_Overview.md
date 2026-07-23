# Database Architecture Overview

**Project:** Ocypus Nexus

**Document Version:** 1.0

**Status:** Released

---

# 1. Purpose

This document defines the overall database architecture of the Ocypus Nexus Product Information Management (PIM) platform.

The database is designed around a metadata-driven architecture, enabling new product categories and attributes to be added without modifying the database schema.

The database serves as the single source of truth for all product information.

---

# 2. Design Goals

The database must satisfy the following goals:

- Metadata Driven
- Highly Normalized
- Extensible
- Auditable
- Version Controlled
- Multi-language Ready
- RBAC Compatible
- Excel Compatible
- API Friendly
- PostgreSQL Compatible

---

# 3. Design Principles

## Principle 1

Database is the Source of Truth.

Excel is only an import/export format.

---

## Principle 2

Every specification field comes from metadata.

No product-specific columns may be added to the product table.

---

## Principle 3

Every business object has:

- UUID
- Create Time
- Update Time
- Create User
- Update User
- Version
- Status

---

## Principle 4

Soft Delete Only

Business data must never be physically deleted.

Every table contains:

```
is_deleted
deleted_at
deleted_by
```

---

## Principle 5

Every modification must be traceable.

Audit Log is mandatory.

---

# 4. Database Layers

The database consists of six logical layers.

```
System Layer

↓

Security Layer

↓

Metadata Layer

↓

Business Layer

↓

Asset Layer

↓

Audit Layer
```

---

# 5. System Layer

Stores system-wide configuration.

Tables

```
system_config

system_dictionary

system_language

system_unit

system_setting

system_sequence
```

---

# 6. Security Layer

Stores authentication and authorization.

Tables

```
user

role

permission

role_permission

user_role

login_log

session
```

---

# 7. Metadata Layer

Defines every product specification.

Tables

```
category

product_type

series

attribute_group

attribute

attribute_option

validation_rule

unit

metadata_template

template_group

template_attribute
```

No product data is stored here.

---

# 8. Business Layer

Stores actual products.

Tables

```
product

product_revision

sku

product_attribute_value

product_image

product_attachment

product_tag
```

---

# 9. Asset Layer

Stores reusable files.

Tables

```
asset

asset_folder

asset_relation
```

Supports

- Images
- PDF
- Manuals
- Datasheets
- Certificates

---

# 10. Audit Layer

Stores system history.

Tables

```
audit_log

change_history

import_history

export_history

operation_log
```

Audit records are immutable.

---

# 11. Database Standards

Every table must contain:

| Column | Required |
|----------|----------|
| id | Yes |
| created_at | Yes |
| updated_at | Yes |
| created_by | Yes |
| updated_by | Yes |
| version | Yes |
| status | Yes |
| is_deleted | Yes |

---

# 12. Primary Keys

All tables use UUID.

Example

```
5c2b0a74-d12f-44fd-a2aa-9e7710b6f541
```

Integer auto-increment keys are prohibited for business entities.

---

# 13. Foreign Keys

All relationships use UUID references.

Foreign keys are required unless technically impossible.

---

# 14. Naming Convention

Tables

snake_case

Examples

```
product

attribute_group

product_attribute_value

audit_log
```

Columns

snake_case

Examples

```
product_code

created_at

attribute_id

display_order
```

---

# 15. Versioning

Business tables include:

```
version

revision

status
```

Metadata also supports version history.

Historical records remain queryable.

---

# 16. Localization

Display names are stored separately.

Examples

```
attribute_translation

group_translation

category_translation
```

Database identifiers remain language independent.

---

# 17. Performance Strategy

Performance targets

- Indexed foreign keys
- Indexed search fields
- Optimized joins
- Metadata cache
- Read-optimized queries

Large binary files are never stored in the database.

---

# 18. Storage Strategy

Database stores:

- Metadata
- Product Data
- Relationships

File system stores:

- Images
- Manuals
- Videos
- ZIP Packages

Database stores only file metadata.

---

# 19. Backup Strategy

Development

SQLite file backup

Production

- PostgreSQL backup
- Daily full backup
- Hourly incremental backup
- WAL archiving

---

# 20. Migration Strategy

All schema changes use Alembic.

Manual SQL changes are prohibited.

Every migration must:

- be reversible
- include version number
- include description
- pass automated tests

---

# 21. Estimated Tables

| Layer | Tables |
|---------|--------|
| System | 8 |
| Security | 10 |
| Metadata | 18 |
| Business | 20 |
| Asset | 8 |
| Audit | 10 |

Estimated total

Approximately **74 tables**.

---

# 22. Definition of Done

The database architecture is complete when:

- All entities are defined.
- ER diagrams are completed.
- Foreign keys are defined.
- Index strategy is documented.
- Migration strategy is documented.
- SQLite schema is generated.
- PostgreSQL compatibility is verified.
- Data dictionary is completed.

---

# Document Information

| Item | Value |
|------|-------|
| Document | 00_Database_Overview.md |
| Version | 1.0 |
| Status | Released |
| Owner | Ocypus Engineering Team |
| Last Updated | 2026-07-23 |
