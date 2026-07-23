# RBAC Data Model

**Project:** Ocypus Nexus

**Document Version:** 1.0

**Status:** Released

---

# 1. Purpose

This document defines the Role-Based Access Control (RBAC) model used by Ocypus Nexus.

The RBAC system controls:

- User Authentication
- Authorization
- Menu Visibility
- API Access
- Button Permissions
- Data Permissions
- Excel Import
- Excel Export
- Audit Operations

Every request must pass RBAC authorization before accessing business resources.

---

# 2. Design Principles

The RBAC implementation follows:

- Least Privilege
- Role-Based Authorization
- Permission Reuse
- Data Isolation
- Multi-role Support
- Expandable Permission Tree

---

# 3. Permission Architecture

```
User

↓

Role

↓

Permission

↓

API / UI / Data
```

One user may belong to multiple roles.

Permissions are granted to roles, never directly to users.

---

# 4. Entity Relationship

```
User
 │
 ├──────────────┐
 ▼              ▼
UserRole     LoginLog
 │
 ▼
Role
 │
 ▼
RolePermission
 │
 ▼
Permission
```

---

# 5. Core Tables

```
user

role

permission

user_role

role_permission

login_log

refresh_token
```

---

# 6. User

Purpose

Stores system users.

Columns

| Column | Type |
|----------|------|
| id | UUID |
| username | VARCHAR(50) |
| email | VARCHAR(150) |
| password_hash | TEXT |
| display_name | VARCHAR(100) |
| avatar | TEXT |
| is_active | BOOLEAN |
| last_login_at | DATETIME |

Indexes

```
UK_USER_USERNAME

UK_USER_EMAIL

IDX_USER_ACTIVE
```

---

# 7. Role

Purpose

Defines reusable permission groups.

Examples

```
System Administrator

Product Manager

Engineer

Sales

Marketing

Viewer
```

Columns

| Column | Type |
|----------|------|
| id | UUID |
| code | VARCHAR(50) |
| name | VARCHAR(100) |
| description | TEXT |
| is_system | BOOLEAN |

Indexes

```
UK_ROLE_CODE

IDX_ROLE_NAME
```

---

# 8. Permission

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

excel:import

excel:export

metadata:update

user:manage
```

Columns

| Column | Type |
|----------|------|
| id | UUID |
| module | VARCHAR(50) |
| action | VARCHAR(50) |
| code | VARCHAR(100) |
| display_name | VARCHAR(100) |

Unique

```
UK_PERMISSION_CODE
```

---

# 9. User Role

Many-to-Many relationship.

```
User

↓

UserRole

↓

Role
```

Columns

| Column | Type |
|----------|------|
| id | UUID |
| user_id | UUID |
| role_id | UUID |

Composite Unique

```
(user_id, role_id)
```

---

# 10. Role Permission

Many-to-Many relationship.

```
Role

↓

RolePermission

↓

Permission
```

Columns

| Column | Type |
|----------|------|
| id | UUID |
| role_id | UUID |
| permission_id | UUID |

Composite Unique

```
(role_id, permission_id)
```

---

# 11. Login Log

Purpose

Stores login history.

Columns

| Column | Type |
|----------|------|
| id | UUID |
| user_id | UUID |
| login_time | DATETIME |
| ip_address | VARCHAR(50) |
| device | VARCHAR(200) |
| browser | VARCHAR(100) |
| os | VARCHAR(100) |
| success | BOOLEAN |

Indexes

```
IDX_LOGIN_USER

IDX_LOGIN_TIME
```

---

# 12. Refresh Token

Purpose

Stores refresh tokens.

Columns

| Column | Type |
|----------|------|
| id | UUID |
| user_id | UUID |
| token | TEXT |
| expires_at | DATETIME |
| revoked | BOOLEAN |

---

# 13. Built-in Roles

The system initializes the following roles:

| Role | Description |
|------|-------------|
| SUPER_ADMIN | Full system access |
| ADMIN | Administrative operations |
| PRODUCT_MANAGER | Product management |
| ENGINEER | Product editing |
| MARKETING | Marketing content management |
| VIEWER | Read-only access |

---

# 14. Default Permission Matrix

| Module | Viewer | Engineer | Product Manager | Admin |
|---------|:------:|:--------:|:---------------:|:-----:|
| View Product | ✓ | ✓ | ✓ | ✓ |
| Create Product | ✗ | ✓ | ✓ | ✓ |
| Edit Product | ✗ | ✓ | ✓ | ✓ |
| Delete Product | ✗ | ✗ | ✓ | ✓ |
| Export Excel | ✓ | ✓ | ✓ | ✓ |
| Import Excel | ✗ | ✓ | ✓ | ✓ |
| Manage Metadata | ✗ | ✗ | ✓ | ✓ |
| User Management | ✗ | ✗ | ✗ | ✓ |
| System Settings | ✗ | ✗ | ✗ | ✓ |

---

# 15. Data-Level Permissions

Future support:

- Department-based access
- Product-category access
- Region-based access
- Series-based access

Example

```
Engineer A

↓

Can edit

↓

Case

Liquid Cooler

↓

Cannot edit

↓

Power Supply
```

---

# 16. Frontend Permission Control

Permissions control:

- Menu visibility
- Button visibility
- Page routing
- Component rendering

Example

```
product:update

↓

Show Edit Button
```

---

# 17. API Authorization

Each API endpoint declares required permissions.

Example

```
GET /api/v1/products

↓

product:view
```

```
POST /api/v1/products

↓

product:create
```

Requests without permission return:

```
403 Forbidden
```

---

# 18. Audit Integration

Permission changes are audited.

Tracked operations:

- User created
- User disabled
- Role created
- Role updated
- Permission assigned
- Permission revoked

All records are written to `audit_log`.

---

# 19. Security Best Practices

- Passwords stored using Argon2id
- JWT Access Token
- Refresh Token Rotation
- MFA-ready architecture
- Account lock after repeated failures
- Configurable session timeout

---

# 20. Definition of Done

The RBAC model is complete when:

- Users can have multiple roles.
- Roles can contain multiple permissions.
- APIs enforce permission checks.
- UI components respect permissions.
- Login history is recorded.
- Permission changes are audited.
- Default roles are initialized.
- Future data-level permissions are supported.

---

# Document Information

| Item | Value |
|------|-------|
| Document | 07_RBAC_Data_Model.md |
| Version | 1.0 |
| Status | Released |
| Owner | Ocypus Engineering Team |
| Last Updated | 2026-07-23 |
