

## Role

You are a senior Flutter, iOS, UX, security, and cloud architect.

Create a production-quality Flutter application called **ClipVault**.

The primary goal is to create the **best clipboard manager for iPhone**, designed specifically for iOS 26+, with native iOS design, excellent performance, privacy, and seamless cloud synchronization.

The app will run on my **iPhone 15 Pro (iOS 26.x)**.

The project must be fully compatible with Flutter stable.

The UI should follow Apple's latest Human Interface Guidelines with Liquid Glass aesthetics, native animations, blur materials, smooth transitions, large titles, SF Symbols, adaptive typography, haptics, and accessibility.

The codebase must be clean, modular, scalable, and heavily documented.

---

# Main Purpose

The app automatically stores everything important copied to the clipboard while also allowing manual saving.

Supported types:

* Plain text
* Rich text
* URLs
* Photos
* Images
* Magnet links
* Torrent URLs
* Phone numbers
* Email addresses
* OTP codes
* Addresses
* Code snippets
* JSON
* Markdown
* QR content

Everything should be searchable instantly.

---

# Core Features

## Smart Clipboard Monitoring

Continuously monitor clipboard.

Detect changes only.

Never save duplicate content.

Ignore identical clipboard entries.

Detect copied item type automatically.

---

## Duplicate Detection

Never create duplicates.

Use:

* SHA256 hashing
* Normalized text comparison
* Ignore whitespace differences
* Ignore line ending differences
* Ignore capitalization (optional)

If duplicate:

Increase usage counter instead of creating another entry.

Store:

* First copied
* Last copied
* Copy count

---

## Clipboard Categories

Automatically classify into:

* Text
* Links
* Images
* Photos
* Magnet
* Torrent
* Email
* Phone
* OTP
* Address
* Password
* Code
* JSON
* Markdown
* Notes

---

## Smart Detection

Automatically detect:

URLs

Emails

Phone numbers

Coordinates

OTP codes

Bank account numbers

Bitcoin addresses

Magnet links

Torrent links

Code snippets

Markdown

JSON

SQL

---

# Magnet Link Support

Very important.

When tapping a Magnet link in Safari or any browser:

```
magnet:?xt=...
```

iOS should show

Open in ClipVault?

The app should:

Receive the magnet URI

Save it

Display metadata

Allow:

Copy

Share

Open with torrent apps

Favorite

Tag

Notes

Recent

---

Support Universal Links if possible.

Register:

```
magnet:
```

scheme in Info.plist.

---

# Share Extension

Implement iOS Share Extension.

User can share from:

Safari

Photos

Files

Chrome

Firefox

Edge

Any app

Receive:

Text

Images

URLs

Magnet links

PDF

Files

Videos

Everything should be saved.

---

# Drag & Drop Support

Support iPad drag/drop.

---

# Photos

Store:

Original image

Thumbnail

Metadata

Dimensions

File size

Date

Camera info if available.

Preview with zoom.

---

# Rich Link Preview

For links:

Generate preview:

Website icon

Title

Description

Image

Domain

---

# OCR

Images containing text should optionally perform OCR.

Extract text.

Search OCR text.

---

# Favorites

Star important clips.

---

# Pin

Pinned items always remain at top.

---

# Notes

Each clipboard item supports notes.

---

# Tags

Unlimited tags.

Auto suggestions.

Tag colors.

---

# Collections

Folders.

Nested folders.

Examples:

Work

Personal

Passwords

Shopping

Development

Travel

Recipes

---

# Powerful Search

Instant search.

Support:

Content

Tags

Notes

OCR

Metadata

Domains

Date

Favorites

Pinned

Type

Regex

---

# Filters

Today

Yesterday

This week

This month

Favorites

Images

Links

Text

Magnet

Recently copied

Most copied

---

# Smart Actions

Depending on content:

Phone → Call

Email → Email

URL → Open

Magnet → Torrent

Address → Maps

OTP → Copy

Image → Save

---

# Clipboard History

Timeline.

Infinite scrolling.

Grouped by:

Today

Yesterday

Older

---

# Recent

Recently viewed.

---

# Statistics

Show:

Total saved

Most copied

Favorites

Storage used

Most common type

Most active day

Longest streak

---

# Backup

Cloud backup.

Automatic.

Manual.

Incremental.

---

# Gmail Cloud Sync

Instead of Firebase.

Use Google Sign-In.

Authenticate using Google OAuth.

Store encrypted backups in the user's Google account (preferably in app-specific storage such as Google Drive App Data rather than Gmail messages).

Requirements:

Automatic sync

Manual sync

Conflict resolution

Incremental upload

Restore on new phone

Sync settings

Sync tags

Sync favorites

Sync notes

Sync folders

Sync thumbnails

Sync metadata

Encryption before upload.

No server.

Everything works peer-to-peer with Google services only.

---

# Encryption

AES-256 encryption.

Secure storage of keys.

Use iOS Keychain.

Encrypted backups.

---

# Database

SQLite.

Use Drift.

Repository pattern.

Indexes.

Migrations.

---

# Offline First

Everything works offline.

Cloud only syncs when available.

---

# Import

Import from:

CSV

JSON

TXT

Previous backup

---

# Export

Export:

CSV

JSON

TXT

Markdown

ZIP backup

---

# Widgets

Home Screen widget.

Show:

Recent clip

Pinned

Favorite

Quick save

---

# Live Activities

Support iOS Live Activities where meaningful.

---

# Notifications

Optional reminders.

Example:

Clipboard not backed up.

---

# Quick Actions

Long press app icon:

New note

Recent clipboard

Favorites

Search

---

# Spotlight Search

Index clipboard.

Search directly from iOS.

---

# Siri Shortcuts

Create shortcut:

Save clipboard

Open favorites

Search clipboard

---

# Lock

Face ID.

Touch ID.

Passcode.

Auto lock.

---

# Privacy

Hidden mode.

Blur screenshots.

Exclude from backups if desired.

Private folders.

---

# Trash

Deleted items remain for:

7 days

30 days

Forever

---

# Settings

Theme

Accent

Font size

Clipboard monitor

Cloud sync

Auto backup

Export

Import

Lock

Notifications

Storage

Cache

---

# UI

Liquid Glass.

Native Cupertino.

Large titles.

Smooth animations.

Context menus.

Swipe actions.

Bottom navigation.

Haptics.

Dark mode.

Light mode.

Dynamic colors.

Dynamic Type.

Accessibility.

---

# Bottom Navigation

Home

Search

Collections

Favorites

Settings

---

# Home

Recent clipboard timeline.

---

# Search

Powerful filtering.

---

# Collections

Folders.

Tags.

Pinned.

---

# Favorites

Only favorites.

---

# Settings

Everything configurable.

---

# Architecture

Feature-first architecture.

```
lib/

core/

features/

services/

repositories/

database/

models/

widgets/

theme/

extensions/

```

Use:

Riverpod

Drift

Freezed

GoRouter

Flutter Secure Storage

Google Sign-In

Google Drive API (App Data folder)

Receive Sharing Intent

Home Widget

Local Authentication

Package Info Plus

Path Provider

Image

Uuid

Crypto

Permission Handler

Connectivity Plus

---

# Performance

Lazy loading.

Pagination.

Image caching.

Memory optimization.

Background isolates for OCR and hashing.

No UI jank.

60–120 FPS animations.

---

# Testing

Unit tests.

Widget tests.

Repository tests.

Integration tests.

---

# Code Quality

Null safety.

Lint rules.

SOLID principles.

Repository pattern.

Dependency injection.

No duplicated logic.

Meaningful comments.

---

# iOS Requirements

Support:

iOS 26+

iPhone only (responsive enough to support iPad later if desired)

Dynamic Island compatibility

Safe Area

Native gestures

Interactive keyboard

Context menus

Swipe back

Share Extension

Document Picker

Photo Picker

Universal Links

Custom URL Scheme

Background fetch (where permitted by iOS)

---

# Deliverables

Generate:

* Complete Flutter project
* Folder structure
* All source code
* Database schema
* Riverpod providers
* Models
* Repositories
* Services
* Theme
* Icons
* Navigation
* Google authentication
* Google Drive backup implementation
* Share Extension
* Magnet URI handling
* iOS configuration (Info.plist, entitlements, URL schemes)
* Unit tests
* Integration tests
* README with setup instructions
* Build instructions for unsigned IPA using GitHub Actions
* CI workflow for building an unsigned iOS IPA on GitHub Actions

The final application should feel indistinguishable from a native iOS app, prioritize privacy, avoid duplicate clipboard entries through robust content hashing, support seamless import of magnet links from browsers, and provide secure, encrypted cloud synchronization using the user's Google account without requiring any custom backend server.
