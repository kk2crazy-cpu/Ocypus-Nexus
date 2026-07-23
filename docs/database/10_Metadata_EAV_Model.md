# Metadata EAV Model

**Project:** Ocypus Nexus

**Document Version:** 1.0

**Status:** Released

---

# 1. Purpose

This document defines the Metadata-Driven Entity-Attribute-Value (EAV) architecture of Ocypus Nexus.

The EAV model enables the platform to support unlimited product categories and specification fields without changing the database schema.

This architecture is the foundation of:

- Product Specifications
- Excel Import / Export
- REST API
- Search
- Validation
- Comparison
- Website Data
- Future ERP Integration

---

# 2. Design Goals

The Metadata system must be:

- Metadata Driven
- Schema Independent
- Category Aware
- High Performance
- Version Controlled
- Excel Compatible
- API Friendly

---

# 3. Architecture

```
Category

↓

Metadata Template

↓

Attribute Group

↓

Attribute

↓

Validation Rule

↓

Product Value
```

Business data never defines its own fields.

Everything comes from Metadata.

---

# 4. Metadata Layers

```
Category

↓

Template

↓

Group

↓

Attribute

↓

Option

↓

Validation

↓

Unit
```

---

# 5. Core Tables

```
metadata_template

template_group

template_attribute

attribute_group

attribute

attribute_option

validation_rule

unit

product_attribute_value
```

---

# 6. Metadata Template

Represents a complete specification definition.

Examples

```
CASE_STANDARD

PSU_STANDARD

AIO_STANDARD
```

One category may contain multiple template versions.

---

# 7. Attribute Group

Purpose

Organizes specifications.

Examples

```
General

Dimensions

Cooling

Storage

Compatibility

Package

Accessories
```

Display order is configurable.

---

# 8. Attribute

Purpose

Defines one specification field.

Example

```
GPU Clearance

CPU Cooler Height

Radiator Support

Front I/O

Weight
```

Columns

| Field | Description |
|--------|-------------|
| Code | Immutable |
| Name | Display Name |
| Data Type | Value Type |
| Unit | Engineering Unit |
| Required | Validation |
| Searchable | Search |
| Exportable | Excel |
| Sort Order | UI |

---

# 9. Data Types

Supported types

```
TEXT

INTEGER

DECIMAL

BOOLEAN

DATE

DATETIME

ENUM

MULTI_ENUM

JSON

IMAGE

FILE

URL
```

Future types may be added without changing the schema.

---

# 10. Attribute Option

Enum values.

Example

```
ATX

Micro-ATX

Mini-ITX

E-ATX
```

Example

```
Black

White

Pink
```

Display order is configurable.

---

# 11. Validation Rules

Supported rules

```
Required

Minimum

Maximum

Regex

Length

Enum

Unique

File Type

File Size
```

Validation occurs during:

- UI Editing
- Excel Import
- REST API
- Batch Import

---

# 12. Unit Binding

Example

```
GPU Clearance

↓

Length

↓

mm
```

Example

```
Weight

↓

kg
```

Units are managed centrally.

---

# 13. Product Value Model

```
Product Revision

↓

Attribute

↓

Value
```

Each product revision stores one value for each attribute.

---

# 14. Typed Value Storage

```
value_text

value_number

value_boolean

value_datetime

value_json

display_value
```

Business Rules

- Only one typed value field may contain data.
- display_value is generated automatically.
- value_json stores complex structures.

---

# 15. JSON Value Examples

Fan Support

```json
[
  {
    "position":"Top",
    "size":120,
    "count":3
  },
  {
    "position":"Front",
    "size":140,
    "count":2
  }
]
```

Radiator Support

```json
[
  {
    "position":"Top",
    "length":360
  },
  {
    "position":"Front",
    "length":280
  }
]
```

---

# 16. Search Strategy

Searchable attributes are indexed.

Examples

```
GPU Clearance >= 410

AND

Motherboard Support = ATX
```

Metadata controls search behavior.

---

# 17. Excel Integration

```
Attribute

↓

Excel Mapping

↓

Cell

↓

Workbook
```

The Excel engine never references database columns directly.

---

# 18. API Integration

Example

```json
{
  "code":"GPU_CLEARANCE",
  "name":"GPU Clearance",
  "value":410,
  "unit":"mm"
}
```

The frontend renders attributes dynamically.

---

# 19. Version Control

Metadata supports revisions.

```
Template V1

↓

Template V2

↓

Template V3
```

Historical products continue referencing the template version under which they were created.

---

# 20. Future Expansion

The EAV architecture supports:

- Website CMS
- ERP
- PLM
- PDM
- Dealer Portal
- Product Comparison
- AI Specification Generator

No schema changes are required.

---

# 21. Definition of Done

The Metadata EAV model is complete when:

- All specification fields are metadata-driven.
- Templates are versioned.
- Attribute groups are configurable.
- Validation rules are centralized.
- Units are centralized.
- Typed values are supported.
- Complex JSON values are supported.
- Excel mappings are metadata-driven.
- APIs are generated from metadata.

---

# Document Information

| Item | Value |
|------|-------|
| Document | 10_Metadata_EAV_Model.md |
| Version | 1.0 |
| Status | Released |
| Owner | Ocypus Engineering Team |
| Last Updated | 2026-07-23 |
