// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyBhaIyf-x7UO6z8CmeJR8-3spMjgdALupk',
    appId: '1:912105191763:web:41a58e5d1f1536a1ec09a6',
    messagingSenderId: '912105191763',
    projectId: 'crashes-38437',
    authDomain: 'crashes-38437.firebaseapp.com',
    storageBucket: 'crashes-38437.appspot.com',
    measurementId: 'G-SLPXEH2PMR',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDPCxdRKCYjzcg--XsSZUdKjtLcnVhqlOk',
    appId: '1:912105191763:android:e23feef13f0d9ac1ec09a6',
    messagingSenderId: '912105191763',
    projectId: 'crashes-38437',
    storageBucket: 'crashes-38437.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAKLadDcAXCP2WZROJ87uA87m9Feau45l8',
    appId: '1:912105191763:ios:0c428b06ea8d0e62ec09a6',
    messagingSenderId: '912105191763',
    projectId: 'crashes-38437',
    storageBucket: 'crashes-38437.appspot.com',
    iosBundleId: 'com.example.crashFirebase',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAKLadDcAXCP2WZROJ87uA87m9Feau45l8',
    appId: '1:912105191763:ios:0c428b06ea8d0e62ec09a6',
    messagingSenderId: '912105191763',
    projectId: 'crashes-38437',
    storageBucket: 'crashes-38437.appspot.com',
    iosBundleId: 'com.example.crashFirebase',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBhaIyf-x7UO6z8CmeJR8-3spMjgdALupk',
    appId: '1:912105191763:web:79d6e57f9aa66d17ec09a6',
    messagingSenderId: '912105191763',
    projectId: 'crashes-38437',
    authDomain: 'crashes-38437.firebaseapp.com',
    storageBucket: 'crashes-38437.appspot.com',
    measurementId: 'G-029YVBSGPN',
  );
}
