# CleanReport Docker Setup Guide

## Quick Start

### Option 1: Pre-built (Fastest for Production)
```bash
# Build Flutter web locally first
flutter build web --release

# Then build and run with Docker
docker build -t cleanreport:latest -f Dockerfile.prod .
docker run -p 8080:80 cleanreport:latest
```

Visit http://localhost:8080

### Option 2: Full Build in Docker
```bash
# Build inside Docker (first run takes ~5-10 minutes)
docker build -t cleanreport:latest -f Dockerfile .
docker run -p 8080:80 cleanreport:latest
```

### Option 3: Development with Docker Compose
```bash
# Dev server with hot-reload capability
docker compose --profile dev up dev-server
```

Visit http://localhost:8082

## Docker Compose Profiles

- **Default** (no profile): Runs production-ready app (requires `build/web` artifacts)
  ```bash
  docker compose up app
  ```

- **build**: Full build inside container
  ```bash
  docker compose --profile build up app-build
  ```

- **dev**: Development server
  ```bash
  docker compose --profile dev up dev-server
  ```

## Files

- **Dockerfile** — Multi-stage build (compile + serve)
- **Dockerfile.prod** — Minimal production (serve only, requires pre-built artifacts)
- **Dockerfile.dev** — Development with Flutter web server
- **nginx.conf** — Production web server config (gzip, caching, SPA routing)
- **docker-compose.yml** — Orchestration with profiles

## Performance Notes

- First build (with `Dockerfile`): ~10 min (downloads Flutter, builds web)
- Cached builds: ~1 min
- Production (`Dockerfile.prod`): <1 sec (serves static assets only)
- Dev server (`Dockerfile.dev`): ~3 min (first run), then live reload

## Port Mappings

- 8080 → Production app
- 8081 → App from full build profile
- 8082 → Dev server

## Cleanup

```bash
docker compose down
docker image rm cleanreport:latest
```
