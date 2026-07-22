# Contributing to Ocypus Nexus

Thank you for contributing to Ocypus Nexus.

This document defines the official development workflow, coding standards, Git conventions, and review process for all contributors, including AI-assisted development tools such as Codex.

---

## Project Principles

All contributions must follow these principles:

* Metadata First
* Database as Source of Truth
* Excel Compatibility is Mandatory
* No Hardcoded Product Fields
* Architecture Before Implementation
* Tests Before Merge
* Documentation Before Release
* Auditability and Traceability

---

## Development Workflow

All work must follow the official workflow:

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
Documentation
↓
Review
↓
Merge

Do not skip steps.

---

## Branch Strategy

The repository uses Git Flow.

### Main Branches

| Branch  | Purpose               |
| ------- | --------------------- |
| main    | Production-ready code |
| develop | Integration branch    |

### Feature Branches

Create feature branches from develop.

Format:

feature/<module>-<short-description>

Examples:

* feature/auth-login
* feature/product-crud
* feature/excel-export
* feature/rbac-permissions
* feature/database-schema

### Other Branch Types

| Prefix    | Usage                   |
| --------- | ----------------------- |
| bugfix/   | Bug fixes               |
| hotfix/   | Urgent production fixes |
| release/  | Release preparation     |
| docs/     | Documentation updates   |
| chore/    | Maintenance tasks       |
| refactor/ | Code refactoring        |
| test/     | Test-related work       |

---

## Commit Message Convention

Follow Conventional Commits.

### Format

<type>(<scope>): <description>

### Types

| Type     | Description             |
| -------- | ----------------------- |
| feat     | New feature             |
| fix      | Bug fix                 |
| docs     | Documentation           |
| style    | Formatting only         |
| refactor | Refactoring             |
| test     | Tests                   |
| chore    | Maintenance             |
| perf     | Performance improvement |
| ci       | CI/CD changes           |
| build    | Build system changes    |

### Examples

* feat(product): add product CRUD API
* fix(excel): preserve merged cells during export
* docs(api): update authentication endpoints
* refactor(database): optimize attribute query
* test(rbac): add permission validation tests
* chore(repo): update gitignore

### Rules

* Use lowercase type
* Use imperative mood
* Keep description under 72 characters
* Do not end with a period
* Reference issue number when applicable

---

## Pull Request Process

### Before Creating a PR

* [ ] Code builds successfully
* [ ] Tests pass
* [ ] Lint passes
* [ ] Type checking passes
* [ ] Documentation updated
* [ ] Database migration included if needed
* [ ] API documentation updated if needed
* [ ] Screenshots added for UI changes
* [ ] No debug code remains
* [ ] No TODO comments remain

### PR Title Format

<type>(<scope>): <description>

Example:

feat(product): implement product creation API

### PR Description Must Include

* Summary of changes
* Related issue or task
* Database changes
* API changes
* UI changes
* Testing performed
* Screenshots if applicable
* Breaking changes if any

### Review Requirements

* At least one approval is required
* All CI checks must pass
* No unresolved comments
* Documentation must be updated
* Tests must be included for new features

---

## Coding Standards

### General

* Write clear and maintainable code
* Prefer readability over cleverness
* Keep functions small and focused
* Avoid duplication
* Use meaningful names
* Add comments only when necessary

### Python / FastAPI

* Follow PEP 8
* Use type hints
* Use Pydantic models
* Keep business logic in services
* Keep API routes thin
* Use dependency injection
* Write unit tests

### TypeScript / React

* Use strict TypeScript
* Use functional components
* Use hooks appropriately
* Avoid any type
* Keep components reusable
* Separate UI from business logic

### SQL

* Use snake_case
* Use explicit foreign keys
* Add indexes when needed
* Write reversible migrations
* Do not use SELECT *

---

## Database Rules

* Do not modify existing columns without approval
* Use Alembic for migrations
* Migrations must be reversible
* Add indexes for searchable fields
* Preserve data compatibility
* Update data dictionary
* Update ER diagram if relationships change

### Naming Convention

* Tables: snake_case plural
* Columns: snake_case
* Primary key: id
* Foreign key: <table>_id
* Timestamps: created_at, updated_at
* Boolean fields: is_<name>, has_<name>

---

## API Rules

* Use REST conventions
* Use plural resource names
* Return consistent response format
* Use proper HTTP status codes
* Validate all input
* Document all endpoints
* Do not introduce breaking changes without approval

---

## Frontend Rules

* Use metadata-driven forms
* Do not hardcode product fields
* Keep components reusable
* Use centralized state when needed
* Handle loading and error states
* Support responsive layout
* Follow UI design guidelines

---

## Excel Compatibility Rules

This project must maintain 100% compatibility with existing Excel templates.

* Do not change template structure
* Do not change sheet names
* Do not change column order
* Preserve merged cells
* Preserve formulas
* Preserve styles
* Preserve validation rules
* Test export with real templates

Any Excel-related change requires manual verification.

---

## Testing Requirements

### Required Tests

* Unit tests for business logic
* API tests for endpoints
* Permission tests for RBAC
* Database migration tests
* Excel import/export tests
* UI tests for critical workflows

### Coverage Expectations

* New business logic must have tests
* Critical modules should have high coverage
* Excel engine must be thoroughly tested
* RBAC must be fully tested

---

## Documentation Requirements

Update documentation when changing:

* Database schema
* API endpoints
* Product specifications
* Excel templates
* Permission rules
* Deployment process
* Environment variables
* User workflows

---

## AI-Assisted Development Rules

When using Codex or other AI tools:

* Review all generated code
* Ensure architecture compliance
* Ensure naming convention compliance
* Ensure test coverage
* Ensure documentation is updated
* Do not merge unreviewed AI-generated code

AI tools must not:

* Redesign architecture
* Rename database fields
* Change API contracts
* Modify Excel templates
* Hardcode product attributes
* Remove audit logging
* Bypass RBAC
* Introduce breaking changes

---

## Definition of Done

A task is complete only when:

* [ ] Requirements implemented
* [ ] Code reviewed
* [ ] Tests passing
* [ ] Lint passing
* [ ] Type checks passing
* [ ] Documentation updated
* [ ] Database migration included if needed
* [ ] API documentation updated if needed
* [ ] Excel compatibility verified if applicable
* [ ] No TODO comments
* [ ] No debug code
* [ ] PR approved
* [ ] Merged into develop

---

## Getting Help

If you are unsure about a change:

* Check the documentation first
* Check existing patterns in the codebase
* Open a discussion or issue
* Ask for architecture review before implementation

---

## License

By contributing to this project, you agree that your contributions will be licensed under the MIT License.
