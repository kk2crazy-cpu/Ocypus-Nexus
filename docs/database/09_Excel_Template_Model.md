# Excel Template Model

**Project:** Ocypus Nexus

**Document Version:** 1.0

**Status:** Released

---

# 1. Purpose

This document defines the Excel Template Engine used by Ocypus Nexus.

The primary objective is:

**Exported Excel files must be visually identical to the official template provided by Ocypus.**

The engine must preserve:

- Workbook
- Worksheet
- Cell Position
- Merged Cells
- Borders
- Fonts
- Colors
- Images
- Logo
- Column Width
- Row Height
- Formula
- Print Layout
- Page Break
- Freeze Pane
- Data Validation

Business data must remain independent from template layout.

---

# 2. Design Architecture

```
Product

↓

Metadata

↓

Excel Mapping

↓

Excel Renderer

↓

Excel Workbook
```

Template rendering must not contain any hardcoded coordinates.

---

# 3. Core Tables

```
excel_template

excel_template_version

excel_sheet

excel_cell

excel_mapping

excel_style

excel_image

excel_formula

excel_print_setting
```

---

# 4. excel_template

Purpose

Represents one Excel template.

Columns

| Column | Type |
|----------|------|
| id | UUID |
| code | VARCHAR(50) |
| name | VARCHAR(100) |
| category_id | UUID |
| current_version_id | UUID |
| description | TEXT |

Example

```
CASE_STANDARD

PSU_STANDARD

AIO_STANDARD
```

---

# 5. excel_template_version

Purpose

Stores template revisions.

Columns

| Column | Type |
|----------|------|
| id | UUID |
| template_id | UUID |
| version | VARCHAR(20) |
| file_hash | VARCHAR(64) |
| created_at | DATETIME |
| published_by | UUID |
| is_active | BOOLEAN |

Business Rule

Only one version may be Active.

Historical versions remain available.

---

# 6. excel_sheet

Purpose

Defines worksheets.

Columns

| Column | Type |
|----------|------|
| id | UUID |
| template_version_id | UUID |
| sheet_name | VARCHAR(100) |
| sheet_order | INTEGER |
| is_hidden | BOOLEAN |

Example

```
Specification

Packaging

Accessories
```

---

# 7. excel_cell

Purpose

Stores template cell metadata.

Columns

| Column | Type |
|----------|------|
| id | UUID |
| sheet_id | UUID |
| cell_address | VARCHAR(20) |
| row_index | INTEGER |
| column_index | INTEGER |
| merged_range | VARCHAR(30) |
| style_id | UUID |

Example

```
H16

A1:D1

C22
```

---

# 8. excel_mapping

Purpose

Maps metadata attributes to template cells.

Columns

| Column | Type |
|----------|------|
| id | UUID |
| attribute_id | UUID |
| sheet_id | UUID |
| cell_address | VARCHAR(20) |
| formatter | VARCHAR(100) |
| default_value | TEXT |

Example

```
GPU_CLEARANCE

↓

Specification

↓

H16
```

---

# 9. excel_style

Purpose

Defines reusable styles.

Columns

| Column | Type |
|----------|------|
| id | UUID |
| name | VARCHAR(100) |
| font_name | VARCHAR(100) |
| font_size | INTEGER |
| bold | BOOLEAN |
| italic | BOOLEAN |
| font_color | VARCHAR(20) |
| fill_color | VARCHAR(20) |
| border_style | VARCHAR(30) |
| horizontal_align | VARCHAR(30) |
| vertical_align | VARCHAR(30) |
| wrap_text | BOOLEAN |

Styles are reusable across templates.

---

# 10. excel_image

Purpose

Stores image placeholders.

Columns

| Column | Type |
|----------|------|
| id | UUID |
| sheet_id | UUID |
| image_type | VARCHAR(50) |
| anchor_cell | VARCHAR(20) |
| width | INTEGER |
| height | INTEGER |
| asset_id | UUID |

Supported images

- Logo
- Product Image
- Certification Icon
- QR Code

---

# 11. excel_formula

Purpose

Stores formulas used by templates.

Columns

| Column | Type |
|----------|------|
| id | UUID |
| sheet_id | UUID |
| cell_address | VARCHAR(20) |
| formula | TEXT |

Example

```
=SUM(B2:B20)

=IF(A1="","",B1)
```

---

# 12. excel_print_setting

Purpose

Stores page layout.

Columns

| Column | Type |
|----------|------|
| id | UUID |
| template_version_id | UUID |
| paper_size | VARCHAR(20) |
| orientation | VARCHAR(20) |
| fit_to_page | BOOLEAN |
| margin_top | DECIMAL |
| margin_bottom | DECIMAL |
| margin_left | DECIMAL |
| margin_right | DECIMAL |

---

# 13. Rendering Workflow

```
Load Product

↓

Load Metadata

↓

Load Template

↓

Load Mapping

↓

Fill Values

↓

Apply Styles

↓

Insert Images

↓

Apply Formulas

↓

Apply Print Settings

↓

Generate Workbook
```

No workbook structure may be modified during rendering.

---

# 14. Import Workflow

```
Read Workbook

↓

Identify Template Version

↓

Validate Mapping

↓

Read Cells

↓

Convert Values

↓

Validate Metadata

↓

Save Product
```

---

# 15. Version Strategy

Templates are immutable after publication.

```
Version 1.0

↓

Version 1.1

↓

Version 2.0
```

Products retain the template version used at the time of export unless re-exported using a newer version.

---

# 16. Compatibility Rules

The engine must preserve:

- Merged Cells
- Hidden Rows
- Hidden Columns
- Conditional Formatting
- Cell Comments
- Hyperlinks
- Named Ranges
- Freeze Panes

Unsupported features should trigger warnings during template validation.

---

# 17. Validation

Before publishing a template:

- Cell mapping completeness
- Duplicate mapping detection
- Missing style detection
- Invalid merge range detection
- Broken image reference detection
- Formula validation
- Print area validation

Publishing is blocked if validation fails.

---

# 18. API

```
GET  /api/v1/excel/templates

GET  /api/v1/excel/templates/{id}

POST /api/v1/excel/export

POST /api/v1/excel/import

POST /api/v1/excel/templates/publish
```

---

# 19. Definition of Done

The Excel Template Engine is complete when:

- Templates are version-controlled.
- Cell mappings are metadata-driven.
- Styles are reusable.
- Images are configurable.
- Formulas are preserved.
- Print settings are preserved.
- Import and export use the same mapping model.
- Exported Excel matches the official template exactly.

---

# Document Information

| Item | Value |
|------|-------|
| Document | 09_Excel_Template_Model.md |
| Version | 1.0 |
| Status | Released |
| Owner | Ocypus Engineering Team |
| Last Updated | 2026-07-23 |
