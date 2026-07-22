# Product Attribute Model

**Project:** Ocypus Nexus

**Document Version:** 1.0

**Status:** Released

---

# 1. Purpose

This document defines the universal attribute model used throughout the Ocypus Nexus Product Information Management (PIM) platform.

An Attribute is the smallest reusable data definition in the system.

All product specifications are composed of Attributes.

No product-specific database columns shall be created unless they belong to the system itself.

---

# 2. Design Objectives

The attribute model must satisfy the following goals:

- Metadata Driven
- Category Independent
- Reusable
- Version Controlled
- Multilingual
- Extensible
- Searchable
- API Friendly
- Excel Compatible

---

# 3. Attribute Hierarchy

```

Category

↓

Attribute Group

↓

Attribute

↓

Attribute Option

↓

Attribute Value

```

Only **Attribute Value** stores product-specific data.

Everything else is metadata.

---

# 4. Attribute Definition

An Attribute defines **what data should exist**, not the actual value.

Example:

| Attribute | Value |
|------------|-------|
| GPU Clearance | 410 mm |
| CPU Cooler Height | 185 mm |
| Front Radiator | 360 mm |
| Motherboard Support | ATX |

The definition is shared by every applicable product.

---

# 5. Attribute Properties

| Property | Type | Required |
|----------|------|----------|
| ID | UUID | Yes |
| Code | String | Yes |
| Name | String | Yes |
| Display Name | String | Yes |
| Description | Text | No |
| Attribute Group | Reference | Yes |
| Data Type | Enum | Yes |
| Unit | Reference | No |
| Default Value | Dynamic | No |
| Placeholder | String | No |
| Sort Order | Integer | Yes |
| Required | Boolean | Yes |
| Searchable | Boolean | Yes |
| Filterable | Boolean | Yes |
| Sortable | Boolean | Yes |
| Importable | Boolean | Yes |
| Exportable | Boolean | Yes |
| Visible | Boolean | Yes |
| Editable | Boolean | Yes |
| Active | Boolean | Yes |

---

# 6. Attribute Code Rules

Attribute Codes use **UPPER_SNAKE_CASE**.

Examples:

```
GPU_CLEARANCE

CPU_COOLER_HEIGHT

TOP_RADIATOR

USB_TYPE_C

PCIE_SLOT
```

Rules:

- English only
- Uppercase
- Underscore separator
- Immutable after release

---

# 7. Display Names

Display names support localization.

Example:

| Language | Value |
|----------|-------|
| English | GPU Clearance |
| Simplified Chinese | 显卡限长 |
| Traditional Chinese | 顯卡限長 |
| Japanese | GPU対応長 |
| German | Maximale GPU-Länge |

The database always stores the Attribute Code.

---

# 8. Supported Data Types

The platform supports:

| Type | Example |
|------|----------|
| Text | Black |
| Long Text | Product Description |
| Integer | 410 |
| Decimal | 1.25 |
| Boolean | True |
| Date | 2026-01-01 |
| DateTime | 2026-01-01 12:00 |
| Enum | ATX |
| Multi Enum | ATX, Micro ATX |
| Image | Product Image |
| File | Manual PDF |
| URL | Product Page |
| JSON | Configuration |
| Markdown | Feature Description |

---

# 9. Attribute Options

Enum attributes store options separately.

Example:

Motherboard Support

Options

- E-ATX
- ATX
- Micro ATX
- Mini ITX

Adding options does not require database changes.

---

# 10. Units

Units reference the Unit Library.

Examples:

Length

- mm

Weight

- g
- kg

Speed

- RPM

Power

- W

Temperature

- °C

Noise

- dBA

Units must never be stored as free text.

---

# 11. Validation Rules

Each Attribute may define validation.

Supported rules:

- Required
- Minimum
- Maximum
- Regular Expression
- Enumeration
- Formula
- Cross-field Validation
- Custom Validator

Example:

GPU_CLEARANCE

Minimum = 150

Maximum = 700

---

# 12. Search Configuration

Each Attribute defines search behavior.

Example

| Property | Value |
|----------|-------|
| Searchable | Yes |
| Filterable | Yes |
| Sortable | Yes |

Frontend search panels are generated automatically.

---

# 13. Excel Configuration

Each Attribute controls Excel behavior.

| Property | Description |
|----------|-------------|
| Excel Column | Export column name |
| Import Enabled | Yes/No |
| Export Enabled | Yes/No |
| Column Width | Optional |
| Cell Format | Optional |

Excel templates must use metadata definitions.

---

# 14. API Configuration

Attributes automatically generate API schemas.

Example

```json
{
  "GPU_CLEARANCE": 410,
  "CPU_COOLER_HEIGHT": 185
}
```

Field names are generated from Attribute Codes.

---

# 15. UI Configuration

The UI renders controls based on the attribute metadata.

Examples:

| Data Type | Control |
|-----------|---------|
| Text | Input |
| Integer | Number Input |
| Boolean | Switch |
| Enum | Select |
| Multi Enum | Multi Select |
| Date | Date Picker |
| Image | Image Upload |
| File | File Upload |

No UI form should manually define fields.

---

# 16. Version Control

Each Attribute includes:

- Version
- Created Time
- Updated Time
- Created By
- Updated By
- Active Status

Previous versions remain queryable.

---

# 17. Audit Requirements

Any change to an Attribute must generate an audit record.

Audit includes:

- User
- Time
- Before Value
- After Value
- Reason

Audit records are immutable.

---

# 18. Business Rules

The following rules apply:

- Attribute Codes are globally unique.
- Display Names may repeat across languages.
- Units must reference the Unit Library.
- Enum values must reference Option records.
- Soft delete only.
- Attribute Codes cannot be renamed after release.

---

# 19. Examples

| Attribute | Data Type | Unit |
|----------|-----------|------|
| GPU Clearance | Integer | mm |
| CPU Cooler Height | Integer | mm |
| PSU Length | Integer | mm |
| Front USB Type-C | Boolean | — |
| Motherboard Support | Multi Enum | — |
| Product Weight | Decimal | kg |

---

# 20. Definition of Done

The Product Attribute Model is complete when:

- Every product field is represented as an Attribute.
- No specification field is hardcoded.
- UI forms are generated from metadata.
- Excel import/export uses metadata.
- API schemas are generated from metadata.
- Validation rules are metadata-driven.
- Units reference the Unit Library.
- Attribute definitions are reusable across categories.

---

# Document Information

| Item | Value |
|------|-------|
| Document | 02_Product_Attribute_Model.md |
| Version | 1.0 |
| Status | Released |
| Owner | Ocypus Engineering Team |
| Last Updated | 2026-07-22 |
