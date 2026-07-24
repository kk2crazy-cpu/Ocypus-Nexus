# Testing Strategy

Project: Ocypus Nexus

Version: 1.0

Status: Released

---

# 1. Purpose

This document defines the software testing strategy for Ocypus Nexus.

The objectives are:

- Improve software quality
- Prevent regression
- Ensure production stability
- Support continuous delivery

Testing is mandatory for every Pull Request.

---

# 2. Testing Pyramid

                E2E Test
              Integration
             Component Test
             Unit Test

Coverage increases from bottom to top.

---

# 3. Testing Scope

Backend

- Unit Tests
- API Tests
- Integration Tests
- Database Tests

Frontend

- Component Tests
- Page Tests
- UI Tests
- Accessibility Tests

Infrastructure

- Docker Tests
- Deployment Tests

---

# 4. Unit Test

Backend

Framework

pytest

Coverage

Minimum 85%

Mock external services whenever possible.

---

# 5. Frontend Test

Framework

- Vitest
- React Testing Library

Coverage

Minimum 80%

Test

- Components
- Hooks
- Forms
- State Management

---

# 6. API Test

Framework

pytest

httpx

Test

- Authentication
- CRUD
- Validation
- Pagination
- Upload
- Download

---

# 7. Database Test

Verify

- Migration
- Constraints
- Foreign Keys
- Indexes
- Transactions

SQLite is used locally.

PostgreSQL is used in CI.

---

# 8. Integration Test

Test interactions between

- Backend
- Database
- Redis
- MinIO

Use Docker Compose.

---

# 9. End-to-End Test

Framework

Playwright

Scenarios

- Login
- Create Product
- Edit Product
- Import Excel
- Export Excel
- Approval Workflow
- Asset Upload

---

# 10. Security Test

Verify

- JWT
- RBAC
- SQL Injection
- XSS
- CSRF
- File Upload Validation

---

# 11. Performance Test

Framework

k6

Verify

- API Response Time
- Concurrent Requests
- Import Performance
- Export Performance

---

# 12. AI Test

Verify

- Prompt Version
- Output Format
- Translation Quality
- Cache Hit
- Token Usage

---

# 13. Regression Test

Automatically execute

- Before Release
- Before Production Deployment

Regression tests must pass before deployment.

---

# 14. Test Data

Test data is managed separately.

Never use production data.

Use seed scripts to initialize test databases.

---

# 15. Quality Gates

A Pull Request can be merged only when

- All tests pass
- Coverage threshold is met
- No Critical Security Issues
- Lint passes
- Type Check passes

---

# 16. Definition of Done

The testing system is complete when

- Automated tests cover critical business logic.
- CI executes all test suites.
- Coverage reports are generated.
- Regression testing is automated.
