# CI/CD Architecture

Project: Ocypus Nexus

Version: 1.0

Status: Released

---

# 1. Goal

The CI/CD platform provides:

- Automatic testing
- Automatic code quality checks
- Automatic documentation generation
- Automatic Docker image build
- Automatic deployment
- Automatic release management

Everything begins from GitHub.

---

# 2. Branch Strategy

main
    ↑
release/*
    ↑
develop
    ↑
feature/*

Rules

feature/*

↓

Pull Request

↓

develop

↓

release

↓

main

Only Pull Request merging is allowed.

---

# 3. Pipeline

Developer

↓

Git Push

↓

GitHub Actions

↓

Code Check

↓

Unit Test

↓

Build

↓

Docker

↓

Artifact

↓

Deploy

↓

Notify

---

# 4. CI Workflow

Trigger

- push
- pull_request

Jobs

- Backend Lint
- Frontend Lint
- Backend Test
- Frontend Test
- Build
- Upload Artifact

---

# 5. Code Quality

Backend

- Ruff
- Black
- MyPy

Frontend

- ESLint
- Prettier
- TypeScript

Coverage

Minimum 80%

---

# 6. Database Validation

Automatically

- Create Database
- Run Migration
- Verify Schema
- Execute Seed Data

---

# 7. API Validation

Automatically

Generate

openapi.yaml

↓

Validate

↓

Publish Swagger

---

# 8. Docker Build

Images

ocypus/frontend

ocypus/backend

Build only once.

Deploy multiple times.

---

# 9. Artifact

Store

- Docker Images
- Coverage
- OpenAPI
- Documentation

Retention

90 days.

---

# 10. Release Workflow

Tag

↓

Generate Changelog

↓

Build Docker

↓

GitHub Release

↓

Publish

---

# 11. Deployment

Environment

Development

↓

Staging

↓

Production

Production deployment requires manual approval.

---

# 12. Secrets

Stored in

GitHub Secrets

Examples

DATABASE_URL

JWT_SECRET

MINIO_KEY

OPENAI_API_KEY

---

# 13. Rollback

Rollback by

Previous Docker Image

or

Previous Git Tag

---

# 14. Notifications

Send notifications to

- Email
- Slack
- Microsoft Teams
- Discord

---

# 15. Metrics

Collect

- Build Time
- Test Duration
- Deployment Time
- Success Rate
- Failure Rate

---

# 16. Definition of Done

The CI/CD pipeline is complete when:

- Every PR runs automatically.
- Every release creates Docker images.
- Staging deployment is automatic.
- Production deployment requires approval.
- Rollback is supported.
