# Database Index Strategy

**Project:** Ocypus Nexus

**Document Version:** 1.0

**Status:** Released

---

# 1. Purpose

This document defines the indexing strategy for the Ocypus Nexus database.

Indexes are designed to:

- Optimize query performance
- Reduce full table scans
- Improve JOIN efficiency
- Support Excel export
- Support Product Search
- Support API filtering
- Support Audit queries

The strategy must remain compatible with both SQLite and PostgreSQL.

---

# 2. Design Principles

Indexes should be created only when they improve read performance.

The platform follows:

- Read-Optimized
- Write-Aware
- Metadata-Driven
- Predictable Query Plans
- Minimal Redundancy

---

# 3. Index Types

Supported index types:

| Type | SQLite | PostgreSQL |
|------|---------|------------|
| Primary Key | ✔ | ✔ |
| Unique Index | ✔ | ✔ |
| Composite Index | ✔ | ✔ |
| Partial Index | ✘ | ✔ |
| Covering Index | Limited | ✔ |
| Expression Index | Limited | ✔ |

---

# 4. Naming Convention

Index names follow:

```
IDX_<TABLE>_<COLUMN>

UK_<TABLE>_<COLUMN>

PK_<TABLE>

FK_<TABLE>_<REFERENCE>
```

Examples:

```
PK_PRODUCT

IDX_PRODUCT_CODE

IDX_PRODUCT_STATUS

UK_SKU_CODE

IDX_ATTRIBUTE_GROUP
```

---

# 5. Product Table

Frequently queried fields:

- code
- name
- lifecycle_status
- series_id
- current_revision_id

Indexes:

```
IDX_PRODUCT_CODE

IDX_PRODUCT_NAME

IDX_PRODUCT_SERIES

IDX_PRODUCT_STATUS

IDX_PRODUCT_REVISION
```

Unique

```
UK_PRODUCT_CODE
```

---

# 6. Product Revision

Indexes

```
IDX_REVISION_PRODUCT

IDX_REVISION_ACTIVE

IDX_REVISION_RELEASE_TIME
```

Composite

```
(product_id, revision)

(product_id, active)
```

---

# 7. SKU

Indexes

```
IDX_SKU_CODE

IDX_SKU_PART_NUMBER

IDX_SKU_BARCODE

IDX_SKU_REGION

IDX_SKU_COLOR
```

Composite

```
(region, color)

(product_revision_id, sku_code)
```

---

# 8. Attribute

Indexes

```
IDX_ATTRIBUTE_CODE

IDX_ATTRIBUTE_GROUP

IDX_ATTRIBUTE_UNIT
```

Unique

```
UK_ATTRIBUTE_CODE
```

---

# 9. Product Attribute Value

This table is expected to become the largest table in the system.

Indexes

```
IDX_VALUE_PRODUCT

IDX_VALUE_ATTRIBUTE

IDX_VALUE_TEXT

IDX_VALUE_NUMBER
```

Composite

```
(revision_id, attribute_id)

(attribute_id, value_number)

(attribute_id, value_text)
```

---

# 10. Metadata Template

Indexes

```
IDX_TEMPLATE_CATEGORY

IDX_TEMPLATE_VERSION

IDX_TEMPLATE_ACTIVE
```

Composite

```
(category_id, active)
```

---

# 11. Excel Template

Indexes

```
IDX_TEMPLATE_CODE

IDX_TEMPLATE_VERSION

IDX_TEMPLATE_ACTIVE
```

---

# 12. Excel Mapping

Indexes

```
IDX_MAPPING_ATTRIBUTE

IDX_MAPPING_SHEET

IDX_MAPPING_CELL
```

Composite

```
(sheet_id, cell_address)

(attribute_id, sheet_id)
```

---

# 13. Asset

Indexes

```
IDX_ASSET_FILENAME

IDX_ASSET_TYPE

IDX_ASSET_FOLDER
```

---

# 14. User

Indexes

```
IDX_USER_EMAIL

IDX_USER_USERNAME

IDX_USER_STATUS
```

Unique

```
UK_USER_EMAIL

UK_USER_USERNAME
```

---

# 15. Role

Indexes

```
IDX_ROLE_CODE

IDX_ROLE_NAME
```

---

# 16. Audit Log

Audit tables are append-only.

Indexes

```
IDX_AUDIT_TABLE

IDX_AUDIT_RECORD

IDX_AUDIT_OPERATOR

IDX_AUDIT_TIME
```

Composite

```
(table_name, record_id)

(operator_id, operated_at)
```

---

# 17. Composite Index Strategy

Composite indexes are created for the most common query patterns.

Examples

Product List

```
status

↓

series

↓

name
```

Composite Index

```
(status, series_id, name)
```

Product Search

```
category

↓

type

↓

series
```

Composite Index

```
(category_id, product_type_id, series_id)
```

---

# 18. Search Optimization

Common search fields:

- Product Code
- Product Name
- SKU
- Part Number
- Barcode

These fields must always have dedicated indexes.

---

# 19. Sorting Optimization

Frequently sorted fields:

- Product Name
- Release Date
- Updated Time
- Display Order
- Series

Indexes should match common ORDER BY clauses.

---

# 20. Excel Export Optimization

Excel export typically queries:

```
Revision

↓

Attributes

↓

Excel Mapping

↓

Template
```

Indexes required:

```
IDX_REVISION_PRODUCT

IDX_MAPPING_ATTRIBUTE

IDX_MAPPING_SHEET

IDX_ATTRIBUTE_GROUP
```

---

# 21. Maintenance Strategy

Indexes should be reviewed periodically.

Recommendations:

- Remove unused indexes
- Monitor slow queries
- Analyze execution plans
- Rebuild fragmented indexes (PostgreSQL)

---

# 22. SQLite Considerations

SQLite supports:

- B-Tree indexes
- Composite indexes
- Unique indexes

Avoid creating excessive indexes due to write overhead.

---

# 23. PostgreSQL Enhancements

Future enhancements:

- Partial indexes
- GIN indexes (JSONB)
- Trigram indexes (fuzzy search)
- BRIN indexes (large audit tables)

These enhancements are optional and do not affect SQLite compatibility.

---

# 24. Definition of Done

The indexing strategy is complete when:

- All primary tables have indexes.
- Frequently queried fields are indexed.
- Composite indexes support common business queries.
- Excel export performance is optimized.
- API filtering is optimized.
- Search performance is acceptable.
- SQLite and PostgreSQL compatibility is maintained.

---

# Document Information

| Item | Value |
|------|-------|
| Document | 03_Index_Strategy.md |
| Version | 1.0 |
| Status | Released |
| Owner | Ocypus Engineering Team |
| Last Updated | 2026-07-23 |
