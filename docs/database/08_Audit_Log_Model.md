# Audit Log Model

**Project:** Ocypus Nexus

**Document Version:** 1.0

**Status:** Released

---

# 1. Purpose

This document defines the Audit Log architecture for Ocypus Nexus.

Every business operation performed in the system must be traceable.

The audit system is designed to satisfy:

- Product traceability
- Metadata traceability
- User accountability
- Excel import/export history
- Security auditing
- Compliance requirements

Audit records are immutable.

---

# 2. Audit Scope

The following operations are audited:

- User Login
- User Logout
- Product Create
- Product Update
- Product Delete (Soft Delete)
- Metadata Update
- Excel Import
- Excel Export
- Permission Changes
- System Configuration Changes

---

# 3. Architecture

```
User Action

↓

Permission Check

↓

Business Logic

↓

Database Update

↓

Audit Service

↓

Audit Tables
```

Audit logging occurs after successful business transactions.

---

# 4. Core Tables

```
audit_log

change_history

import_history

export_history

login_history
```

---

# 5. Table: audit_log

Purpose

Stores every business operation.

Columns

| Column | Type |
|----------|------|
| id | UUID |
| module | VARCHAR(50) |
| entity | VARCHAR(100) |
| entity_id | UUID |
| operation | VARCHAR(20) |
| operator_id | UUID |
| operator_name | VARCHAR(100) |
| ip_address | VARCHAR(50) |
| user_agent | TEXT |
| request_id | VARCHAR(100) |
| operated_at | DATETIME |
| result | VARCHAR(20) |

Indexes

```
IDX_AUDIT_ENTITY

IDX_AUDIT_OPERATOR

IDX_AUDIT_TIME

IDX_AUDIT_MODULE
```

---

# 6. Table: change_history

Purpose

Stores field-level modifications.

Columns

| Column | Type |
|----------|------|
| id | UUID |
| audit_log_id | UUID |
| field_name | VARCHAR(100) |
| old_value | TEXT |
| new_value | TEXT |
| display_name | VARCHAR(100) |

One audit record may contain multiple field changes.

---

# 7. Table: import_history

Purpose

Records every Excel import.

Columns

| Column | Type |
|----------|------|
| id | UUID |
| template_id | UUID |
| filename | VARCHAR(255) |
| imported_by | UUID |
| imported_at | DATETIME |
| total_rows | INTEGER |
| success_rows | INTEGER |
| failed_rows | INTEGER |
| duration_ms | INTEGER |
| status | VARCHAR(20) |

Related artifacts

- Original File
- Error Report
- Import Log

---

# 8. Table: export_history

Purpose

Records every Excel export.

Columns

| Column | Type |
|----------|------|
| id | UUID |
| template_id | UUID |
| exported_by | UUID |
| exported_at | DATETIME |
| exported_rows | INTEGER |
| duration_ms | INTEGER |
| template_version | VARCHAR(20) |
| file_hash | VARCHAR(64) |

Purpose of file_hash

- Duplicate detection
- Integrity verification
- Download verification

---

# 9. Table: login_history

Purpose

Records authentication events.

Columns

| Column | Type |
|----------|------|
| id | UUID |
| user_id | UUID |
| username | VARCHAR(100) |
| login_time | DATETIME |
| logout_time | DATETIME |
| ip_address | VARCHAR(50) |
| device | VARCHAR(200) |
| browser | VARCHAR(100) |
| operating_system | VARCHAR(100) |
| success | BOOLEAN |
| failure_reason | VARCHAR(255) |

---

# 10. Operation Types

Supported operations

```
CREATE

UPDATE

DELETE

IMPORT

EXPORT

LOGIN

LOGOUT

PUBLISH

RESTORE

APPROVE

REJECT
```

---

# 11. Tracked Modules

```
Product

Metadata

Category

Attribute

Excel

Asset

User

Role

Permission

System
```

---

# 12. Change Comparison

Field changes are stored individually.

Example

```
Product Name

Old

Gamma C50

↓

New

Gamma C50 PRO
```

```
GPU Clearance

Old

400

↓

New

410
```

---

# 13. Restore Capability

Audit history supports viewing historical values.

Future versions may support:

- Restore single field
- Restore complete product
- Restore metadata template
- Restore Excel template

---

# 14. Export Tracking

Every exported Excel file records:

- Template Version
- Export Time
- Operator
- Product Count
- SHA-256 File Hash

This ensures exported files are fully traceable.

---

# 15. Security

Audit records:

- Cannot be edited
- Cannot be deleted
- Are visible only to authorized roles
- Must survive product deletion

---

# 16. Retention Policy

Recommended retention periods:

| Record Type | Retention |
|-------------|-----------|
| Audit Log | Permanent |
| Change History | Permanent |
| Import History | 5 Years |
| Export History | 5 Years |
| Login History | 2 Years |

Retention periods may be adjusted according to organizational policy.

---

# 17. Performance

Strategies:

- Separate audit indexes
- Batch writes
- Async logging
- Archive old login records
- Partition audit tables (PostgreSQL)

Audit writes must not noticeably impact user operations.

---

# 18. API Examples

View product audit

```
GET /api/v1/products/{id}/audit
```

View import history

```
GET /api/v1/import-history
```

View export history

```
GET /api/v1/export-history
```

---

# 19. Definition of Done

The audit system is complete when:

- Every critical operation is logged.
- Field-level changes are recorded.
- Import/export operations are traceable.
- Login history is retained.
- Audit records are immutable.
- Audit APIs are available.
- Performance meets system requirements.

---

# Document Information

| Item | Value |
|------|-------|
| Document | 08_Audit_Log_Model.md |
| Version | 1.0 |
| Status | Released |
| Owner | Ocypus Engineering Team |
| Last Updated | 2026-07-23 |
