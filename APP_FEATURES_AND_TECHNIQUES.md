# CitiFix App Features, Techniques, and Key Packages

## Overview
CitiFix is a cross-platform Flutter application that connects citizens with city maintenance teams. The app supports both citizen and worker roles, making it possible to report urban issues, track repair work, and document task completion with photos, location data, and PDF reports.

## Core App Features

### 1. Dual-role experience
- Citizen experience for reporting problems and tracking repair status.
- Worker experience for receiving jobs, navigating to tasks, and submitting completed repair evidence.
- Role selection is managed in the app flow using `AppRole` in `lib/core/routing/appRoutingRole.dart`.

### 2. Authentication and onboarding
- Onboarding flow to introduce the app to first-time users.
- Login, signup, password recovery, and OTP verification.
- Secure session storage for authentication tokens and user preferences.

### 3. Citizen reporting
- Create issue reports with title, description, category, location, and media attachments.
- Support for attaching images and videos to reports.
- Location selection with an interactive map and search.
- Reports include status tracking and timeline details.
- Built-in comment system for citizens and workers to communicate about a report.

### 4. Worker task management
- Worker dashboard with assigned tasks, urgent alerts, and progress status.
- View detailed task pages with issue summary, map directions, and completion requirements.
- Add completion notes, capture proof-of-work images, and update task status.
- Generate a PDF version of task details for reporting and archiving.

### 5. Mapping and location
- Interactive map pages show current location and task locations.
- Location search and address lookup from the device and APIs.
- Distance and route-aware navigation support.

### 6. Notifications
- Remote push notifications using Firebase Cloud Messaging.
- Local notifications for foreground app alerts and important updates.

### 7. Profile & settings
- Profile viewing and editing.
- Language switching and theming options.
- Help and support pages.

### 8. Achievements and reporting
- Task and report progress tracking with achievement summaries.
- Visual timelines and status badges for report lifecycle stages.

## Techniques and Architecture

### Clean architecture and modular structure
- The app follows a modular feature-based structure in `lib/feature`.
- Core utilities, services, and resources are grouped in `lib/core`.
- UI configuration and app shell are in `lib/App`.

### State management
- Uses `flutter_bloc` and Cubits for state handling across the app.
- Multiple `BlocProvider` instances are configured in `lib/main.dart` and `lib/App/citifix.dart`.

### Dependency injection
- Uses `get_it` for dependency injection and service location.
- Centralized initialization in `lib/core/DI/getit.dart`.

### Responsive UI
- Uses `flutter_screenutil` to adapt layouts and typography for different screen sizes.
- Custom design values and screen utilities are defined in `lib/core/resource`.

### Localization
- Arabic and English localization support via generated translations in `lib/generated/l10n.dart`.
- `flutter_localizations` and `intl` packages power translated strings and locale-aware formatting.

### Platform initialization
- App startup ensures Flutter bindings and preferred orientations are set.
- Firebase initialization happens before the app runs.
- Local notifications and location services are initialized at startup.

### Local data storage
- Stores key values and settings with `shared_preferences`.
- Sensitive data and secure tokens can use `flutter_secure_storage`.

### Networking and API integration
- Uses `dio` as the main HTTP client for API requests.
- `http` is also used for auxiliary networking tasks such as image downloads for notifications.
- `pretty_dio_logger` is used for readable API request logging.

### Media handling
- Image and video picking from camera and gallery.
- Media compression before upload.
- File picking for selecting documents or media attachments.

### PDF generation
- Captures task details and renders them to PDF using `pdf` and `printing`.
- Screenshots are captured with `screenshot` and embedded in PDF pages.

### Notifications and background messages
- Firebase Cloud Messaging for remote push notifications.
- Local notifications displayed through `flutter_local_notifications`.
- Background message handling enabled for messages delivered while the app is not active.

## Powerful Capabilities and Package Usage

### App bootstrap and dependency services
- `firebase_core` - initializes Firebase when the app starts.
- `get_it` - dependency injection for repositories, services, and Cubits.
- `flutter_bloc` - primary state management framework.
- `flutter_screenutil` - adaptive layout and typography scaling.

### Maps, geolocation, and navigation
- `flutter_map` - map display and interactive location selection.
- `location` - device GPS access and current position.
- `geocoding` - reverse geocoding for street/address lookups.
- `latlong2` - coordinate types used by the map.
- `geo_fence_utils` - geofencing support for location-based alerts.
- `osrm` - supports routing and navigation between locations.

### Media, documents, and file handling
- `image_picker` - camera and gallery image selection.
- `file_picker` - file selection from device storage.
- `wechat_assets_picker` - advanced pickers for images and videos.
- `photo_manager` - media asset management.
- `video_compress` - compress videos before upload.
- `screenshot` - capture widget screenshots for PDF export.
- `pdf` - build PDF documents programmatically.
- `printing` - send generated PDFs to print or share.

### Notifications and messaging
- `firebase_messaging` - remote push notifications.
- `flutter_local_notifications` - local notification display.
- `http` - downloads notification image assets for rich notifications.

### UI and visual polish
- `google_fonts` - custom font rendering across the app.
- `lottie` - animated vector illustrations.
- `shimmer` - loading placeholders.
- `carousel_slider` - swipable onboarding or media carousels.
- `animated_custom_dropdown` - animated dropdown fields.
- `flutter_slidable` - swipe actions for list items.
- `flutter_snake_navigationbar` - custom bottom navigation styling.
- `smooth_page_indicator` - page indicators for onboarding and carousels.
- `dotted_border` - dotted line borders for cards and selectors.
- `flutter_faq` - FAQ UI support.
- `modal_progress_hud_nsn` - modal loading overlay.

### Data, storage, and utility packages
- `shared_preferences` - simple local key/value storage.
- `flutter_secure_storage` - secure storage for sensitive data.
- `connectivity_plus` - internet connectivity awareness.
- `package_info_plus` - app package metadata and version info.
- `url_launcher` - open URLs, email intents, and help links.
- `logger` - structured logging during development.
- `dartz` - functional programming helpers for safer value handling.
- `csc_picker_plus` - country/state/city selection support.

### Firebase and remote configuration
- `firebase_remote_config` - fetch remote values and config settings from Firebase.

## App Structure Reference
- `lib/main.dart` - app entry point and global initialization.
- `lib/App/citifix.dart` - root `MaterialApp`, theme, localization, and navigation setup.
- `lib/core` - common services, dependency injection, theme, routing, resources, and utilities.
- `lib/feature/Auth` - authentication, signup, login, password reset, and OTP.
- `lib/feature/citzenFeature` - citizen-facing modules including onboarding, profile, home dashboard, reports, notifications, and achievements.
- `lib/feature/workerFeature` - worker-facing task details, worker task management, and verification flows.
- `lib/generated/l10n.dart` - generated localization strings.

## Notes
- The app uses a clean and layered architecture with feature separation to keep code maintainable.
- Every major capability is backed by a package from `pubspec.yaml`; this document highlights the most important packages for each area.
- The current app supports Arabic and English, and is designed for portrait-only operation.

## How to Use This Document
Use this file as a central reference for understanding what CitiFix offers and which packages power each feature. It is ideal for onboarding team members, preparing documentation, or reviewing the app architecture before adding new features.
