# Asset Storage Architecture

**Project:** Ocypus Nexus

**Module:** Digital Asset Management (DAM)

**Version:** 1.0

**Status:** Released

---

# 1. Purpose

The Asset Storage module provides centralized management for all digital files used across Ocypus Nexus.

Supported asset types include:

- Product Images
- Hero Images
- Gallery Images
- Packaging Images
- Manuals (PDF)
- Datasheets
- Certificates
- Videos
- Marketing Materials
- CAD Files
- STEP Files
- STL Files
- AI / PSD Source Files
- Logos
- QR Codes

The Asset module serves as the single source of truth for all digital resources.

---

# 2. Design Goals

The system must support:

- Unlimited assets
- Multiple storage providers
- Asset versioning
- Image optimization
- Thumbnail generation
- Duplicate detection
- Permission control
- CDN acceleration
- Metadata extraction

---

# 3. Architecture

```
Upload

↓

Virus Scan

↓

Metadata Extraction

↓

SHA256 Calculation

↓

Duplicate Detection

↓

Object Storage

↓

Thumbnail Generation

↓

Asset Database

↓

CDN
```

---

# 4. Storage Strategy

Asset binary files are NOT stored inside SQLite.

SQLite stores metadata only.

Recommended storage:

```
SQLite

↓

Asset Metadata

↓

Object Storage

↓

S3 Compatible Storage
```

Supported providers:

- AWS S3
- Cloudflare R2
- MinIO
- Azure Blob
- Google Cloud Storage
- Local Storage (Development)

---

# 5. Asset Categories

Examples

```
PRODUCT_IMAGE

HERO_IMAGE

GALLERY

MANUAL

DATASHEET

VIDEO

CERTIFICATE

LOGO

PACKAGE

DRAWING

CAD

STEP

STL

PSD

AI

MARKETING
```

---

# 6. Asset Lifecycle

```
Upload

↓

Pending Scan

↓

Available

↓

Archived

↓

Deleted
```

---

# 7. Asset Metadata

Each asset stores:

- UUID
- SHA256
- MIME Type
- Original Filename
- File Extension
- Width
- Height
- Duration
- DPI
- File Size
- Uploaded By
- Uploaded Time

---

# 8. Image Processing

Automatic generation:

Original

↓

4096 px

↓

2048 px

↓

1024 px

↓

512 px

↓

256 px

↓

Thumbnail

Supported formats:

- JPG
- PNG
- WEBP
- AVIF

---

# 9. Duplicate Detection

SHA256 hash is calculated.

If hash already exists:

Do not upload again.

Create a new asset reference only.

---

# 10. Asset Version

Example

```
Product Image

↓

Version 1

↓

Version 2

↓

Version 3
```

Previous versions remain recoverable.

---

# 11. Permission

Example

| Role | Permission |
|------|------------|
| Viewer | Download |
| Marketing | Upload |
| Engineer | Upload / Replace |
| Product Manager | Publish |
| Admin | Full Control |

---

# 12. CDN

Recommended:

Object Storage

↓

Cloudflare CDN

↓

Browser Cache

↓

Website

---

# 13. API

```
POST /api/v1/assets/upload

GET /api/v1/assets/{id}

DELETE /api/v1/assets/{id}

GET /api/v1/assets/search

POST /api/v1/assets/replace
```

---

# 14. Future Features

- AI image tagging
- OCR
- Background removal
- Automatic WEBP conversion
- Image quality scoring
- EXIF extraction

---

# 15. Definition of Done

The Asset Storage module is complete when:

- Files are stored in object storage.
- Metadata is stored in SQLite.
- Duplicate files are detected.
- Images are optimized automatically.
- Multiple versions are supported.
- Permission control is enforced.
- CDN integration is supported.

---

# Document Information

| Item | Value |
|------|-------|
| Document | 11_Asset_Storage_Design.md |
| Version | 1.0 |
| Status | Released |
| Owner | Ocypus Engineering Team |
