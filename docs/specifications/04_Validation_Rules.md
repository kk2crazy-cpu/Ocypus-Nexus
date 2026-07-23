# Validation Rules Specification

**Project:** Ocypus Nexus

**Document Version:** 1.0

**Status:** Released

---

# 1. Purpose

This document defines the unified validation framework used throughout the Ocypus Nexus platform.

Validation ensures that all product data remains complete, consistent, and reliable regardless of whether it originates from:

- Web UI
- REST API
- Excel Import
- Batch Import
- Future Integrations

Validation rules are defined by metadata rather than hardcoded business logic.

---

# 2. Validation Architecture

```
User Input
      │
      ▼
Field Validation
      │
      ▼
Type Validation
      │
      ▼
Business Validation
      │
      ▼
Cross Field Validation
      │
      ▼
Metadata Validation
      │
      ▼
Database Constraint
      │
      ▼
Save
```

Every validation layer must pass before data is persisted.

---

# 3. Validation Levels

| Level | Description |
|--------|-------------|
| L1 | Required Validation |
| L2 | Data Type Validation |
| L3 | Value Range Validation |
| L4 | Enumeration Validation |
| L5 | Format Validation |
| L6 | Cross Field Validation |
| L7 | Business Rule Validation |
| L8 | Database Constraint Validation |

---

# 4. Required Validation

Mandatory fields cannot be empty.

Example

```
Product Name

✔ Gamma C50

✘ Empty
```

Metadata Property

```
Required = true
```

---

# 5. Data Type Validation

Supported Types

| Type | Example |
|------|----------|
| Text | Gamma C50 |
| Integer | 360 |
| Decimal | 1.25 |
| Boolean | True |
| Date | 2026-01-01 |
| DateTime | 2026-01-01 09:00 |
| Enum | ATX |
| Multi Enum | ATX, Micro ATX |
| URL | https://example.com |
| JSON | {} |

Invalid types must be rejected.

---

# 6. Length Validation

Example

```
Minimum Length

2

Maximum Length

100
```

Applies to

- Product Name
- Marketing Name
- Description
- SKU

---

# 7. Numeric Validation

Metadata

```
Minimum

0

Maximum

9999

Precision

2
```

Example

GPU Clearance

```
Minimum

150

Maximum

600
```

---

# 8. Enumeration Validation

Allowed values originate from metadata.

Example

Motherboard Support

Allowed

- E-ATX
- ATX
- Micro ATX
- Mini ITX

Rejected

❌ Custom String

❌ Unknown Value

---

# 9. Regular Expression Validation

Example

Part Number

```
^[A-Z0-9-]+$
```

Barcode

```
^[0-9]{8,13}$
```

Version

```
^Rev [A-Z]$
```

---

# 10. Unit Validation

Units must reference the Unit Library.

Accepted

```
410 mm

1.5 kg

1800 RPM
```

Rejected

```
410 millimeter

1.5 kilogram

1800 rotations
```

---

# 11. File Validation

Supported Upload Types

Images

- png
- jpg
- webp

Documents

- pdf

Excel

- xlsx

Maximum File Size

Configurable

Metadata controls allowed file types.

---

# 12. Image Validation

Validate

- Extension
- MIME Type
- Maximum Size
- Resolution
- Aspect Ratio (optional)

---

# 13. Excel Validation

Before importing:

Validate

- Workbook
- Worksheet Names
- Template Version
- Required Columns
- Header Order
- Cell Type
- Empty Required Fields
- Duplicate Product Codes
- Invalid Enumerations

Import stops if validation fails.

---

# 14. API Validation

REST API validation includes:

- Authentication
- Authorization
- Request Body
- Path Parameters
- Query Parameters
- Pagination
- Sorting
- Filtering

Invalid requests return HTTP 400.

---

# 15. Cross Field Validation

Examples

GPU Clearance

Must be greater than

Installed GPU Length

CPU Cooler Height

Must fit

Supported Cooler Height

Package Volume

Length × Width × Height

---

# 16. Business Rules

Examples

Released products

Cannot have

Draft status

EOL products

Cannot be edited

SKU

Must belong to one Product

Series

Must belong to one Category

---

# 17. Database Validation

Database constraints include:

- Primary Key
- Foreign Key
- Unique Constraint
- Check Constraint
- Not Null

Application validation must execute before database validation.

---

# 18. Validation Error Format

Example

```json
{
  "code": "VALIDATION_ERROR",
  "field": "GPU_CLEARANCE",
  "message": "Value must be between 150 and 600 mm."
}
```

Every error contains:

- Error Code
- Field
- Message

---

# 19. Localization

Validation messages support:

- English
- Simplified Chinese
- Traditional Chinese
- Japanese

Messages are generated using localization resources.

---

# 20. Performance Requirements

Validation should:

- Minimize database queries
- Batch metadata lookups
- Cache enumeration values
- Reuse compiled regular expressions

---

# 21. Audit Requirements

Validation failures are logged when appropriate.

Recorded Information

- User
- Time
- Validation Type
- Input
- Error Code

---

# 22. Definition of Done

Validation is complete when:

- Required fields are enforced.
- Data types are validated.
- Units reference metadata.
- Enumerations are validated.
- Cross-field validation is supported.
- Business rules are enforced.
- Excel import uses the same validation engine.
- REST APIs use the same validation engine.
- Error messages support localization.

---

# Document Information

| Item | Value |
|------|-------|
| Document | 04_Validation_Rules.md |
| Version | 1.0 |
| Status | Released |
| Owner | Ocypus Engineering Team |
| Last Updated | 2026-07-22 |
