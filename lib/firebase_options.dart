// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBFHx6mKhuSHFCUsI68FKzIGrfTdADjAhA',
    appId: '1:97135906273:web:de313e0d6f82a0501556a0',
    messagingSenderId: '97135906273',
    projectId: 'social-media-app-d8d22',
    authDomain: 'social-media-app-d8d22.firebaseapp.com',
    storageBucket: 'social-media-app-d8d22.appspot.com',
    measurementId: 'G-K5T91HL2ZT',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBGZmzLN8f--BmbXy6VfZUty1tDM_eQO1o',
    appId: '1:97135906273:android:0efdd565d0c326ce1556a0',
    messagingSenderId: '97135906273',
    projectId: 'social-media-app-d8d22',
    storageBucket: 'social-media-app-d8d22.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDPmJ_SAwbewZpltxFiJF3nJnB1UxzHATM',
    appId: '1:97135906273:ios:f42bfa9631e8dbef1556a0',
    messagingSenderId: '97135906273',
    projectId: 'social-media-app-d8d22',
    storageBucket: 'social-media-app-d8d22.appspot.com',
    iosBundleId: 'com.example.socialMediaApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDPmJ_SAwbewZpltxFiJF3nJnB1UxzHATM',
    appId: '1:97135906273:ios:c14f6c47ac6b5df61556a0',
    messagingSenderId: '97135906273',
    projectId: 'social-media-app-d8d22',
    storageBucket: 'social-media-app-d8d22.appspot.com',
    iosBundleId: 'com.example.socialMediaApp.RunnerTests',
  );
}