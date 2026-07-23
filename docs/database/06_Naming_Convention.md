# Naming Convention

**Project:** Ocypus Nexus

**Document Version:** 1.0

**Status:** Released

---

# 1. Purpose

This document defines the official naming conventions for the Ocypus Nexus project.

All backend, frontend, database, API, documentation, and Excel mappings must comply with these standards.

The goal is to ensure long-term maintainability and consistency.

---

# 2. General Principles

Naming should be:

- Consistent
- Predictable
- Self-explanatory
- English only
- Technology independent

Avoid abbreviations unless they are industry standards.

Good

```
product_attribute_value

motherboard_support

radiator_support
```

Bad

```
prdAttr

mb

radSup
```

---

# 3. Database Tables

Use:

snake_case

Singular nouns only.

Examples

```
category

product

product_revision

attribute

attribute_group

excel_template

audit_log
```

Never use plural names.

Incorrect

```
products

categories

users
```

---

# 4. Database Columns

Use:

snake_case

Examples

```
product_code

created_at

updated_at

attribute_group_id

display_order
```

Boolean fields

Prefix with:

```
is_

has_

can_
```

Examples

```
is_deleted

is_active

has_image

can_export
```

---

# 5. Primary Keys

Always

```
id
```

Never

```
product_id

category_pk

uuid
```

Referenced keys use:

```
<entity>_id
```

Examples

```
category_id

product_id

attribute_id

revision_id
```

---

# 6. Constraints

Primary Key

```
PK_PRODUCT
```

Unique

```
UK_PRODUCT_CODE
```

Foreign Key

```
FK_PRODUCT_SERIES
```

Check Constraint

```
CK_PRODUCT_STATUS
```

Index

```
IDX_PRODUCT_NAME
```

Composite Index

```
IDX_PRODUCT_STATUS_SERIES
```

---

# 7. SQLAlchemy Models

Model names use:

PascalCase

Examples

```
Category

Product

ProductRevision

Attribute

AttributeGroup

ExcelTemplate
```

File names use:

snake_case

Examples

```
product.py

attribute_group.py

excel_template.py
```

---

# 8. Python Variables

Use:

snake_case

Examples

```
product_name

attribute_value

current_revision

excel_mapping
```

Constants

```
UPPER_SNAKE_CASE
```

Example

```
DEFAULT_LANGUAGE

MAX_UPLOAD_SIZE

DEFAULT_PAGE_SIZE
```

---

# 9. API Endpoints

REST resources use:

kebab-case

Examples

```
/api/v1/products

/api/v1/product-revisions

/api/v1/attribute-groups

/api/v1/excel-templates
```

Actions use HTTP verbs.

Correct

```
GET /products

POST /products

PUT /products/{id}

DELETE /products/{id}
```

Avoid

```
/getProducts

/updateProduct
```

---

# 10. JSON Naming

JSON properties use:

camelCase

Example

```json
{
    "productId": "...",
    "productCode": "GammaC50",
    "productName": "Gamma C50",
    "currentRevision": "Rev A"
}
```

---

# 11. Metadata Codes

Attribute codes

```
UPPER_SNAKE_CASE
```

Examples

```
GPU_CLEARANCE

CPU_COOLER_HEIGHT

PSU_LENGTH

USB_TYPE_C

MOTHERBOARD_SUPPORT
```

Codes are immutable.

---

# 12. Excel Template Naming

Template

```
CASE_STANDARD_V1

PSU_STANDARD_V1

LIQUID_COOLER_V2
```

Sheet

```
Specification

Packaging

Accessories
```

Cell mappings

```
GPU_CLEARANCE -> H16

CPU_COOLER_HEIGHT -> H17
```

---

# 13. Frontend Components

Vue Components

PascalCase

Examples

```
ProductTable.vue

ProductEditor.vue

AttributePanel.vue

ExcelTemplateDialog.vue
```

Composables

```
useProduct.ts

useExcel.ts

usePermission.ts
```

---

# 14. Permission Codes

Permission format

```
module:action
```

Examples

```
product:view

product:create

product:update

product:delete

excel:export

excel:import

metadata:update

user:manage
```

---

# 15. Git Branches

Main

```
main
```

Development

```
develop
```

Feature

```
feature/product-editor
```

Bug

```
bugfix/excel-export
```

Hotfix

```
hotfix/login-error
```

Release

```
release/v1.0.0
```

---

# 16. Git Commit Convention

Format

```
type(scope): description
```

Examples

```
feat(product): add product editor

fix(excel): correct merged cells

docs(database): update data dictionary

refactor(api): simplify product service

test(import): add excel import tests
```

---

# 17. File Naming

Markdown

```
Product_Guide.md
```

SQL

```
sqlite.sql

seed_data.sql
```

Python

```
product_service.py

excel_exporter.py
```

TypeScript

```
product.service.ts

excel.export.ts
```

---

# 18. Definition of Done

The naming convention is complete when:

- Database follows snake_case.
- SQLAlchemy models follow PascalCase.
- APIs follow REST conventions.
- JSON uses camelCase.
- Metadata uses UPPER_SNAKE_CASE.
- Permission codes are standardized.
- Git workflow is standardized.
- All future modules comply with this specification.

---

# Document Information

| Item | Value |
|------|-------|
| Document | 06_Naming_Convention.md |
| Version | 1.0 |
| Status | Released |
| Owner | Ocypus Engineering Team |
| Last Updated | 2026-07-23 |
