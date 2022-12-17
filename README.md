# Flutter code base

My flutter code base

## Technical

- [Dependencies injection](https://pub.dev/packages/injectable)
- [State management Bloc/Cubit](https://pub.dev/packages/flutter_bloc)
- [Flavor development/product](https://medium.com/@animeshjain/build-flavors-in-flutter-android-and-ios-with-different-firebase-projects-per-flavor-27c5c5dac10b)
- [Internationalizing i18n](https://docs.flutter.dev/development/accessibility-and-localization/internationalization)

## Architect

```
-- android
-- ios
-- assets
-- lib --|
         |--l10n
         |--public--|
         |          |--flavor
         |          |--routes
         |          |--style
         |          |--utilities
         |          |--validators
         |
         |--src--|
         |       |--di
         |       |--models
         |       |--network
         |       |--repositories
         |       |--screens--|
         |       |           |--
         |       |           |--
         |       |--app.dart
         |
```