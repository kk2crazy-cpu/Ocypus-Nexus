# Database Table Definitions

**Project:** Ocypus Nexus

**Document Version:** 1.0

**Status:** Released

---

# 1. Purpose

This document defines the database tables used by Ocypus Nexus.

Every table definition is implementation-ready and serves as the source for:

- SQLite Schema
- PostgreSQL Schema
- SQLAlchemy Models
- Alembic Migration
- REST API DTO

---

# 2. Global Standards

All business tables inherit the following fields.

| Column | Type | Nullable | Description |
|---------|------|----------|-------------|
| id | UUID | No | Primary Key |
| created_at | DATETIME | No | Creation Time |
| updated_at | DATETIME | No | Last Update |
| created_by | UUID | Yes | User ID |
| updated_by | UUID | Yes | User ID |
| version | INTEGER | No | Optimistic Lock |
| status | VARCHAR(20) | No | Record Status |
| is_deleted | BOOLEAN | No | Soft Delete |
| deleted_at | DATETIME | Yes | Delete Time |
| deleted_by | UUID | Yes | Delete User |

---

# 3. Table: category

## Purpose

Defines top-level product categories.

Examples:

- Case
- PSU
- Liquid Cooler
- Air Cooler
- Fan

### Columns

| Name | Type | Null | Default |
|------|------|------|---------|
| id | UUID | No | |
| code | VARCHAR(30) | No | |
| name | VARCHAR(100) | No | |
| description | TEXT | Yes | |
| display_order | INTEGER | No | 0 |
| icon | VARCHAR(255) | Yes | |
| active | BOOLEAN | No | TRUE |

### Constraints

Primary Key

```
PK_CATEGORY
```

Unique

```
UK_CATEGORY_CODE
```

Indexes

```
IDX_CATEGORY_CODE

IDX_CATEGORY_ACTIVE
```

---

# 4. Table: product_type

## Purpose

Defines structural product types.

### Foreign Keys

```
category_id

↓

category.id
```

### Columns

| Name | Type |
|------|------|
| id | UUID |
| category_id | UUID |
| code | VARCHAR(50) |
| name | VARCHAR(100) |
| display_order | INTEGER |
| active | BOOLEAN |

Indexes

```
IDX_PRODUCT_TYPE_CATEGORY

IDX_PRODUCT_TYPE_CODE
```

---

# 5. Table: series

## Purpose

Defines product series.

Examples

Gamma

Delta

Omega

### Foreign Keys

```
product_type_id

↓

product_type.id
```

### Columns

| Name | Type |
|------|------|
| id | UUID |
| product_type_id | UUID |
| code | VARCHAR(50) |
| name | VARCHAR(100) |
| description | TEXT |
| release_year | INTEGER |

Unique

```
UK_SERIES_CODE
```

---

# 6. Table: product

## Purpose

Stores logical products.

One product contains multiple revisions.

### Columns

| Name | Type |
|------|------|
| id | UUID |
| series_id | UUID |
| code | VARCHAR(100) |
| name | VARCHAR(150) |
| marketing_name | VARCHAR(150) |
| current_revision_id | UUID |
| lifecycle_status | VARCHAR(30) |

Indexes

```
IDX_PRODUCT_CODE

IDX_PRODUCT_SERIES

IDX_PRODUCT_STATUS
```

Unique

```
UK_PRODUCT_CODE
```

---

# 7. Table: product_revision

## Purpose

Engineering revisions.

### Columns

| Name | Type |
|------|------|
| id | UUID |
| product_id | UUID |
| revision | VARCHAR(20) |
| released_at | DATETIME |
| release_note | TEXT |
| active | BOOLEAN |

Unique

```
UK_PRODUCT_REVISION
```

Business Rule

Only one Active revision.

---

# 8. Table: sku

## Purpose

Commercial SKU variants.

### Columns

| Name | Type |
|------|------|
| id | UUID |
| product_revision_id | UUID |
| sku_code | VARCHAR(100) |
| part_number | VARCHAR(100) |
| barcode | VARCHAR(50) |
| color | VARCHAR(50) |
| region | VARCHAR(50) |

Unique

```
UK_SKU_CODE

UK_PART_NUMBER
```

Indexes

```
IDX_SKU_REGION

IDX_SKU_COLOR
```

---

# 9. Table: attribute_group

Purpose

Defines specification groups.

Examples

General

Cooling

Storage

Package

Columns

| Name | Type |
|------|------|
| id | UUID |
| code | VARCHAR(50) |
| name | VARCHAR(100) |
| display_order | INTEGER |

---

# 10. Table: attribute

Purpose

Defines reusable specification fields.

Columns

| Name | Type |
|------|------|
| id | UUID |
| group_id | UUID |
| code | VARCHAR(100) |
| name | VARCHAR(100) |
| data_type | VARCHAR(30) |
| unit_id | UUID |
| required | BOOLEAN |
| searchable | BOOLEAN |
| exportable | BOOLEAN |

Indexes

```
IDX_ATTRIBUTE_GROUP

IDX_ATTRIBUTE_CODE
```

---

# 11. Table: attribute_option

Purpose

Stores Enum options.

Columns

| Name | Type |
|------|------|
| id | UUID |
| attribute_id | UUID |
| option_value | VARCHAR(100) |
| display_order | INTEGER |

---

# 12. Table: product_attribute_value

Purpose

Stores actual specification values.

Columns

| Name | Type |
|------|------|
| id | UUID |
| revision_id | UUID |
| attribute_id | UUID |
| value_text | TEXT |
| value_number | DECIMAL(18,4) |
| value_boolean | BOOLEAN |
| value_datetime | DATETIME |

Business Rule

Only one value column may contain data.

Indexes

```
IDX_VALUE_PRODUCT

IDX_VALUE_ATTRIBUTE

IDX_PRODUCT_ATTRIBUTE
```

Unique

```
UK_PRODUCT_ATTRIBUTE
```

---

# 13. Table: unit

Purpose

Engineering unit library.

Columns

| Name | Type |
|------|------|
| id | UUID |
| code | VARCHAR(30) |
| symbol | VARCHAR(20) |
| quantity_type | VARCHAR(30) |

Unique

```
UK_UNIT_CODE

UK_UNIT_SYMBOL
```

---

# 14. Table: excel_template

Purpose

Defines Excel templates.

Columns

| Name | Type |
|------|------|
| id | UUID |
| code | VARCHAR(50) |
| name | VARCHAR(100) |
| version | VARCHAR(20) |
| active | BOOLEAN |

---

# 15. Table: excel_sheet

Purpose

Worksheet definitions.

Columns

| Name | Type |
|------|------|
| id | UUID |
| template_id | UUID |
| sheet_name | VARCHAR(100) |
| sheet_order | INTEGER |

---

# 16. Table: excel_mapping

Purpose

Maps Attributes to Excel cells.

Columns

| Name | Type |
|------|------|
| id | UUID |
| sheet_id | UUID |
| attribute_id | UUID |
| cell_address | VARCHAR(20) |
| format_rule | TEXT |

Example

```
GPU_CLEARANCE

↓

Sheet1

↓

H16
```

---

# 17. Table: asset

Purpose

Stores file metadata.

Columns

| Name | Type |
|------|------|
| id | UUID |
| filename | VARCHAR(255) |
| storage_path | TEXT |
| mime_type | VARCHAR(100) |
| file_size | BIGINT |

---

# 18. Table: audit_log

Purpose

System audit.

Columns

| Name | Type |
|------|------|
| id | UUID |
| table_name | VARCHAR(100) |
| record_id | UUID |
| operation | VARCHAR(20) |
| before_value | JSON |
| after_value | JSON |
| operator_id | UUID |
| operated_at | DATETIME |

Indexes

```
IDX_AUDIT_TABLE

IDX_AUDIT_RECORD

IDX_AUDIT_TIME
```

---

# 19. SQLAlchemy Mapping

Every table corresponds to one SQLAlchemy Model.

Naming Convention

```
Category

↓

CategoryModel

↓

category.py
```

---

# 20. Alembic Migration Rules

Each table must have:

- Primary Key
- Foreign Keys
- Unique Constraints
- Indexes
- Check Constraints
- Comments

Migration files must be reversible.

---

# 21. SQLite Compatibility

Supported:

- CHECK
- FOREIGN KEY
- UNIQUE
- VIEW
- TRIGGER

Not Used:

- Stored Procedures
- Sequences

---

# 22. PostgreSQL Compatibility

Compatible Features

- UUID
- JSONB
- Partial Index
- Generated Column
- Materialized View (Future)

---

# 23. Definition of Done

The table definitions are complete when:

- Every business entity has a table.
- Relationships are defined.
- Constraints are documented.
- Indexes are defined.
- SQLAlchemy Models can be generated automatically.
- SQLite schema can be generated directly.
- PostgreSQL schema remains compatible.

---

# Document Information

| Item | Value |
|------|-------|
| Document | 02_Table_Definitions.md |
| Version | 1.0 |
| Status | Released |
| Owner | Ocypus Engineering Team |
| Last Updated | 2026-07-23 |
