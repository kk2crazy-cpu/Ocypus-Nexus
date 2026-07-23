# Data Dictionary

**Project:** Ocypus Nexus

**Document Version:** 1.0

**Status:** Released

---

# 1. Purpose

This document defines the complete data dictionary for the Ocypus Nexus Product Information Management (PIM) platform.

It serves as the authoritative reference for:

- Database Design
- SQLAlchemy Models
- REST API DTOs
- SQLite Schema
- PostgreSQL Schema
- Excel Import / Export
- Validation Rules

---

# 2. Naming Standards

## Table Naming

All tables use:

snake_case

Example

```
product

attribute_group

product_attribute_value
```

---

## Column Naming

All columns use:

snake_case

Example

```
product_code

created_at

attribute_id
```

---

## Primary Keys

Every business table uses:

```
UUID
```

Example

```
id
```

---

## Foreign Keys

Naming rule:

```
<reference>_id
```

Examples

```
product_id

category_id

attribute_id

unit_id
```

---

# 3. Common Columns

Every business table contains the following fields.

| Column | Type | Null | Description |
|----------|------|------|-------------|
| id | UUID | No | Primary Key |
| created_at | DATETIME | No | Creation Time |
| updated_at | DATETIME | No | Last Update |
| created_by | UUID | Yes | Creator |
| updated_by | UUID | Yes | Last Modifier |
| version | INTEGER | No | Optimistic Lock |
| status | VARCHAR(20) | No | Record Status |
| is_deleted | BOOLEAN | No | Soft Delete |
| deleted_at | DATETIME | Yes | Delete Time |
| deleted_by | UUID | Yes | Delete User |

---

# 4. Table Summary

| Table | Purpose |
|--------|----------|
| category | Product Categories |
| product_type | Product Types |
| series | Product Series |
| product | Logical Products |
| product_revision | Engineering Revisions |
| sku | Commercial Products |
| attribute_group | Attribute Groups |
| attribute | Attribute Definitions |
| attribute_option | Enumeration Values |
| product_attribute_value | Specification Values |
| validation_rule | Validation Metadata |
| unit | Engineering Units |
| metadata_template | Metadata Templates |
| excel_template | Excel Templates |
| excel_sheet | Worksheet Definitions |
| excel_mapping | Cell Mapping |
| asset | File Metadata |
| user | Users |
| role | Roles |
| permission | Permissions |
| audit_log | Audit Records |

---

# 5. Category

Table

```
category
```

| Column | Type | Description |
|----------|------|-------------|
| id | UUID | Primary Key |
| code | VARCHAR(30) | Unique Category Code |
| name | VARCHAR(100) | Category Name |
| description | TEXT | Description |
| display_order | INTEGER | Display Order |
| icon | VARCHAR(255) | Icon |
| active | BOOLEAN | Enabled |

---

# 6. Product

Table

```
product
```

| Column | Type | Description |
|----------|------|-------------|
| id | UUID | Primary Key |
| series_id | UUID | FK → series |
| code | VARCHAR(100) | Product Code |
| name | VARCHAR(150) | Product Name |
| marketing_name | VARCHAR(150) | Marketing Name |
| lifecycle_status | VARCHAR(30) | Product Status |
| current_revision_id | UUID | Current Revision |

---

# 7. Product Revision

Table

```
product_revision
```

| Column | Type | Description |
|----------|------|-------------|
| id | UUID | Primary Key |
| product_id | UUID | FK → product |
| revision | VARCHAR(20) | Revision |
| released_at | DATETIME | Release Time |
| active | BOOLEAN | Current Revision |

---

# 8. SKU

Table

```
sku
```

| Column | Type | Description |
|----------|------|-------------|
| id | UUID | Primary Key |
| product_revision_id | UUID | FK |
| sku_code | VARCHAR(100) | SKU Code |
| part_number | VARCHAR(100) | Part Number |
| barcode | VARCHAR(50) | Barcode |
| color | VARCHAR(50) | Color |
| region | VARCHAR(50) | Region |

---

# 9. Attribute

Table

```
attribute
```

| Column | Type | Description |
|----------|------|-------------|
| id | UUID | Primary Key |
| group_id | UUID | FK |
| code | VARCHAR(100) | Attribute Code |
| name | VARCHAR(100) | Display Name |
| data_type | VARCHAR(30) | Data Type |
| unit_id | UUID | FK → unit |
| required | BOOLEAN | Required |
| searchable | BOOLEAN | Searchable |
| exportable | BOOLEAN | Excel Export |

---

# 10. Product Attribute Value

Table

```
product_attribute_value
```

| Column | Type | Description |
|----------|------|-------------|
| id | UUID | Primary Key |
| revision_id | UUID | FK |
| attribute_id | UUID | FK |
| value_text | TEXT | Text Value |
| value_number | DECIMAL | Numeric Value |
| value_boolean | BOOLEAN | Boolean Value |
| value_datetime | DATETIME | DateTime Value |
| value_json | JSON | Structured Value |
| display_value | TEXT | Cached Display Value |

Only one value field should be populated (except `display_value`).

---

# 11. Excel Mapping

Table

```
excel_mapping
```

| Column | Type | Description |
|----------|------|-------------|
| id | UUID | Primary Key |
| sheet_id | UUID | FK |
| attribute_id | UUID | FK |
| cell_address | VARCHAR(20) | Excel Cell |
| format_rule | TEXT | Formatting Rule |

Example

```
GPU_CLEARANCE

↓

Sheet1

↓

H16
```

---

# 12. Unit

Table

```
unit
```

| Column | Type | Description |
|----------|------|-------------|
| id | UUID | Primary Key |
| code | VARCHAR(30) | Unit Code |
| symbol | VARCHAR(20) | Unit Symbol |
| quantity_type | VARCHAR(30) | Quantity Category |

---

# 13. Validation Rule

Table

```
validation_rule
```

| Column | Type | Description |
|----------|------|-------------|
| id | UUID | Primary Key |
| attribute_id | UUID | FK |
| rule_type | VARCHAR(50) | Validation Type |
| rule_value | TEXT | Rule Content |

---

# 14. User

Table

```
user
```

| Column | Type | Description |
|----------|------|-------------|
| id | UUID | Primary Key |
| username | VARCHAR(50) | Login Name |
| email | VARCHAR(150) | Email |
| password_hash | TEXT | Password Hash |
| active | BOOLEAN | Enabled |

---

# 15. Role

Table

```
role
```

| Column | Type | Description |
|----------|------|-------------|
| id | UUID | Primary Key |
| code | VARCHAR(50) | Role Code |
| name | VARCHAR(100) | Role Name |

---

# 16. Permission

Table

```
permission
```

| Column | Type | Description |
|----------|------|-------------|
| id | UUID | Primary Key |
| code | VARCHAR(100) | Permission Code |
| module | VARCHAR(50) | Module |
| action | VARCHAR(50) | Action |

---

# 17. Audit Log

Table

```
audit_log
```

| Column | Type | Description |
|----------|------|-------------|
| id | UUID | Primary Key |
| table_name | VARCHAR(100) | Target Table |
| record_id | UUID | Target Record |
| operation | VARCHAR(20) | INSERT / UPDATE / DELETE |
| before_value | JSON | Before Change |
| after_value | JSON | After Change |
| operator_id | UUID | User |
| operated_at | DATETIME | Timestamp |

---

# 18. SQLAlchemy Mapping

| Database Type | SQLAlchemy |
|---------------|------------|
| UUID | UUID(as_uuid=True) |
| VARCHAR | String |
| TEXT | Text |
| INTEGER | Integer |
| BOOLEAN | Boolean |
| DECIMAL | Numeric |
| DATETIME | DateTime |
| JSON | JSON |

---

# 19. SQLite Compatibility

Supported:

- UUID (stored as TEXT)
- CHECK
- FOREIGN KEY
- UNIQUE
- INDEX
- TRIGGER
- VIEW

---

# 20. PostgreSQL Compatibility

Supported:

- Native UUID
- JSONB
- Partial Index
- Generated Column
- Materialized View
- Full Text Search (Future)

---

# 21. Definition of Done

The Data Dictionary is complete when:

- Every table is documented.
- Every column is defined.
- Naming conventions are standardized.
- SQLAlchemy mappings are documented.
- SQLite compatibility is verified.
- PostgreSQL compatibility is verified.
- The schema can be generated directly from this document.

---

# Document Information

| Item | Value |
|------|-------|
| Document | 05_Data_Dictionary.md |
| Version | 1.0 |
| Status | Released |
| Owner | Ocypus Engineering Team |
| Last Updated | 2026-07-23 |
