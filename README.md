# TodoApp 📝

A lightweight, **offline‑first** task manager written in **Flutter** and **Dart 3**. TodoApp lets you create, organise, and receive reminders for your tasks—no matter where you are or whether you have a connection.

&#x20; &#x20;

> **Demo:** *screenshots & GIFs coming soon*

---

## ✨ Features

* **Create / edit / delete tasks** with titles, notes, due dates, and completion flags
* **Local notifications** so you never miss a deadline (uses `flutter_local_notifications` + `timezone`)
* **Offline data‑persistence** via **Hive**—everything works without a network
* **Firebase Auth** (email & password) to back up your data across devices *(optional)*
* **Light & Dark themes** with Material 3 support
* **Internationalisation (i18n)** – English (en) & German (de) out of the box
* **Clean Architecture + BLoC** for predictable state‑management and testability

---

## 🏗️ Tech Stack

| Layer                | Package(s)                                            |
| -------------------- | ----------------------------------------------------- |
| UI & Routing         | Flutter 3 + Material, **Go Router**                   |
| State Management     | **flutter\_bloc**, **equatable**                      |
| Dependency Injection | **GetIt**                                             |
| Local Storage        | **Hive**                                              |
| Remote Services      | **Firebase Auth**, *(Firebase Firestore coming soon)* |
| Notifications        | **flutter\_local\_notifications**, **timezone**       |
| Dev Tools            | **FVM**, **build\_runner**, **flutter\_gen**          |

---

## 📂 Project Structure

```text
lib/
├─ core/            # constants, themes, localisation delegates
├─ global/          # global widgets & helpers (e.g. custom text field)
├─ features/
│  ├─ auth/         # sign‑in / sign‑up / user repo
│  └─ tasks/        # task CRUD, view models, widgets
├─ routes/          # Go Router configuration
└─ injection.dart   # GetIt service locator
```

> The code follows a **feature‑first** layout with *clean layers* (`data/`, `domain/`, `presentation/`).

---

## 🚀 Getting Started

### Prerequisites

* **Flutter 3.x** (install via [FVM](https://fvm.app))
* Dart 3.7+
* A Firebase project (if you want cloud sync)

```bash
# Clone repository
$ git clone https://github.com/your‑org/todo_app.git
$ cd todo_app

# Switch to the pinned Flutter version
$ fvm use

# Install dependencies
$ fvm flutter pub get

# Generate code (freezed, json_serializable, Hive adapters)
$ fvm flutter pub run build_runner build --delete-conflicting-outputs

# Run the app
$ fvm flutter run
```

### Firebase Setup (Optional)

1. `dart pub global activate flutterfire_cli`
2. `flutterfire configure --project=<your‑firebase‑project>`
3. Copy generated `google-services.json` (Android) & `GoogleService-Info.plist` (iOS) into `/android/` & `/ios/` flavour folders.
4. Make sure APIs (Auth) are enabled in the Firebase console.

### Local Notifications

On iOS the first launch will prompt for notification permission. Make sure you accept or enable it in Settings → *TodoApp*.

---

## 🧪 Running Tests

```bash
# Unit & widget tests
$ fvm flutter test

# Analyse & lint
$ fvm flutter analyze
```

---

## 🤖 Continuous Integration

A minimal GitHub Actions workflow (`.github/workflows/flutter.yml`) is included:

```yaml
name: Flutter
on: [push, pull_request]
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.x'
      - run: flutter pub get
      - run: flutter format --set-exit-if-changed .
      - run: flutter analyze --no-fatal-warnings
      - run: flutter test --coverage
```

---

## 🗺️ Roadmap

*

---

## 🤝 Contributing

Contributions are *very* welcome! Please open an issue to discuss your idea first, then fork and create a PR against `main`.

1. Follow the **commit convention** `feat:`, `fix:`, `chore:` …
2. Run `flutter format` and `flutter analyze` before pushing.
3. Add tests where reasonable.

---

## 🪪 License

Distributed under the **MIT License**. See [`LICENSE`](LICENSE) for more information.
