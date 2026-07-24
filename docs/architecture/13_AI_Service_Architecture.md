# AI Service Architecture

**Project:** Ocypus Nexus

**Module:** AI Service Layer

**Version:** 1.0

**Status:** Released

---

# 1. Purpose

The AI Service Layer provides intelligent capabilities across the Ocypus Nexus platform.

Rather than operating as an isolated chatbot, AI functions as an infrastructure service available to every module.

Supported modules include:

- Product Management
- Metadata
- Website CMS
- Excel Engine
- Asset Management
- Workflow
- Search
- Translation
- Marketing

---

# 2. Design Principles

The AI layer shall be:

- Provider Independent
- Prompt Version Controlled
- Observable
- Auditable
- Cacheable
- Permission Controlled
- Cost Aware

---

# 3. Overall Architecture

```
User

↓

Application

↓

AI Service

↓

Task Dispatcher

↓

Prompt Manager

↓

LLM Provider

↓

Response Validator

↓

Result Cache

↓

Business Module
```

---

# 4. AI Providers

Supported providers

```
OpenAI

Azure OpenAI

Compatible OpenAI APIs

Local Models
```

All providers implement a common interface.

---

# 5. Provider Abstraction

```
AIProvider

├── Chat
├── Embedding
├── Vision
├── OCR
├── Speech
└── Image Generation
```

Business modules never call providers directly.

---

# 6. AI Tasks

Supported tasks

```
Translation

Feature Writing

SEO Generation

FAQ Generation

Product Summary

Specification Analysis

Specification Comparison

Metadata Classification

Image Tagging

OCR

Excel Parsing
```

---

# 7. Prompt Management

Every prompt includes:

- Prompt ID
- Version
- Language
- Module
- Variables
- Temperature
- Max Tokens

Prompts are stored centrally.

---

# 8. Prompt Versioning

```
Prompt

↓

v1.0

↓

v1.1

↓

v2.0
```

Historical prompts remain available.

---

# 9. Translation

Supported languages

- English
- 简体中文
- 繁體中文
- 日本語
- 한국어
- German
- French
- Spanish

Translation results require optional human review before publication.

---

# 10. Feature Generation

Input

```
Metadata

↓

Specifications

↓

Marketing Position
```

Output

- Product Features
- Website Copy
- Brochure Text
- Product Highlights

---

# 11. SEO Generation

Automatically generates

- SEO Title
- Meta Description
- Keywords
- Open Graph Description
- Structured Data (JSON-LD)

---

# 12. FAQ Generation

Based on

- Specifications
- Existing FAQs
- Product Category

Produces

- Installation FAQ
- Compatibility FAQ
- Troubleshooting FAQ

---

# 13. Product Comparison

Input

```
Product A

↓

Product B
```

Output

- Difference Summary
- Comparison Table
- Recommendation Notes

---

# 14. Excel Intelligence

Capabilities

- Detect Template Version
- Identify Missing Fields
- Normalize Units
- Detect Invalid Values
- Suggest Corrections

---

# 15. Vision

Supported capabilities

- Image Caption
- OCR
- Product Recognition
- Packaging Detection
- Logo Detection

---

# 16. Embedding Service

Embeddings are generated for

- Products
- Specifications
- Features
- Manuals
- News

Supports semantic search.

---

# 17. AI Cache

Cache Key

```
Provider

+

Prompt Version

+

Model

+

Input Hash
```

Avoids repeated generation.

---

# 18. AI Audit

Each AI request records

- Task Type
- Provider
- Model
- Prompt Version
- Processing Time
- Token Usage
- Cost
- Operator

---

# 19. Safety

The AI layer supports

- Prompt Validation
- Output Validation
- Sensitive Data Filtering
- Retry Policy
- Timeout Control

---

# 20. API

```
POST /api/v1/ai/translate

POST /api/v1/ai/features

POST /api/v1/ai/seo

POST /api/v1/ai/faq

POST /api/v1/ai/compare

POST /api/v1/ai/excel/analyze

POST /api/v1/ai/vision
```

---

# 21. Workflow

```
Business Module

↓

AI Request

↓

Provider

↓

Validation

↓

Approval (Optional)

↓

Publish
```

---

# 22. Future Expansion

Future capabilities

- AI Product Naming
- AI Image Enhancement
- AI Video Script
- AI Release Notes
- AI Documentation
- AI Meeting Summary
- AI Knowledge Base

---

# 23. Definition of Done

The AI Service Layer is complete when

- Providers are interchangeable.
- Prompts are version-controlled.
- Outputs are auditable.
- Translation is supported.
- SEO generation is supported.
- Feature generation is supported.
- Semantic search is available.
- AI usage can be monitored.

---

# Document Information

| Item | Value |
|------|-------|
| Document | 13_AI_Service_Architecture.md |
| Version | 1.0 |
| Status | Released |
| Owner | Ocypus Engineering Team |
