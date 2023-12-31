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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyCXAw8BQBx4OPMOWyNaI4bv7gh5GUXa0lQ',
    appId: '1:488939796804:web:5c94e0a3b5f03ca2abbf11',
    messagingSenderId: '488939796804',
    projectId: 'flutterplanetcombo-ff367',
    authDomain: 'flutterplanetcombo-ff367.firebaseapp.com',
    storageBucket: 'flutterplanetcombo-ff367.appspot.com',
    measurementId: 'G-MLW4X9WR7H',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDXRbwhoPL8Pxc7NxJ1MRCJiiBcYrECJus',
    appId: '1:488939796804:android:ba7a9c27cb0f7aababbf11',
    messagingSenderId: '488939796804',
    projectId: 'flutterplanetcombo-ff367',
    storageBucket: 'flutterplanetcombo-ff367.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC2KXYlegQXqtuGkRbji0j1FOeR1u3HhJU',
    appId: '1:488939796804:ios:f0c5ec86171df4d1abbf11',
    messagingSenderId: '488939796804',
    projectId: 'flutterplanetcombo-ff367',
    storageBucket: 'flutterplanetcombo-ff367.appspot.com',
    androidClientId: '488939796804-9hovca0oc2eo1n661ql6jccqmb6t10mg.apps.googleusercontent.com',
    iosClientId: '488939796804-bpq74bkqnn36frrfhaee58kal6ldg6ah.apps.googleusercontent.com',
    iosBundleId: 'com.chandrasekar.planetcombo.planetcombo',
  );
}
