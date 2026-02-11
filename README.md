# 📝 Note App

A smart Flutter note-taking application that helps you organize your daily and weekly tasks with automatic location tracking.

## ✨ Features

- ✅ **Create Notes** - Add new notes quickly and easily
- ✏️ **Update Notes** - Edit existing notes anytime
- 🗑️ **Delete Notes** - Remove notes you no longer need
- 📍 **Location Tracking** - Automatically save the location where each note was created
- 💾 **Local Storage** - All notes stored securely on your device using SQLite
- 🎯 **Task Organization** - Keep track of your daily and weekly tasks
- 📱 **Shake to Action** - Shake your device for quick actions

## 🛠️ Technologies Used

- **Flutter** - UI framework
- **GetX** - State management and navigation
- **Floor** - SQLite database wrapper for Flutter
- **Geolocator** - Location services
- **Permission Handler** - Managing device permissions
- **Shake** - Shake detection functionality
- **SQLite** - Local database storage

## 📋 Prerequisites

Before you begin, ensure you have the following installed:

- Flutter SDK (3.9.2 or higher)
- Dart SDK (3.9.2 or higher)
- Android Studio / VS Code
- Git

## 🚀 Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/yourusername/note_app.git
cd note_app
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Generate Floor Database Files

```bash
flutter packages pub run build_runner build
```

### 4. Run the App

```bash
# For debug mode
flutter run

# For release mode
flutter run --release
```

## 🏗️ Build APK

```bash
# Debug APK
flutter build apk --debug

# Release APK
flutter build apk --release

# Split APK by ABI (smaller file sizes)
flutter build apk --split-per-abi
```

## 📱 Permissions

The app requires the following permissions:

- **Location** - To save the location where notes are created
- **Storage** - To store notes locally

These permissions are handled automatically using the `permission_handler` package.

## 🗂️ Project Structure

```
lib/
├── main.dart                 # App entry point
├── models/                   # Data models
├── database/                 # Floor database setup
├── controllers/              # GetX controllers
├── views/                    # UI screens
└── utils/                    # Helper functions
```

## 📦 Dependencies

### Main Dependencies
- `get: ^4.7.3` - State management and routing
- `floor: ^1.5.0` - SQLite database ORM
- `geolocator: ^14.0.2` - Location services
- `permission_handler: ^12.0.1` - Permission management
- `sqflite: ^2.4.2` - SQLite plugin
- `shake: ^3.0.0` - Shake detection
- `dartx: ^1.2.0` - Dart extensions

### Dev Dependencies
- `floor_generator: ^1.4.2` - Code generation for Floor
- `build_runner: ^2.4.6` - Build system
- `flutter_lints: ^5.0.0` - Linting rules

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

## 👨‍💻 Author

**Your Name**
- GitHub: [@yourusername](https://github.com/yourusername)

## 🙏 Acknowledgments

- Thanks to the Flutter team for the amazing framework
- GetX community for the excellent state management solution
- All contributors who helped improve this project

---

Made with ❤️ using Flutter
