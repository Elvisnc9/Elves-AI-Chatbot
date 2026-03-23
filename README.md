#  Elves — AI Chat Assistant

A beautifully crafted, production-grade AI chat application built with Flutter. Genie delivers a smooth, ChatGPT-like experience with local message persistence, smart connection handling, animated UI, and full conversation management.

---

## ✨ Features

### 💬 Chat
- Real-time AI responses powered by a Serverpod backend
- Typing indicator with smooth breathing animation
- Markdown rendering for rich AI responses
- Animated message reveal (character-by-character typing effect)
- Scroll behaviour — new messages anchor at bottom, older ones slide up naturally

### 🔁 Message Actions
- **Regenerate** — redo the last AI response with one tap
- **Edit & Resend** — long-press any user message to edit inline and resend; all subsequent messages are removed and regenerated from that point
- **Copy** — copy any AI response with animated checkmark feedback
- **Like / Dislike** — frontend feedback buttons on every AI message

### 🌐 Smart Connection Handling
- Shows **"Thinking…"** immediately when a request is sent
- Upgrades to **"Slow connection… still working on it"** after 5 seconds
- Hard timeout at 30 seconds with a soft, friendly error message
- Errors never kill the conversation — user can always retry
- Stop button cancels generation and returns to send state instantly

### 🗂️ Conversation Management
- All conversations persisted locally using **Drift** (SQLite)
- Conversations grouped by time — Today, Yesterday, Previous 7 Days, Previous 30 Days, Older
- Auto-generated conversation titles after the first exchange
- Delete conversations with a confirmation dialog
- Search conversations in the drawer with real-time filtering

### 🎨 UI & Theming
- ChatGPT-style slide-in drawer with full-screen search expansion
- Dark / Light / System theme with smooth animated transitions
- Persistent theme preference saved with SharedPreferences
- Responsive layout using `the_responsive_builder`
- Animated welcome screen with floating prompt chips
- 3D robot model on onboarding screen using `o3d`
- Shader mask fade effects on message list edges

### 🔐 Authentication
- Google Sign-In via Serverpod Auth
- Silent session restore on app start
- Guest mode — full app access without signing in
- Profile display in drawer footer and settings

---

## 🛠️ Tech Stack

| Layer | Technology |
|---|---|
| Framework | Flutter |
| State Management | Riverpod (`StateNotifier`) |
| Backend | Serverpod |
| Local Database | Drift (SQLite) |
| Auth | Serverpod Auth + Google Sign-In |
| Markdown | flutter_markdown |
| Animations | flutter_animate |
| 3D Model | o3d |
| Fonts | Google Fonts (Plus Jakarta Sans) |
| Drawer | Custom overlay (no third-party package) |
| Theme Persistence | SharedPreferences |

---

## 📁 Project Structure

```
lib/
├── app/
│   └── appshell.dart           # Root shell with AnimatedSwitcher between screens
├── core/
│   └── app_errors/
│       ├── error.dart          # AppError types enum
│       └── error_mapper.dart   # Maps exceptions to user-friendly messages
├── data/
│   ├── database/
│   │   ├── chat_database.dart  # Drift database setup + migrations
│   │   ├── chat_dao.dart       # All DB queries (conversations + messages)
│   │   └── *.g.dart            # Drift generated code
│   └── table/
│       ├── conservations_table.dart
│       └── messages_table.dart
├── models/
│   ├── conversation_model.dart
│   └── message_model.dart
├── provider/
│   ├── auth_state.dart         # Auth status + Google sign-in flow
│   ├── chat_database.dart      # Drift DB provider
│   ├── chatState.dart          # Core chat logic, sendMessage, regenerate, editAndResend
│   └── shellView.dart          # Navigation between chat / onboarding / settings
├── screens/
│   ├── chatScreen.dart         # Main chat UI
│   ├── onboarding.dart         # Onboarding + Google sign-in
│   └── settings.dart           # Theme, haptics, profile, sign out
├── shared/
│   └── theme.dart              # AppTheme, AppColors, ThemeController
└── widgets/
    ├── ChatScreen/
    │   ├── chatModels.dart           # Floating prompt chips
    │   ├── chatShimmer.dart          # Shimmer loading for conversation load
    │   ├── DrawerSearchBar.dart      # Search box widget
    │   ├── typingdot_indicator.dart  # Breathing dot animation
    │   └── typingMarkdownanimation.dart # Character-by-character markdown
    ├── elvesDrawer.dart        # ChatGPT-style custom drawer overlay
    ├── flushbar_helper.dart    # Flushbar notification helper
    └── robot.dart              # 3D robot model widget
```

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK `>=3.0.0`
- Dart SDK `>=3.0.0`
- A running [Serverpod](https://serverpod.dev) backend
- Google Sign-In credentials configured in your Serverpod server

### Installation

**1. Clone the repository**
```bash
git clone https://github.com/your-username/genie.git
cd genie/elf_flutter
```

**2. Install dependencies**
```bash
flutter pub get
```

**3. Configure the server URL**

In `lib/main.dart`, update the server URL to point to your Serverpod instance:
```dart
const String serverUrl = 'http://YOUR_SERVER_IP:8080/';
```

**4. Generate Drift code** (if modifying database tables)
```bash
dart run build_runner build --delete-conflicting-outputs
```

**5. Run the app**
```bash
flutter run
```

---

## 🗃️ Database Schema

### Conversations
| Column | Type | Description |
|---|---|---|
| id | TEXT | Unique conversation ID |
| title | TEXT | Auto-generated title |
| createdAt | DATETIME | Creation timestamp |
| lastActiveAt | DATETIME | Last activity timestamp |

### Messages
| Column | Type | Description |
|---|---|---|
| id | TEXT | Unique message ID |
| conversationId | TEXT | Parent conversation |
| role | TEXT | `user` or `assistant` |
| content | TEXT | Message text |
| createdAt | DATETIME | Creation timestamp |

> Schema version: **2** — migration adds `lastActiveAt` column and backfills from `createdAt`.

---

## ⚙️ Connection & Error Handling

| Time | Behaviour |
|---|---|
| 0s | Request sent, "Thinking…" appears above typing dot |
| 5s | Hint upgrades to "Slow connection… still working on it" |
| 30s | Request times out, soft error bubble shown |
| Any error | Conversation preserved, user can retry immediately |

Error messages are plain English with no emoji — clean and non-alarming.

---

## 🔐 Auth Flow

```
App start
  └── Silent session restore (Serverpod Auth)
        ├── Session valid → fetch profile → authenticated state
        └── No session   → guest mode (full app access)

Onboarding
  └── Google Sign-In
        ├── Success → fetch profile → navigate to chat
        └── Cancel  → silent guest fallback
        └── Error   → show error message

Settings
  └── Sign Out → clear session → guest mode
```

---

## 🎨 Theming

Three modes supported — **Light**, **Dark**, **System** — persisted across sessions.

| Token | Dark | Light |
|---|---|---|
| Background | `#100C08` | `#FFFFFF` |
| Accent | `#4A00E0` | `#4A00E0` |
| Primary | `#8E2DE2` | `#8E2DE2` |
| Surface | `Grey.900` | `Grey.100` |

Font: **Plus Jakarta Sans** via Google Fonts across all text styles.

--
## 📱 Screenshots
 

| Onboarding | Chat | Drawer | Settings | Home |
|---|---|---|---|---|
| <img src="elf_flutter/assets/onboarding.jpeg" width="180"/> | <img src="elf_flutter/assets/chat.jpeg" width="180"/> | <img src="elf_flutter/assets/drawer.jpeg" width="180"/> | <img src="elf_flutter/assets/settings.jpeg" width="180"/> | <img src="elf_flutter/assets/ome.jpeg" width="180"/> |
 
---
---

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch — `git checkout -b feature/your-feature`
3. Commit your changes — `git commit -m 'Add your feature'`
4. Push to the branch — `git push origin feature/your-feature`
5. Open a Pull Request

---

## 📄 License

This project is licensed under the MIT License — see the [LICENSE](LICENSE) file for details.

---

## 🙏 Acknowledgements

- [Serverpod](https://serverpod.dev) — Dart backend framework
- [Drift](https://drift.simonbinder.eu) — SQLite ORM for Flutter
- [Riverpod](https://riverpod.dev) — State management
- [flutter_animate](https://pub.dev/packages/flutter_animate) — Animation library
- [flutter_markdown](https://pub.dev/packages/flutter_markdown) — Markdown rendering
