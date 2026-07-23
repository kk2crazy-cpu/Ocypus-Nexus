# Unit System Specification

**Project:** Ocypus Nexus

**Document Version:** 1.0

**Status:** Released

---

# 1. Purpose

This document defines the standard engineering unit system used throughout the Ocypus Nexus Product Information Management (PIM) platform.

Every measurable product attribute must reference a predefined unit.

Units are managed centrally through the Unit Library and are reused by:

- Product Specifications
- Metadata
- Excel Import
- Excel Export
- REST API
- UI Display
- Search
- Filtering
- Validation
- Product Comparison

Units must never be entered as free text.

---

# 2. Design Principles

The Unit System follows these principles:

- Centralized Management
- Metadata Driven
- Category Independent
- International Standard
- Extensible
- Localization Ready
- Conversion Supported

---

# 3. Unit Architecture

```
Quantity Type
        │
        ▼
Unit Group
        │
        ▼
Base Unit
        │
        ▼
Derived Unit
        │
        ▼
Attribute
        │
        ▼
Product Value
```

Every Attribute references exactly one Unit or no Unit.

---

# 4. Quantity Types

Supported quantity types:

| Code | Description |
|------|-------------|
| LENGTH | Length |
| WEIGHT | Weight |
| VOLUME | Volume |
| AREA | Area |
| POWER | Power |
| VOLTAGE | Voltage |
| CURRENT | Current |
| SPEED | Rotational Speed |
| TEMPERATURE | Temperature |
| NOISE | Sound Level |
| STORAGE | Capacity |
| DATA_RATE | Data Transfer Rate |
| FREQUENCY | Frequency |
| TIME | Time |
| COUNT | Quantity |

---

# 5. Standard Unit Library

## Length

| Unit | Symbol |
|------|--------|
| Millimeter | mm |
| Centimeter | cm |
| Meter | m |
| Inch | in |

---

## Weight

| Unit | Symbol |
|------|--------|
| Gram | g |
| Kilogram | kg |
| Pound | lb |

---

## Volume

| Unit | Symbol |
|------|--------|
| Liter | L |
| Milliliter | mL |

---

## Power

| Unit | Symbol |
|------|--------|
| Watt | W |

---

## Voltage

| Unit | Symbol |
|------|--------|
| Volt | V |

---

## Current

| Unit | Symbol |
|------|--------|
| Ampere | A |

---

## Rotational Speed

| Unit | Symbol |
|------|--------|
| Revolutions Per Minute | RPM |

---

## Temperature

| Unit | Symbol |
|------|--------|
| Degree Celsius | °C |

---

## Noise

| Unit | Symbol |
|------|--------|
| Decibel A-weighted | dBA |

---

## Storage

| Unit | Symbol |
|------|--------|
| MB | MB |
| GB | GB |
| TB | TB |

---

## Data Rate

| Unit | Symbol |
|------|--------|
| Mbps | Mbps |
| Gbps | Gbps |
| MB/s | MB/s |

---

## Time

| Unit | Symbol |
|------|--------|
| Second | s |
| Minute | min |
| Hour | h |

---

## Count

| Unit | Symbol |
|------|--------|
| Piece | pcs |
| Set | set |

---

# 6. Base Units

Each quantity type defines one Base Unit.

| Quantity | Base Unit |
|----------|-----------|
| LENGTH | mm |
| WEIGHT | g |
| VOLUME | mL |
| POWER | W |
| VOLTAGE | V |
| CURRENT | A |
| SPEED | RPM |
| TEMPERATURE | °C |
| NOISE | dBA |
| STORAGE | MB |
| DATA_RATE | Mbps |
| TIME | s |

All conversions originate from the Base Unit.

---

# 7. Conversion Rules

Examples:

Length

```
1 cm = 10 mm

1 m = 1000 mm

1 in = 25.4 mm
```

Weight

```
1 kg = 1000 g

1 lb = 453.59237 g
```

Storage

```
1 GB = 1024 MB

1 TB = 1024 GB
```

---

# 8. Display Rules

Database stores:

```
410
```

Metadata determines:

```
mm
```

UI displays:

```
410 mm
```

The unit symbol is never stored in product values.

---

# 9. Excel Rules

Excel Export

```
GPU Clearance

410 mm
```

Excel Import

Accepted

```
410

410 mm
```

Stored

```
410
```

Unit parsing is handled automatically.

---

# 10. API Rules

API returns:

```json
{
  "value": 410,
  "unit": "mm"
}
```

Or when configured:

```json
{
  "GPU_CLEARANCE": 410
}
```

The API format is configurable but must remain consistent within a version.

---

# 11. Localization

Display names are localized.

Example:

| Language | Display |
|----------|---------|
| English | mm |
| Simplified Chinese | 毫米 |
| Traditional Chinese | 毫米 |
| Japanese | mm |

The stored unit code remains unchanged.

---

# 12. Validation

Validation includes:

- Unit existence
- Quantity compatibility
- Conversion availability
- Decimal precision
- Allowed unit list

Invalid example:

```
GPU Clearance = 410 kg
```

Valid example:

```
GPU Clearance = 410 mm
```

---

# 13. Business Rules

- Every measurable Attribute references one Unit.
- Units are immutable after release.
- Unit Codes are globally unique.
- Unit Symbols are globally unique.
- Conversion factors are version controlled.
- Free-text units are prohibited.

---

# 14. Precision Rules

Recommended precision:

| Quantity | Precision |
|----------|-----------|
| Length | 0 |
| Weight | 2 |
| Voltage | 1 |
| Current | 2 |
| Power | 0 |
| Temperature | 0 |
| Noise | 1 |
| Data Rate | 1 |

---

# 15. Future Expansion

The Unit Library supports future quantities such as:

- Airflow (CFM, m³/h)
- Static Pressure (mmH₂O)
- Thermal Resistance (°C/W)
- Color Temperature (K)
- Luminous Flux (lm)

No database schema changes are required.

---

# 16. Definition of Done

The Unit System is complete when:

- Every measurable Attribute references a Unit.
- Units are metadata-driven.
- Conversion rules are centralized.
- Excel import/export supports automatic parsing.
- REST API serializes units consistently.
- UI renders units dynamically.
- Localization is supported.
- Validation enforces unit compatibility.

---

# Document Information

| Item | Value |
|------|-------|
| Document | 05_Unit_System.md |
| Version | 1.0 |
| Status | Released |
| Owner | Ocypus Engineering Team |
| Last Updated | 2026-07-22 |
