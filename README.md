# Elf AI – Flutter AI Chat App

Elf AI is a full-stack AI chat application built with **Flutter**, **Serverpod**, and the **Gemini API**.  
It delivers fast, real-time AI conversations using a secure backend architecture.

---

## ✨ Features

- 💬 Real-time AI chat experience  
- ⚡ Fast Serverpod backend processing  
- 🔒 Secure Gemini API integration (keys kept on backend)  
- 🎨 Clean and modern Flutter UI  
- 🧠 Scalable full-stack architecture  

---

## 🏗 Tech Stack

**Frontend**
- Flutter & Dart
- Clean architecture
- Serverpod client networking

**Backend**
- Serverpod (Dart backend)
- REST endpoints
- Async request handling

**AI**
- Google Gemini API

---

## 🔄 Architecture
Flutter App → Serverpod Backend → Gemini API → Response → App

All AI requests go through the backend for security and scalability.

---

## 🚀 Getting Started

### 1. Clone repo
```bash
git clone https://github.com/yourusername/elf-ai.git
```
### 2. Run Serverpod
```bash
cd server
docker compose up --build --detach
dart bin/main.dart
```
### 3. Run Flutter app
```bash
cd flutter_app
flutter pub get
flutter run
```

⭐ Star the repo if you like the project!
