# Contributing to Reseller

Thank you for your interest in contributing to **Reseller**! 🎉

This document provides guidelines and rules to ensure all contributions follow the project's standards.

## 📋 Table of Contents

- [Code of Conduct](#code-of-conduct)
- [How Can I Contribute?](#how-can-i-contribute)
- [Environment Setup](#environment-setup)
- [Development Guidelines](#development-guidelines)
- [Code Standards](#code-standards)
- [Submission Process](#submission-process)
- [Testing](#testing)
- [Reporting Bugs](#reporting-bugs)
- [Suggesting Enhancements](#suggesting-enhancements)

## 📜 Code of Conduct

This project follows a [Code of Conduct](CODE_OF_CONDUCT.md). By participating, you agree to uphold this standard.

## 🤝 How Can I Contribute?

There are several ways to contribute:

- 🐛 Report bugs
- 💡 Suggest new features
- 📝 Improve documentation
- 🔧 Fix existing bugs
- ✨ Implement new features
- 🎨 Improve design and UX

## 🛠️ Environment Setup

### Prerequisites

- Flutter SDK 3.10.4 or higher
- Dart SDK 3.10.4 or higher
- Android Studio / VS Code with Flutter extensions
- Git

### Installation

1. **Fork the repository**
   
   Click the "Fork" button at the top of the GitHub page.

2. **Clone your fork**

   ```bash
   git clone https://github.com/FelipePaterni/reseller.git
   cd reseller
   ```

3. **Add the upstream repository**

   ```bash
   git remote add upstream https://github.com/FelipePaterni/reseller.git
   ```

4. **Install dependencies**

   ```bash
   flutter pub get
   ```

5. **Verify installation**

   ```bash
   flutter doctor
   flutter analyze
   flutter test
   ```

## 📐 Development Guidelines

### Project Context

- **Stack**: Flutter/Dart with null-safety
- **Target**: Mobile (primary), Web (secondary)
- **Domain**: Recipe, cost, and ingredient management for small businesses
- **Material Design**: Material 2 (Material 3 not required)

### Color Palette

The project uses a warm and welcoming palette:

- **Background**: `#F6EFE7`
- **Primary Text**: `#6B4A2A`
- **Accent**: `#C78B54`

All colors must be centralized in `AppColors` ([lib/src/core/theme/app_colors.dart](../lib/src/core/theme/app_colors.dart)). **Do not use hardcoded color values**.

### Architecture & State

- **State Management**: 
  - Prefer `setState` for isolated screens
  - Use Provider/Riverpod only when state needs to be shared across multiple pages
  
- **Widgets**:
  - Keep widgets small and composable
  - Extract reusable widgets to `lib/src/shared/widgets` or `lib/widgets`
  
- **Data Flow**: 
  - Presentation → Services → Data Sources
  - Avoid business logic inside widgets

### Folder Structure

```
lib/
├── main.dart
└── src/
    ├── app/              # Configuration and routing
    ├── core/             # Shared resources (theme, constants)
    ├── modules/          # Application modules
    │   └── [module]/
    │       ├── data/
    │       ├── domain/
    │       └── presentation/
    └── shared/           # Shared widgets and utilities
```

## 🎨 Code Standards

### Code Style

- Follow `flutter_lints`
- Run `flutter format` / `dart format` on all modified files
- **Naming Conventions**:
  - Classes/Widgets: `UpperCamelCase`
  - Methods/fields: `lowerCamelCase`
  - Constants: `lowerCamelCase` with `const` whenever possible

### Imports

- Package imports before relative imports
- Remove unused imports
- Prefer `const` constructors whenever possible

Example:
```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_constants.dart';
import '../widgets/custom_card.dart';
```

### UI/UX

- **Spacing**: 8px base grid
- **Cards**: Border radius ~22
- **Shadows**: Subtle (blur 18-24, low opacity)
- **Typography**: 
  - Use theme defaults
  - Bold for headlines
  - Medium for body
  - Avoid custom fonts (unless specified)
  
- **Accessibility**:
  - Tappable areas >= 44x44
  - Provide semantics/labels for icons
  - Maintain adequate contrast with warm palette

- **States**:
  - Always consider loading/empty/error for data-driven sections
  - Use placeholders instead of blank screens

### Assets & Resources

- Centralize colors in `AppColors`
- Icons: prefer Material Icons
- New assets: place in `assets/` and register in `pubspec.yaml`

### Networking & Data

- Keep async calls cancel-safe
- Avoid unawaited futures (document if intentional)
- **Error Handling**:
  - User-friendly messages for users
  - Technical logs only in debug mode

### Performance

- Use `const` widgets whenever possible
- Avoid unnecessary rebuilds (use keys, selectors)
- Lazy loading for heavy images/assets

## 🔄 Submission Process

### Before Starting

1. Check if there isn't already a related issue/PR
2. Create or comment on the related issue
3. Wait for approval for large features

### Git Workflow

1. **Update your fork**

   ```bash
   git checkout main
   git fetch upstream
   git merge upstream/main
   ```

2. **Create a branch**

   Use descriptive names:
   - `feature/feature-name`
   - `fix/bug-description`
   - `doc/doc-description`
   - `refactor/description`

   ```bash
   git checkout -b feature/new-functionality
   ```

3. **Make meaningful commits**

   - Small and focused commits
   - Clear and descriptive messages
   - Use conventional commits (optional but recommended)

   Examples:
   ```
   feat: add profit margin calculation
   fix: correct price formatting on recipe screen
   docs: update README with installation instructions
   refactor: extract table widget to separate file
   test: add tests for IngredientService
   ```

4. **Keep changes focused**

   - Avoid unrelated refactoring
   - One PR = one feature/fix
   - Don't include mass formatting changes

5. **Push and create Pull Request**

   ```bash
   git push origin feature/new-functionality
   ```

   On GitHub:
   - Clear and descriptive title
   - Detailed description of changes
   - Reference related issues (#123)
   - Screenshots if there are visual changes

### Pull Request Template

```markdown
## Description
[Describe the changes made]

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Breaking change
- [ ] Documentation

## Related Issue
Closes #[number]

## How to Test
1. [Step 1]
2. [Step 2]
3. [Expected result]

## Screenshots (if applicable)
[Add screenshots]

## Checklist
- [ ] Code follows the project's style guide
- [ ] Ran `flutter analyze` without errors
- [ ] Ran `flutter format` on modified files
- [ ] Added/updated tests
- [ ] All tests pass (`flutter test`)
- [ ] Updated documentation (if necessary)
```

## 🧪 Testing

### Minimum Requirements

- **Widget tests** for new screens/components
- **Unit tests** for pure logic

### Running Tests

```bash
# All tests
flutter test

# Static analysis
flutter analyze

# Formatting
flutter format lib test
```

### Quality Assurance

Before submitting PR, ensure:
- ✅ `flutter analyze` passes without errors
- ✅ `flutter test` passes without failures
- ✅ Code is formatted (`flutter format`)

## 🐛 Reporting Bugs

### Before Reporting

1. Check if the bug hasn't already been reported
2. Try to reproduce on a clean version
3. Collect environment information

### Bug Report Template

```markdown
**Bug Description**
[Clear description of the problem]

**How to Reproduce**
1. [Step 1]
2. [Step 2]
3. [Incorrect result]

**Expected Behavior**
[What should happen]

**Screenshots**
[If applicable]

**Environment**
- Flutter version: [e.g.: 3.10.4]
- Dart version: [e.g.: 3.10.4]
- OS: [e.g.: Windows 11, Android 13]
- Device: [e.g.: Pixel 6, Emulator]

**Additional Information**
[Any other relevant context]
```

## 💡 Suggesting Enhancements

### Feature Request Template

```markdown
**Problem/Need**
[Describe the problem the feature would solve]

**Proposed Solution**
[Describe your ideal solution]

**Alternatives Considered**
[Other approaches you thought about]

**Additional Context**
[Screenshots, mockups, examples]
```

## 📝 Code Review

When reviewing PRs, prioritize:

1. ✅ Risky or complex logic
2. ✅ Missing states (loading, empty, error)
3. ✅ Test gaps
4. ✅ Architecture violations
5. ⚠️ Performance issues
6. ℹ️ Style improvements (suggestions, not blocking)

## 🙋 Need Help?

- Open an issue with the `question` tag
- Comment on existing issues
- Review the [documentation](../README.md)

## 📄 License

By contributing, you agree that your contributions will be licensed under the same [MIT license](../LICENSE) as the project.

---

**Thank you for contributing to Reseller! 🚀**