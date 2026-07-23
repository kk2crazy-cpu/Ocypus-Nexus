# Entity Relationship Diagram

**Project:** Ocypus Nexus

**Document Version:** 1.0

**Status:** Released

---

# 1. Purpose

This document defines the logical Entity Relationship (ER) model of Ocypus Nexus.

The ER model serves as the authoritative reference for:

- SQLite Schema
- PostgreSQL Schema
- SQLAlchemy Models
- Alembic Migrations
- REST API Design

All database implementations must conform to this model.

---

# 2. Design Philosophy

The database is divided into six logical domains:

```
System
│
├── Security
│
├── Metadata
│
├── Business
│
├── Excel
│
└── Audit
```

Business data and metadata are strictly separated.

---

# 3. Metadata Domain

```
Category
    │
    ├────────────┐
    ▼            ▼
ProductType   MetadataTemplate
    │               │
    ▼               ▼
Series      TemplateGroup
    │               │
    ▼               ▼
Product   TemplateAttribute
                    │
                    ▼
               AttributeGroup
                    │
                    ▼
                 Attribute
                    │
         ┌──────────┴─────────┐
         ▼                    ▼
 AttributeOption      ValidationRule
                    │
                    ▼
                   Unit
```

---

# 4. Business Domain

```
Product
    │
    ├────────────┐
    ▼            ▼
Revision       SKU
    │            │
    ▼            ▼
ProductAttributeValue
    │
    ├────────────┐
    ▼            ▼
ProductImage ProductAttachment
```

---

# 5. Security Domain

```
User
 │
 ├──────────┐
 ▼          ▼
UserRole   LoginLog
 │
 ▼
Role
 │
 ▼
RolePermission
 │
 ▼
Permission
```

---

# 6. Excel Domain

The Excel engine is independent of the business layer.

```
ExcelTemplate
      │
      ▼
ExcelSheet
      │
      ▼
ExcelCell
      │
      ▼
ExcelMapping
      │
      ▼
Attribute
```

This design allows Excel layouts to evolve without modifying product tables.

---

# 7. Asset Domain

```
AssetFolder
      │
      ▼
Asset
      │
      ▼
AssetRelation
```

Supported asset types:

- Images
- Manuals
- Datasheets
- Certificates
- Videos
- ZIP Packages

---

# 8. Audit Domain

```
AuditLog

ChangeHistory

ImportHistory

ExportHistory

OperationLog
```

Audit tables are append-only.

---

# 9. Core Relationships

## Category

```
1 Category

↓

N Product Types
```

---

## Product Type

```
1 Product Type

↓

N Series
```

---

## Series

```
1 Series

↓

N Products
```

---

## Product

```
1 Product

↓

N Revisions

↓

N SKUs

↓

N Attribute Values
```

---

## Attribute Group

```
1 Attribute Group

↓

N Attributes
```

---

## Attribute

```
1 Attribute

↓

N Attribute Options

↓

N Product Values
```

---

## Unit

```
1 Unit

↓

N Attributes
```

---

## Metadata Template

```
1 Template

↓

N Template Groups

↓

N Template Attributes
```

---

## Excel Template

```
1 Template

↓

N Sheets

↓

N Cells

↓

N Attribute Mappings
```

---

# 10. Cardinality Summary

| Parent | Child | Relationship |
|----------|---------|-------------|
| Category | ProductType | 1:N |
| ProductType | Series | 1:N |
| Series | Product | 1:N |
| Product | SKU | 1:N |
| Product | ProductRevision | 1:N |
| Product | ProductAttributeValue | 1:N |
| AttributeGroup | Attribute | 1:N |
| Attribute | AttributeOption | 1:N |
| Unit | Attribute | 1:N |
| MetadataTemplate | TemplateGroup | 1:N |
| TemplateGroup | TemplateAttribute | 1:N |
| ExcelTemplate | ExcelSheet | 1:N |
| ExcelSheet | ExcelCell | 1:N |
| ExcelCell | ExcelMapping | 1:N |
| Role | Permission | M:N |
| User | Role | M:N |

---

# 11. UUID Strategy

Every business entity uses UUID as the primary key.

Example:

```
2f8d2cb4-5c34-40cb-a58f-3c4b41c63d31
```

Auto-increment IDs are reserved only for internal lookup tables where appropriate.

---

# 12. Soft Delete Strategy

Business entities include:

```
is_deleted

deleted_at

deleted_by
```

Deleted records remain queryable by administrators.

---

# 13. Version Strategy

Version-controlled entities:

- Product
- Product Revision
- Metadata Template
- Attribute
- Excel Template

Only one version may be marked as Active.

---

# 14. Future Expansion

The ER model is designed to support additional modules without restructuring existing tables.

Planned modules include:

- Supplier Management
- BOM Management
- Certification Management
- Packaging Management
- Pricing Management
- ERP Integration
- Official Website Integration

---

# 15. Definition of Done

The ER model is complete when:

- All core entities are defined.
- Relationships are documented.
- Cardinalities are verified.
- UUID strategy is standardized.
- Soft delete strategy is documented.
- Version control is supported.
- Excel mapping is separated from business data.
- The model can be implemented directly in SQLite and PostgreSQL.

---

# Document Information

| Item | Value |
|------|-------|
| Document | 01_ER_Diagram.md |
| Version | 1.0 |
| Status | Released |
| Owner | Ocypus Engineering Team |
| Last Updated | 2026-07-23 |
