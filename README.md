# Reseller

[README em Português](/README-PTBR.md)

> Flutter application to assist small food producers in managing recipes, ingredients, and cost calculations.

[![Flutter](https://img.shields.io/badge/Flutter-3.10.4+-blue.svg?style=for-the-badge&logo=flutter)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/Dart-3.10.4+-blue.svg?style=for-the-badge&logo=dart)](https://dart.dev/)
[![License](https://img.shields.io/badge/License-MIT-blue.svg?style=for-the-badge)](LICENSE)

## Project Overview
The **Reseller** is a tool developed for small entrepreneurs in the food sector who need to:

* Calculate the production cost of recipes
* Manage ingredients and their costs
* Determine selling prices based on actual costs
* Control the profit margin of each product

## Code of Conduct

This project follows a Code of Conduct.
By participating, you agree to uphold this standard.
See [CODE_OF_CONDUCT.md](.github/CODE_OF_CONDUCT.md).

## Features
### Implemented:
* Ingredient management (full CRUD)
* Recipe management (full CRUD)
* Automatic cost calculation per ingredient unit
* Total cost calculation per recipe
* Dashboard with data summary
* Interface with Material Design and custom palette
* Support for images for recipes
* Data persistence (local database)

### In Development 
* Markup calculation and suggested price
* Recipe scalability (quantity adjustment)
* Fixed and variable costs

## Architecture

The project follows **Clean Architecture** principles with modular organization:

```
lib/
├── main.dart
└── src/
    ├── app/              # Configuration and routing
    ├── core/             # Shared resources (theme, constants)
    ├── modules/          # Features (home, ingredients, recipes)
    │   └── [feature]/
    │       ├── domain/           # Entities and contracts
    │       ├── data/             # Repository implementation
    │       └── presentation/     # UI (pages, widgets, providers)
    └── shared/           # Shared widgets
```

## How to Run

### Prerequisites
- Flutter SDK 3.10.4 or higher
- Dart SDK 3.10.4 or higher
- Android Studio / VS Code (recommended)

### Installation

```bash
# Clone the repository
git clone https://github.com/FelipePaterni/reseller.git

# Enter the directory
cd reseller

# Install dependencies
flutter pub get

# Run the app
flutter run
```

## Main Dependencies

- **provider** ^6.1.5 - State management
- **flutter_form_builder** ^10.2.0 - Form building
- **uuid** ^4.5.2 - Unique ID generation
- **image_picker** ^1.0.7 - Image selection
- **flutter_slidable** ^4.0.3 - Sliding actions in lists
- **lucid_validation**^1.3.1 - Form validation
- **sqflite** ^2.4.2 - Local SQLite database
- **path** ^1.9.1 - File path manipulation
- **flutter_staggered_grid_view** ^0.7.0 - Grid layouts

## Design System

The app uses a warm and welcoming color palette:

- **Background:** #F6EFE7 (soft cream)
- **Primary:** #C78B54 (terracotta)
- **Text:** #6B4A2A (dark brown)

Following an 8px grid and a border radius of 22px for cards.

## Contributing

Contributions are welcome! Please:

1. Fork the project
2. Create a branch for your feature (`git checkout -b feature/MyFeature`)
3. Commit your changes (`git commit -m 'Add MyFeature'`)
4. Push to the branch (`git push origin feature/MyFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.

## Author
**Felipe Paterni**
- GitHub: [@FelipePaterni](https://github.com/FelipePaterni)

---

**Status:** In Development | **Version:** 0.1.0 | **Last Update:** January 2026
