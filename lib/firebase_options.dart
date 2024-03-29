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
    apiKey: 'AIzaSyAXSBTdwllJ27MLqwbETP8wFr1lIt9oBoo',
    appId: '1:1057098259949:web:11e611bfea10360cabdbe4',
    messagingSenderId: '1057098259949',
    projectId: 'iotproject-07',
    authDomain: 'iotproject-07.firebaseapp.com',
    databaseURL: 'https://iotproject-07-default-rtdb.firebaseio.com',
    storageBucket: 'iotproject-07.appspot.com',
    measurementId: 'G-ZG365LZNSW',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAyfuprbIFKY85BPFH5hNNHHeh1nC-w3eY',
    appId: '1:1057098259949:android:77aef107fc614c13abdbe4',
    messagingSenderId: '1057098259949',
    projectId: 'iotproject-07',
    databaseURL: 'https://iotproject-07-default-rtdb.firebaseio.com',
    storageBucket: 'iotproject-07.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBH7TbUJ_JtFdweQ2jKAIHOXnf3LZs7hw0',
    appId: '1:1057098259949:ios:fea13e55526ae1c6abdbe4',
    messagingSenderId: '1057098259949',
    projectId: 'iotproject-07',
    databaseURL: 'https://iotproject-07-default-rtdb.firebaseio.com',
    storageBucket: 'iotproject-07.appspot.com',
    iosBundleId: 'com.example.iotProject',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBH7TbUJ_JtFdweQ2jKAIHOXnf3LZs7hw0',
    appId: '1:1057098259949:ios:a8906362fdfa6d08abdbe4',
    messagingSenderId: '1057098259949',
    projectId: 'iotproject-07',
    databaseURL: 'https://iotproject-07-default-rtdb.firebaseio.com',
    storageBucket: 'iotproject-07.appspot.com',
    iosBundleId: 'com.example.iotProject.RunnerTests',
  );
}
