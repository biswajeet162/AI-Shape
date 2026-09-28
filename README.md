# AI Photo Studio

Modern consumer AI photo transformation app — Flutter client + Spring Boot API.

**MVP focus:** beautiful UI, simple flow, working generation (generation lands in Phase 4).

Flow: **Home → Template → Photo → Generate → Result**

---

## Architecture

```
Shape-2/
├── lib/                    # Flutter app (feature-based)
│   ├── core/               # theme, routing, network, widgets
│   └── features/           # home, explore, templates, history, …
├── backend/                # Spring Boot modular monolith
│   └── src/main/java/com/aiphotostudio/
│       ├── common/         # health, cors (Phase 1)
│       ├── template/       # Phase 2
│       ├── generation/     # Phase 4
│       └── storage/        # Phase 4
├── docker-compose.yml      # PostgreSQL
└── .env.example
```

| Layer | Stack |
|-------|--------|
| Mobile / Web | Flutter 3.x, Riverpod, GoRouter, Dio, Material 3 |
| API | Java 17+ (21 preferred), Spring Boot 3.3, Web, JPA, Flyway, WebClient |
| DB | PostgreSQL 16 |

---

## Prerequisites

- Flutter SDK 3.24+
- JDK **17 or 21**
- Maven 3.9+
- Docker Desktop
- (Optional) Android Studio / Xcode for device builds

> This environment currently uses **Java 17**. Spring Boot 3.3 runs on 17+. Install JDK 21 later if you want to match the long-term target.

---

## Environment variables

Copy the example file:

```bash
cp .env.example .env
cp backend/.env.example backend/.env
```

| Variable | Purpose |
|----------|---------|
| `DB_URL` | JDBC URL for PostgreSQL |
| `DB_USERNAME` / `DB_PASSWORD` | DB credentials |
| `AI_API_KEY` | Image provider key (**backend only — never in Flutter**) |
| `AI_PROVIDER` | Provider id (default `openai`) |
| `STORAGE_PATH` | Local upload/result folder |
| `SERVER_PORT` | API port (default `8080`) |

Flutter API base URL (build-time):

```bash
flutter run --dart-define=API_BASE_URL=http://localhost:8080
# Android emulator:
flutter run --dart-define=API_BASE_URL=http://10.0.2.2:8080
```

---

## PostgreSQL

```bash
docker compose up -d
docker compose ps
```

Default DB: `ai_photo_studio` / user `postgres` / password `postgres` on host port **`5433`** (mapped to container `5432` to avoid clashing with a local Postgres on `5432`).

JDBC URL:

```
jdbc:postgresql://localhost:5433/ai_photo_studio
```

Stop:

```bash
docker compose down
```

---

## Backend (Spring Boot)

```bash
cd backend
mvn test
mvn spring-boot:run
```

Health check:

```bash
curl http://localhost:8080/api/v1/health
```

Expected:

```json
{"status":"UP","service":"ai-photo-studio-backend","timestamp":"..."}
```

### Configure AI provider (Phase 4)

1. Set `AI_API_KEY` in `backend/.env` or your shell.
2. Keep the key **only** on the server.
3. Flutter never receives or stores provider credentials.

---

## Flutter

```bash
flutter pub get
flutter analyze
flutter test
flutter run
```

### Android APK

```bash
flutter build apk
```

### iOS (macOS + Xcode)

```bash
flutter build ios
```

### Web

```bash
flutter run -d chrome
# or
flutter build web
```

Web layout uses a centered max width of **1200px**.

---

## Phase 1 status

Completed:

- Flutter project + feature folders
- Design system (`AppColors`, `AppTypography`, `AppSpacing`, `AppRadius`, `AppTheme`)
- GoRouter + Riverpod + bottom nav (Home / Explore / History)
- Dio API client
- Polished Home / Explore / History UI (placeholder template visuals)
- Spring Boot app + `/api/v1/health`
- Flyway schema foundation (`categories`, `templates`, `generations`)
- Docker Compose PostgreSQL
- `.env.example` + README

Not in Phase 1 (by design):

- Template REST API + seed data
- Camera / gallery / generation
- Auth, payments, LangChain, admin

---

## Design notes

- Visual-first, Instagram/Pinterest-style browsing
- Neutral off-white base + single teal accent
- Inter via `google_fonts`
- Configurable product name: `lib/core/constants/app_constants.dart`
