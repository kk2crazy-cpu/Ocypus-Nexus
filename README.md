# Ocypus Nexus

> Enterprise Product Information Management Platform (PIM)

![Version](https://img.shields.io/badge/version-v0.1.0-blue)
![Status](https://img.shields.io/badge/status-Planning-orange)
![License](https://img.shields.io/badge/license-MIT-green)

---

## Overview

Ocypus Nexus is an enterprise-grade Product Information Management (PIM) platform designed to replace traditional Excel-centric product management.

The platform provides a centralized, metadata-driven architecture for managing all product specifications, product categories, multilingual content, Excel import/export, and future integrations such as official websites, ERP, and DAM systems.

The primary goal is to ensure that all product information originates from a single source of truth while maintaining full compatibility with existing Excel templates.

---

## Objectives

- Centralized product management
- Metadata-driven architecture
- Excel compatibility (100%)
- Multi-language support
- Version control
- Audit logging
- RBAC permission management
- Docker deployment
- RESTful API
- React frontend
- FastAPI backend

---

## Core Principles

- Metadata First
- Database as Source of Truth
- Excel is an Output
- No Hardcoded Product Fields
- Convention over Configuration
- Single Source of Truth

---

## Technology Stack

### Frontend

- React
- TypeScript
- Vite
- Ant Design

### Backend

- FastAPI
- SQLAlchemy
- Alembic
- Pydantic

### Database

- SQLite (Development)
- PostgreSQL (Production)

### Deployment

- Docker
- Docker Compose
- Nginx

---

## Repository Structure

```text
Ocypus-Nexus/

backend/
frontend/
database/
docs/
specifications/
docker/
scripts/
templates/
tests/
.github/

README.md
LICENSE
CHANGELOG.md
```

---

## Development Workflow

Requirement

↓

Specification

↓

Database

↓

API

↓

Backend

↓

Frontend

↓

Testing

↓

Release

---

## Documentation

| Document | Description |
|----------|-------------|
| docs/00_System_Architecture_Design.md | System Architecture |
| docs/02_Database_Design.md | Database Design |
| docs/03_UI_Design.md | UI Design |
| docs/04_Excel_Import_Export.md | Excel Engine |
| docs/05_API_Specification.md | API Specification |

---

## Product Categories

Current Categories

- Case
- Power Supply
- Liquid Cooler
- Air Cooler
- Fan
- Accessory

Future Categories

- Monitor
- Keyboard
- Mouse
- SSD
- Memory
- Gaming Desk
- Gaming Chair

---

## Development Status

| Module | Status |
|---------|--------|
| Architecture | ✅ Completed |
| Specifications | 🚧 In Progress |
| Database | 🚧 In Progress |
| Backend | ⏳ Planned |
| Frontend | ⏳ Planned |
| Excel Engine | ⏳ Planned |
| RBAC | ⏳ Planned |
| Docker | ⏳ Planned |

---

## License

This project is licensed under the MIT License.

---

## Maintainer

Ocypus Engineering Team
