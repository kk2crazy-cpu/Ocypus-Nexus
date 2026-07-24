# Website CMS Architecture

**Project:** Ocypus Nexus

**Module:** Website CMS

**Version:** 1.0

**Status:** Released

---

# 1. Purpose

The Website CMS is the presentation layer of Ocypus Nexus.

It enables the official website to retrieve all product-related content directly from the PIM database, eliminating duplicated maintenance across marketing, engineering, and website teams.

Website pages become a real-time projection of approved product data.

---

# 2. Design Goals

The CMS must support:

- Metadata-driven pages
- Multi-language content
- SEO management
- Product comparison
- Product downloads
- Feature management
- News & Articles
- Landing Pages
- Navigation management
- Draft / Publish workflow

---

# 3. Architecture

```
Engineering

↓

Product Database

↓

Approval Workflow

↓

CMS

↓

REST API

↓

Official Website
```

The website never edits product data directly.

---

# 4. Content Model

```
Website

├── Home
├── Products
├── Categories
├── Product Detail
├── Downloads
├── Compare
├── Support
├── News
├── About
└── Contact
```

---

# 5. Product Page

Each product page is composed of independent modules.

```
Hero Banner

↓

Gallery

↓

Key Features

↓

Specifications

↓

Downloads

↓

Related Products

↓

FAQ
```

Every section is configurable.

---

# 6. Hero Module

Contains:

- Product Name
- Marketing Name
- Hero Image
- Slogan
- Purchase Link
- Download Link

---

# 7. Feature Module

Structure

```
Feature

↓

Icon

↓

Title

↓

Subtitle

↓

Description

↓

Image

↓

Video
```

Unlimited features are supported.

---

# 8. Gallery Module

Supports:

- Product Images
- Lifestyle Images
- Exploded Views
- Dimension Drawings
- Packaging Images

Sorting is configurable.

---

# 9. Specification Module

Specifications are rendered dynamically from Metadata.

Example

```
Cooling

GPU Clearance

CPU Cooler Height

Radiator Support

Motherboard

Expansion Slots
```

No hardcoded specification fields exist.

---

# 10. Download Module

Supported downloads:

- User Manual
- Datasheet
- Driver
- Firmware
- Software
- Certificate
- Warranty

Downloads are linked through the Asset module.

---

# 11. Product Comparison

Comparison fields come directly from Metadata.

Example

```
Gamma C50

↓

GPU Clearance

410 mm

↓

Delta C40

↓

GPU Clearance

400 mm
```

The comparison page updates automatically when specifications change.

---

# 12. SEO

Every page stores:

- SEO Title
- SEO Description
- Keywords
- Canonical URL
- Open Graph Image
- Twitter Card

Automatic sitemap generation is supported.

---

# 13. Multi-language

Supported languages:

- English
- 简体中文
- 繁體中文
- 日本語
- 한국어

All translations are stored in the Translation module.

---

# 14. Navigation

Navigation is metadata-driven.

```
Main Menu

↓

Category

↓

Series

↓

Product
```

Marketing can modify menus without code changes.

---

# 15. News Module

Supports:

- Category
- Tags
- Author
- Publish Date
- Cover Image
- Rich Text
- SEO

---

# 16. Landing Pages

Marketing can create campaign pages.

Examples:

- New Product Launch
- Computex
- Black Friday
- CES
- Seasonal Promotions

Landing pages are independent of products.

---

# 17. Approval Workflow

```
Draft

↓

Review

↓

Approved

↓

Published

↓

Archived
```

Only approved content is visible on the website.

---

# 18. API

```
GET /api/v1/website/home

GET /api/v1/website/products

GET /api/v1/website/products/{code}

GET /api/v1/website/categories

GET /api/v1/website/news

GET /api/v1/website/downloads

GET /api/v1/website/compare
```

---

# 19. Cache Strategy

```
Database

↓

Redis

↓

REST API

↓

CDN

↓

Browser
```

Automatic cache invalidation occurs after product publication.

---

# 20. Future Features

- AI Product Description
- AI FAQ
- AI SEO Optimization
- AI Image Caption
- AI Translation
- Personalized Recommendations

---

# 21. Definition of Done

The Website CMS is complete when:

- Product pages are metadata-driven.
- Features are configurable.
- Downloads are centralized.
- SEO is configurable.
- Multi-language is supported.
- Product comparison is automatic.
- News management is integrated.
- Landing pages require no code deployment.
- Website content is synchronized with approved product data.

---

# Document Information

| Item | Value |
|------|-------|
| Document | 12_Website_CMS_Architecture.md |
| Version | 1.0 |
| Status | Released |
| Owner | Ocypus Engineering Team |
