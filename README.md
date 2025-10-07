# Minimal Security CI Demo (Hello-World Web)
Tiny Node.js/Express app with security-minded CI hygiene:
- Reproducible installs (`npm ci` with a lockfile)
- Lint and unit tests (ESLint + Jest)
- **Fail pipeline on high/critical dependency advisories** (`npm audit --audit-level=high`)
- Weekly **Dependabot** updates

> Scope is intentionally small. This repo demonstrates disciplined delivery, not enterprise security coverage.

---
## Status
![CI](https://github.com/oswaldo-reategui/security-ci-demo-hello-web/actions/workflows/ci.yml/badge.svg)


## Quick Start (local, no global installs)
**Prerequisite:** Docker (or Docker Desktop)

```bash
# Build and start the app in a container
docker compose build app
docker compose up -d app

# Verify health endpoint
curl -i http://localhost:3000/health
# Expected: HTTP/1.1 200 OK ... {"status":"ok"}

# Stop containers
docker compose down
