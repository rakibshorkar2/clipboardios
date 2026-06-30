# ClipVault

ClipVault is a production-quality clipboard manager for iOS, designed with native iOS design (Liquid Glass), excellent performance, and privacy.

## Features

- **Smart Clipboard Monitoring**: Automatically detects and stores clipboard changes.
- **Duplicate Detection**: Uses SHA256 hashing to prevent duplicate entries and updates usage counters.
- **Smart Classification**: Automatically categorizes content into Text, URLs, Emails, Phone Numbers, Magnet links, and more.
- **Magnet Link Support**: Register as a handler for `magnet:` URLs.
- **Secure Cloud Sync**: Encrypted backups stored in the user's Google Drive (App Data folder).
- **Encryption**: AES-256 encryption for all synced data.
- **Biometric Lock**: Optional FaceID/Passcode protection.
- **Native iOS UI**: Built using Cupertino widgets for a native look and feel.

## Tech Stack

- **Flutter**: Cross-platform framework.
- **Riverpod**: State management.
- **Drift (SQLite)**: Local database.
- **Freezed**: Data modeling.
- **GoRouter**: Navigation.
- **Google Sign-In & Google APIs**: Cloud synchronization.
- **Encrypt**: AES encryption.

## Setup Instructions

1.  **Clone the repository**:
    ```bash
    git clone https://github.com/your-repo/clipvault.git
    cd clipvault
    ```

2.  **Install dependencies**:
    ```bash
    flutter pub get
    ```

3.  **Run Code Generation**:
    ```bash
    dart run build_runner build --delete-conflicting-outputs
    ```

4.  **Google Cloud Configuration**:
    - Create a project in [Google Cloud Console](https://console.cloud.google.com/).
    - Enable **Google Drive API**.
    - Configure the **OAuth Consent Screen**.
    - Create **iOS OAuth Client IDs** and add the reversed client ID to `ios/Runner/Info.plist`.

5.  **Run the app**:
    ```bash
    flutter run
    ```

## CI/CD

A GitHub Actions workflow is included in `.github/workflows/ios_build.yml` to build an unsigned iOS IPA on every push to the `main` branch.

## Project Structure

```
lib/
├── core/         # Common utilities and constants
├── database/     # Drift database definition
├── features/     # Feature-first modules (Home, Search, etc.)
├── models/       # Freezed data models
├── services/     # External services (Auth, Clipboard, Encryption)
├── theme/        # Cupertino Liquid Glass theme
└── main.dart     # Entry point
```
