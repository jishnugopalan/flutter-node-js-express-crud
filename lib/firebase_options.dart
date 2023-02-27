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
    apiKey: 'AIzaSyAM6dbSIuWkTDlbo4Cuk5zj1WJ-zjr5xis',
    appId: '1:822268573233:web:bd77a54d3b73b1bcce8710',
    messagingSenderId: '822268573233',
    projectId: 'flutter-authentication-a-bc789',
    authDomain: 'flutter-authentication-a-bc789.firebaseapp.com',
    storageBucket: 'flutter-authentication-a-bc789.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDzm90_ODXKcf2diRjDQ600avACW0tbz08',
    appId: '1:822268573233:android:fb49bc8b707110b0ce8710',
    messagingSenderId: '822268573233',
    projectId: 'flutter-authentication-a-bc789',
    storageBucket: 'flutter-authentication-a-bc789.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC9UHL8R0ok9_wk-PKJj2P5UiuqJ_Qp1do',
    appId: '1:822268573233:ios:1c1bb50b5cc5307ece8710',
    messagingSenderId: '822268573233',
    projectId: 'flutter-authentication-a-bc789',
    storageBucket: 'flutter-authentication-a-bc789.appspot.com',
    iosClientId: '822268573233-inm0bmt92njdup97uo6cmevuv594jt7l.apps.googleusercontent.com',
    iosBundleId: 'com.example.authdemo',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC9UHL8R0ok9_wk-PKJj2P5UiuqJ_Qp1do',
    appId: '1:822268573233:ios:1c1bb50b5cc5307ece8710',
    messagingSenderId: '822268573233',
    projectId: 'flutter-authentication-a-bc789',
    storageBucket: 'flutter-authentication-a-bc789.appspot.com',
    iosClientId: '822268573233-inm0bmt92njdup97uo6cmevuv594jt7l.apps.googleusercontent.com',
    iosBundleId: 'com.example.authdemo',
  );
}
