# OpenAPI Architecture

**Project:** Ocypus Nexus

**Module:** REST API / OpenAPI

**Version:** 1.0

**Status:** Released

---

# 1. Purpose

This document defines the official REST API specification for Ocypus Nexus.

All external systems must communicate through the OpenAPI layer.

Supported clients include:

- Web Admin
- Official Website
- Dealer Portal
- Mobile App
- ERP
- CRM
- Third-party Systems

The API specification is the contract between frontend and backend.

---

# 2. API Principles

The API follows:

- RESTful Design
- Resource Oriented
- Stateless
- JSON First
- Version Controlled
- OpenAPI 3.1 Compatible

---

# 3. Base URL

Development

```
http://localhost:8000/api/v1
```

Production

```
https://api.ocypus.com/api/v1
```

---

# 4. Authentication

Authentication method:

```
JWT Access Token

↓

Refresh Token
```

Authorization header

```
Authorization: Bearer <AccessToken>
```

---

# 5. Authorization

Permission model

```
User

↓

Role

↓

Permission

↓

Endpoint
```

Example

```
product:view

product:create

product:update

product:delete

excel:import

excel:export
```

---

# 6. API Versioning

```
/api/v1

/api/v2
```

Breaking changes require a new version.

---

# 7. Naming Convention

Resources use plural nouns.

Examples

```
/products

/categories

/assets

/users

/roles

/templates
```

---

# 8. HTTP Methods

| Method | Purpose |
|---------|---------|
| GET | Query |
| POST | Create |
| PUT | Replace |
| PATCH | Partial Update |
| DELETE | Soft Delete |

---

# 9. Standard Response

Success

```json
{
  "success": true,
  "data": {},
  "timestamp": "2026-07-24T10:00:00Z"
}
```

Failure

```json
{
  "success": false,
  "error": {
    "code": "PRODUCT_NOT_FOUND",
    "message": "Product does not exist."
  }
}
```

---

# 10. Pagination

Request

```
GET /products?page=1&pageSize=20
```

Response

```json
{
  "page":1,
  "pageSize":20,
  "total":325,
  "items":[]
}
```

---

# 11. Sorting

Example

```
GET /products?sort=productName

GET /products?sort=-createdAt
```

Ascending

```
field
```

Descending

```
-field
```

---

# 12. Filtering

Examples

```
GET /products?series=Gamma

GET /products?status=ACTIVE

GET /products?category=CASE
```

Multiple filters

```
GET /products?series=Gamma&status=ACTIVE
```

---

# 13. Search

```
GET /products/search?q=Gamma
```

Supports:

- Product Code
- Product Name
- Marketing Name
- SKU

---

# 14. Batch Operations

Examples

```
POST /products/batch-delete

POST /products/batch-export

POST /products/batch-update
```

---

# 15. File Upload

```
POST /assets/upload
```

Multipart Form Data

Supported:

- Images
- PDF
- ZIP
- Video
- STEP
- CAD

---

# 16. Excel APIs

```
POST /excel/import

POST /excel/export

GET /excel/templates

POST /excel/templates/publish
```

---

# 17. Product APIs

```
GET /products

GET /products/{id}

POST /products

PATCH /products/{id}

DELETE /products/{id}
```

---

# 18. Metadata APIs

```
GET /metadata/templates

GET /attributes

POST /attributes

PATCH /attributes/{id}
```

---

# 19. Asset APIs

```
GET /assets

POST /assets

GET /assets/{id}

DELETE /assets/{id}
```

---

# 20. Website APIs

```
GET /website/products

GET /website/products/{code}

GET /website/news

GET /website/downloads
```

---

# 21. Approval APIs

```
POST /approval/submit

POST /approval/approve

POST /approval/reject

GET /approval/tasks
```

---

# 22. Audit APIs

```
GET /audit

GET /audit/{id}

GET /products/{id}/history
```

---

# 23. Error Codes

Examples

```
PRODUCT_NOT_FOUND

SKU_ALREADY_EXISTS

INVALID_METADATA

PERMISSION_DENIED

INVALID_TOKEN

FILE_TOO_LARGE

UNSUPPORTED_FILE

TEMPLATE_NOT_FOUND
```

---

# 24. Rate Limiting

Recommended defaults

| Endpoint | Limit |
|-----------|------:|
| Login | 10/min |
| Upload | 60/hour |
| Export | 30/hour |
| Search | 300/min |

---

# 25. Webhooks

Supported events

```
product.created

product.updated

product.released

asset.uploaded

excel.imported

approval.completed
```

---

# 26. OpenAPI Generation

The backend must generate:

```
openapi.yaml

swagger.json
```

Generated automatically from source code.

---

# 27. SDK

Official SDKs

```
TypeScript

Python

Java

C#

Go
```

Generated from OpenAPI.

---

# 28. Security

Recommended security features

- HTTPS Only
- JWT Expiration
- Refresh Token Rotation
- CSRF Protection
- XSS Protection
- SQL Injection Prevention
- Content Security Policy

---

# 29. Definition of Done

The API layer is complete when:

- OpenAPI 3.1 specification is generated.
- Swagger UI is available.
- JWT authentication is implemented.
- RBAC authorization is enforced.
- Pagination, sorting and filtering are standardized.
- Batch operations are supported.
- Webhooks are available.
- SDKs can be generated automatically.

---

# Document Information

| Item | Value |
|------|-------|
| Document | 06_OpenAPI_Architecture.md |
| Version | 1.0 |
| Status | Released |
| Owner | Ocypus Engineering Team |
