# Metadata Model Specification

**Project:** Ocypus Nexus

**Document Version:** 1.0

**Status:** Released

---

# 1. Purpose

This document defines the metadata model used by Ocypus Nexus.

The metadata model is the foundation of the entire system.

All product specifications, forms, search conditions, Excel templates, APIs and UI pages must be generated from metadata whenever possible.

No product specification may be hardcoded.

---

# 2. Design Principles

The metadata model follows these principles:

- Metadata First
- Configuration over Code
- Single Source of Truth
- Reusable Components
- Extensible Architecture
- Version Controlled
- Audit Friendly

---

# 3. Architecture

```

Metadata

↓

Category

↓

Product Type

↓

Series

↓

Product

↓

Attribute Group

↓

Attribute

↓

Attribute Value

↓

Export / API / UI

```

Every layer depends on metadata.

Nothing bypasses metadata.

---

# 4. Metadata Hierarchy

## Level 1

Category

Example

- Case
- Power Supply
- Liquid Cooler
- Air Cooler
- Fan
- Accessory

---

## Level 2

Product Type

Example

Case

↓

ATX

Micro ATX

Mini ITX

Open Frame

---

## Level 3

Series

Example

Gamma

Delta

Sigma

Omega

Iota

---

## Level 4

Product

Example

Gamma C50

Gamma C70

Delta C40

Omega L36

---

## Level 5

Revision

Example

Rev A

Rev B

Rev C

---

# 5. Attribute Groups

Every product contains one or more Attribute Groups.

Example

General

Dimensions

Compatibility

Cooling

Storage

Expansion

Appearance

Package

Certification

Accessory

---

# 6. Attribute Definition

Each attribute is defined only once.

Example

GPU Clearance

The definition is shared by every product.

No duplicated definitions are allowed.

---

# 7. Attribute Properties

Each attribute contains:

| Property | Required |
|----------|----------|
| Code | Yes |
| Display Name | Yes |
| Description | Optional |
| Category | Optional |
| Group | Yes |
| Data Type | Yes |
| Unit | Optional |
| Default Value | Optional |
| Validation Rule | Optional |
| Searchable | Yes |
| Filterable | Yes |
| Sortable | Yes |
| Exportable | Yes |
| Importable | Yes |
| Visible | Yes |
| Editable | Yes |
| Required | Yes |
| Multilingual | Optional |
| Version | Yes |

---

# 8. Supported Data Types

Supported metadata types include:

- Text
- Long Text
- Integer
- Decimal
- Boolean
- Date
- DateTime
- Enumeration
- Multiple Enumeration
- Image
- File
- URL
- Color
- JSON
- Markdown

---

# 9. Unit System

Supported engineering units include:

Length

- mm
- cm
- inch

Weight

- g
- kg

Volume

- L

Speed

- RPM

Power

- W

Voltage

- V

Current

- A

Temperature

- °C

Noise

- dBA

---

# 10. Validation Rules

Metadata supports:

Required

Minimum Value

Maximum Value

Regular Expression

Unique

Reference Validation

Cross-field Validation

Formula Validation

Example

GPU Clearance

>=

Installed GPU Length

---

# 11. Formula Support

Attributes may be calculated.

Example

Package Volume

=

Length × Width × Height

Example

Radiator Count

=

Front

+

Top

+

Rear

Calculated fields are read-only.

---

# 12. Localization

Every metadata item supports localization.

Languages:

- English
- Simplified Chinese
- Traditional Chinese
- Japanese
- German
- French

Display names are translated through metadata.

Database field names remain unchanged.

---

# 13. Version Control

Every metadata record contains:

- Version
- Created Time
- Updated Time
- Created By
- Updated By
- Status

Historical versions must remain queryable.

---

# 14. Audit Requirements

Every metadata modification must generate an audit record.

The audit log records:

- User
- Time
- Action
- Before Value
- After Value

Audit records cannot be deleted.

---

# 15. Metadata Usage

Metadata is the source for:

- Product Forms
- Search Filters
- Product Tables
- Excel Import
- Excel Export
- REST API
- Validation
- Documentation
- Product Comparison
- Product Specification Pages

---

# 16. Forbidden Practices

The following are prohibited:

❌ Hardcoded specification fields

❌ Hardcoded units

❌ Hardcoded dropdown options

❌ UI-specific field definitions

❌ Duplicate attribute definitions

❌ Excel-only fields

❌ API-only fields

Every definition must originate from metadata.

---

# 17. Future Compatibility

The metadata model must support future product categories without requiring database schema changes.

Examples include:

- Monitor
- Keyboard
- Mouse
- Memory
- SSD
- Notebook Cooler
- Gaming Chair
- Gaming Desk

No redesign should be required.

---

# 18. Definition of Done

The metadata model is considered complete when:

- Every attribute is metadata-driven.
- No duplicated attribute definitions exist.
- UI can be generated from metadata.
- Excel templates can be generated from metadata.
- REST API uses metadata definitions.
- Validation rules originate from metadata.
- Localization is metadata-driven.
- Version history is maintained.
- Audit logs are generated automatically.

---

# Document Information

| Item | Value |
|------|-------|
| Document | 00_Metadata_Model.md |
| Version | 1.0 |
| Status | Released |
| Owner | Ocypus Engineering Team |
| Last Updated | 2026-07-22 |
