# AI Photo Studio — Backend (Spring Boot)

Modular monolith API for templates, generations, and storage.

## Stack

- Java 17+ (21 preferred when available)
- Spring Boot 3.3
- PostgreSQL 16
- Flyway
- WebClient (for AI provider in later phases)

## Setup

```bash
cd backend-spring-boot
cp .env.example .env
docker compose up -d
mvn test
mvn spring-boot:run
```

### Health check

```bash
curl http://localhost:8080/api/v1/health
```

### PostgreSQL

Docker Compose maps host port **5433** → container `5432` (avoids clash with local Postgres on 5432).

```
jdbc:postgresql://localhost:5433/ai_photo_studio
user: postgres
password: postgres
```

### Environment

| Variable | Purpose |
|----------|---------|
| `DB_URL` | JDBC URL |
| `DB_USERNAME` / `DB_PASSWORD` | DB credentials |
| `AI_API_KEY` | Image provider key (**never expose to Flutter**) |
| `AI_PROVIDER` | Provider id (default `openai`) |
| `STORAGE_PATH` | Local upload/result folder |
| `SERVER_PORT` | API port (default `8080`) |

## Structure

```
src/main/java/com/aiphotostudio/
├── common/       # health, cors
├── template/     # Phase 2
├── generation/   # Phase 4
└── storage/      # Phase 4
```

Frontend lives in sibling folder: `../frontend-flutter`.
