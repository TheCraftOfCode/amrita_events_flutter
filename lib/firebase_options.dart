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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDfXS4JLU8a6hiu1sT8R1Ei4y5EgKMQtPY',
    appId: '1:687769421564:android:497a36a83d7f86760ff979',
    messagingSenderId: '687769421564',
    projectId: 'amritaevents-9aa79',
    storageBucket: 'amritaevents-9aa79.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBgk7D3iQ4G3W2YUapmZb1mduMD_fQS18k',
    appId: '1:687769421564:ios:64536762a4ebae830ff979',
    messagingSenderId: '687769421564',
    projectId: 'amritaevents-9aa79',
    storageBucket: 'amritaevents-9aa79.appspot.com',
    androidClientId: '687769421564-usvt0mkbg78salec03acjv0dpcc1cmj5.apps.googleusercontent.com',
    iosClientId: '687769421564-phij0ui3931mp3jceueo5i71blrv90dh.apps.googleusercontent.com',
    iosBundleId: 'com.example.amritaEventsFlutter',
  );
}
