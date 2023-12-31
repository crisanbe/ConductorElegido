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
    apiKey: 'AIzaSyBlDnmeslBKfGNc3vcpbG8_1e09cEkHeTQ',
    appId: '1:592904090620:android:cead70068e73f154faf879',
    messagingSenderId: '592904090620',
    projectId: 'conductor-elegido-6da0f',
    databaseURL: 'https://conductor-elegido-6da0f-default-rtdb.firebaseio.com',
    storageBucket: 'conductor-elegido-6da0f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBIUerbv1Ul0H2v4lDm4tfWfVLkdvmf_kI',
    appId: '1:592904090620:ios:6813d68b81ad8833faf879',
    messagingSenderId: '592904090620',
    projectId: 'conductor-elegido-6da0f',
    databaseURL: 'https://conductor-elegido-6da0f-default-rtdb.firebaseio.com',
    storageBucket: 'conductor-elegido-6da0f.appspot.com',
    iosClientId: '592904090620-3r3m2j2muop4gcmlqfaamfpde7kg32nv.apps.googleusercontent.com',
    iosBundleId: 'com.conductor.conductorElegido',
  );
}
