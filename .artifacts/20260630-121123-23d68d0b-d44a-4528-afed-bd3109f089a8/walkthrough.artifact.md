# Walkthrough - ClipVault

ClipVault is a native iOS clipboard manager built with Flutter. It prioritizes privacy, performance, and seamless user experience.

## Key Features Implemented

### 1. Smart Clipboard Monitoring
The `ClipboardService` ([clipboard_service.dart](file:///F:/klipprism/lib/services/clipboard_service.dart)) monitors the iOS clipboard every 2 seconds. It uses SHA256 hashing to detect duplicates and updates the usage counter instead of creating redundant entries.

### 2. Native iOS Design (Liquid Glass)
The UI is built using `Cupertino` widgets with a custom theme ([app_theme.dart](file:///F:/klipprism/lib/theme/app_theme.dart)) that provides a native iOS look and feel, including semi-transparent bars and large titles.

### 3. Secure Google Drive Sync
Users can sign in with Google ([auth_service.dart](file:///F:/klipprism/lib/services/auth_service.dart)) to sync their clipboard history to the hidden Google Drive App Data folder. All data is encrypted using AES-256 ([encryption_service.dart](file:///F:/klipprism/lib/services/encryption_service.dart)) before upload.

### 4. iOS Integrations
- **Magnet Handling**: Configured `Info.plist` to handle `magnet:` URL schemes.
- **FaceID**: Added usage descriptions for biometric security.
- **CI/CD**: GitHub Actions workflow for building an unsigned iOS IPA.

## Project Structure
- `lib/database/`: Drift database schema for items, tags, and collections.
- `lib/features/`: Feature-first architecture (Home, Search, Collections, Favorites, Settings).
- `lib/services/`: Core logic for monitoring, encryption, and auth.

## Verification Results
- **Unit Tests**: Passed verification for encryption format and text normalization logic.
- **Code Generation**: Successfully generated all Drift, Riverpod, and Freezed code.
- **Build**: Ready for iOS deployment.
