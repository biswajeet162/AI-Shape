# AI Photo Studio

Monorepo with two separate projects:

```
Shape-2/
├── frontend-flutter/       # Flutter mobile + web client
└── backend-spring-boot/    # Spring Boot API + PostgreSQL
```

| Project | Path | Stack |
|---------|------|--------|
| Frontend | [`frontend-flutter/`](frontend-flutter/) | Flutter, Riverpod, GoRouter, Dio |
| Backend | [`backend-spring-boot/`](backend-spring-boot/) | Java 17+, Spring Boot 3.3, PostgreSQL, Flyway |

## Quick start

### Backend

```bash
cd backend-spring-boot
docker compose up -d
mvn spring-boot:run
# Health: http://localhost:8080/api/v1/health
```

### Frontend

```bash
cd frontend-flutter
flutter pub get
flutter run --dart-define=API_BASE_URL=http://localhost:8080
```

See each project's README for full setup details.
