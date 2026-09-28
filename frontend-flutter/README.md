# AI Photo Studio — Frontend (Flutter)

Consumer AI photo transformation client.

## Stack

- Flutter 3.x
- Riverpod
- GoRouter
- Dio
- Material 3 design system

## Setup

```bash
cd frontend-flutter
flutter pub get
flutter analyze
flutter test
flutter run
```

### API base URL

```bash
flutter run --dart-define=API_BASE_URL=http://localhost:8080

# Android emulator
flutter run --dart-define=API_BASE_URL=http://10.0.2.2:8080
```

### Build

```bash
flutter build apk
flutter build web
# macOS + Xcode:
flutter build ios
```

## Structure

```
lib/
├── core/           # theme, routing, network, widgets
└── features/       # home, explore, templates, history, …
```

Product name is configurable in `lib/core/constants/app_constants.dart`.

Backend lives in sibling folder: `../backend-spring-boot`.
