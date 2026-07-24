# Deployment Architecture

**Project:** Ocypus Nexus

**Module:** Production Deployment

**Version:** 1.0

**Status:** Released

---

# 1. Purpose

This document defines the standard deployment architecture for Ocypus Nexus.

The deployment architecture must support:

- Development
- Testing
- Staging
- Production

The system is fully containerized using Docker.

---

# 2. Architecture Overview

```
                 Internet
                     │
               Cloudflare CDN
                     │
                HTTPS (443)
                     │
                 Nginx Proxy
          ┌──────────┼──────────┐
          │          │          │
      React SPA   FastAPI    MinIO
                     │
             ┌───────┴────────┐
             │                │
          PostgreSQL       Redis
```

---

# 3. Technology Stack

| Layer | Technology |
|---------|------------|
| Frontend | React + TypeScript |
| Backend | FastAPI |
| ORM | SQLAlchemy |
| Database | SQLite (Dev) / PostgreSQL (Prod) |
| Cache | Redis |
| Object Storage | MinIO |
| Reverse Proxy | Nginx |
| Container | Docker |
| Orchestration | Docker Compose |
| CI/CD | GitHub Actions |

---

# 4. Environment

## Development

```
React
FastAPI
SQLite
MinIO
Redis
```

Single developer machine.

---

## Testing

```
Docker Compose

↓

SQLite

↓

Mock Email

↓

Redis
```

---

## Staging

```
Nginx

↓

React

↓

FastAPI

↓

PostgreSQL

↓

Redis

↓

MinIO
```

Same topology as Production.

---

## Production

```
Cloudflare

↓

Nginx

↓

FastAPI (Multiple Containers)

↓

Redis

↓

PostgreSQL

↓

MinIO
```

Supports horizontal scaling.

---

# 5. Directory Structure

```
deploy/

├── docker-compose.yml
├── docker-compose.dev.yml
├── docker-compose.prod.yml
├── nginx/
├── postgres/
├── redis/
├── minio/
├── scripts/
└── backup/
```

---

# 6. Docker Services

| Service | Container |
|----------|-----------|
| nginx | Reverse Proxy |
| frontend | React |
| backend | FastAPI |
| postgres | Database |
| redis | Cache |
| minio | Object Storage |

---

# 7. Docker Network

```
frontend

↓

backend

↓

database

↓

redis

↓

minio
```

Internal communication only.

---

# 8. Environment Variables

Example

```
APP_ENV=production

DATABASE_URL=

REDIS_URL=

MINIO_ENDPOINT=

JWT_SECRET=

OPENAI_API_KEY=
```

Environment variables are stored in `.env`.

---

# 9. HTTPS

Recommended

```
Cloudflare

↓

Let's Encrypt

↓

Nginx
```

HTTP automatically redirects to HTTPS.

---

# 10. Storage

SQLite

Development only.

Production

```
PostgreSQL

+

MinIO
```

SQLite is not used in Production.

---

# 11. Redis

Used for

- Cache
- Session
- AI Cache
- Rate Limiting
- Background Queue

---

# 12. Object Storage

Stores

- Images
- Manuals
- Videos
- Excel Templates
- Certificates

Metadata remains in PostgreSQL.

---

# 13. Logging

Application

↓

Structured JSON Logs

↓

File

↓

Log Collector

Recommended:

- Loki
- ELK

---

# 14. Monitoring

Recommended

```
Prometheus

↓

Grafana
```

Metrics

- CPU
- Memory
- API Latency
- Database
- AI Cost

---

# 15. Health Check

Endpoints

```
GET /health

GET /health/database

GET /health/storage

GET /health/cache
```

---

# 16. Backup

Daily

- PostgreSQL
- MinIO
- Configuration

Retention

30 days.

---

# 17. Disaster Recovery

Recovery Steps

1. Restore Database
2. Restore Object Storage
3. Restore Configuration
4. Restart Containers

---

# 18. Scaling

Scale backend only.

```
Nginx

↓

FastAPI x4

↓

PostgreSQL
```

Frontend remains static.

---

# 19. Security

Required

- HTTPS Only
- CSP
- Rate Limiting
- JWT
- Firewall
- Secrets Management

---

# 20. Definition of Done

Deployment is complete when

- Containers start successfully.
- HTTPS is enabled.
- Health checks pass.
- Backup jobs run automatically.
- Monitoring dashboards are available.
- Logs are centralized.
- Object storage is operational.

---

# Document Information

| Item | Value |
|------|-------|
| Document | 01_Deployment_Architecture.md |
| Version | 1.0 |
| Status | Released |
| Owner | Ocypus Engineering Team |
