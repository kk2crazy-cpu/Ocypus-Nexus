# Product Category Model

**Project:** Ocypus Nexus

**Document Version:** 1.0

**Status:** Released

---

# 1. Purpose

This document defines the standard product hierarchy used throughout Ocypus Nexus.

Every product managed by the platform must follow the same hierarchical model.

This hierarchy is the foundation for:

- Product Management
- Metadata
- Specifications
- API
- Database
- Excel Import
- Excel Export
- Website Integration
- Search
- Filtering

---

# 2. Product Hierarchy

Every product follows the structure below.

```

Category

↓

Product Type

↓

Series

↓

Model

↓

SKU

↓

Revision

```

This hierarchy is mandatory.

No level may be skipped.

---

# 3. Category

A Category represents the highest-level product classification.

Examples:

| Code | Name |
|------|------|
| CASE | PC Case |
| PSU | Power Supply |
| LC | Liquid Cooler |
| AC | Air Cooler |
| FAN | Cooling Fan |
| ACC | Accessory |

Each Category owns its own metadata template.

---

# 4. Product Type

A Product Type defines a structural subdivision inside a Category.

Example

Category

CASE

↓

Product Types

- Full Tower
- Mid Tower
- Mini Tower
- Open Frame
- Test Bench

Example

Liquid Cooler

↓

- 120mm
- 240mm
- 360mm
- 420mm

Product Types inherit all metadata from the Category.

---

# 5. Product Series

Series represents a product family.

Examples

| Series | Description |
|---------|-------------|
| Gamma | Mainstream |
| Delta | Compact |
| Sigma | Performance |
| Omega | Flagship |
| Iota | Entry Level |

Series are shared across multiple product generations.

---

# 6. Product Model

A Product Model represents a commercial product.

Examples

Gamma C50

Gamma C70

Delta C40

Omega L36

Sigma F12

Each Product Model belongs to exactly one Series.

---

# 7. SKU

SKU represents a purchasable product variant.

Examples

Gamma C50 Black

Gamma C50 White

Gamma C50 Black ARGB

Gamma C50 White ARGB

Each SKU has:

- Barcode
- Part Number
- Color
- Region
- Package
- Sales Status

---

# 8. Revision

Revision represents engineering changes.

Examples

Rev A

Rev B

Rev C

Revision history must never be deleted.

Only one revision can be Active.

---

# 9. Product Status

Products support the following lifecycle.

| Status | Description |
|----------|-------------|
| Draft | Under development |
| Engineering | Engineering review |
| Validation | Product validation |
| Marketing | Marketing preparation |
| Released | Public release |
| EOL | End of Life |
| Archived | Historical record |

Status changes must be audited.

---

# 10. Category Properties

Each Category contains:

| Property | Required |
|----------|----------|
| Code | Yes |
| Name | Yes |
| Display Name | Yes |
| Description | Optional |
| Icon | Optional |
| Sort Order | Yes |
| Active | Yes |
| Metadata Template | Yes |
| Created Time | Yes |
| Updated Time | Yes |

---

# 11. Product Type Properties

Each Product Type contains:

| Property | Required |
|----------|----------|
| Category ID | Yes |
| Code | Yes |
| Name | Yes |
| Description | Optional |
| Active | Yes |
| Sort Order | Yes |

---

# 12. Series Properties

Each Series contains:

| Property | Required |
|----------|----------|
| Code | Yes |
| Name | Yes |
| Display Name | Yes |
| Description | Optional |
| Logo | Optional |
| Release Year | Optional |
| Active | Yes |

---

# 13. Product Properties

Each Product contains:

| Property | Required |
|----------|----------|
| Product Code | Yes |
| Product Name | Yes |
| Marketing Name | Optional |
| Internal Name | Optional |
| Series | Yes |
| Product Type | Yes |
| Category | Yes |
| Launch Date | Optional |
| Status | Yes |
| Revision | Yes |

---

# 14. SKU Properties

Each SKU contains:

| Property | Required |
|----------|----------|
| SKU Code | Yes |
| Product ID | Yes |
| Part Number | Yes |
| Color | Optional |
| Region | Optional |
| Barcode | Optional |
| Package Version | Optional |
| Sales Status | Yes |

---

# 15. Naming Rules

Codes must follow uppercase naming.

Examples

CASE

PSU

LC

FAN

Product Codes use PascalCase.

Examples

GammaC50

DeltaC40

OmegaL36

SKU Codes use kebab-case.

Examples

gamma-c50-black

gamma-c50-white

---

# 16. Relationships

One Category

↓

Many Product Types

One Product Type

↓

Many Series

One Series

↓

Many Products

One Product

↓

Many SKUs

One SKU

↓

Many Revisions

---

# 17. Business Rules

Mandatory rules:

- Category Code must be unique.
- Product Type Code must be unique within a Category.
- Series Code must be globally unique.
- Product Code must be globally unique.
- SKU Code must be globally unique.
- Deleted records are soft-deleted only.
- Historical revisions remain available.

---

# 18. Future Expansion

The hierarchy must support additional product categories without schema modification.

Examples:

- Monitor
- Keyboard
- Mouse
- SSD
- Memory
- Gaming Chair
- Gaming Desk
- Peripheral Accessories

No database redesign is allowed.

---

# 19. Definition of Done

This specification is complete when:

- Product hierarchy is standardized.
- Category relationships are defined.
- Product lifecycle is defined.
- SKU model is defined.
- Revision model is defined.
- Naming conventions are documented.
- Business rules are documented.
- Database implementation can be generated directly from this document.

---

# Document Information

| Item | Value |
|------|-------|
| Document | 01_Product_Category_Model.md |
| Version | 1.0 |
| Status | Released |
| Owner | Ocypus Engineering Team |
| Last Updated | 2026-07-22 |
