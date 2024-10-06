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
    apiKey: 'AIzaSyAUybJx8aj_lhlzmT5J8J3ghsI1T-FoWPo',
    appId: '1:214289762879:android:7940a6e0caa6e99c2c468a',
    messagingSenderId: '214289762879',
    projectId: 'name-card-1db6d',
    storageBucket: 'name-card-1db6d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBD9w-9X0iY1aly-EFqwFIDqEOJvgpMnGk',
    appId: '1:214289762879:ios:dbf43e47fa2d63182c468a',
    messagingSenderId: '214289762879',
    projectId: 'name-card-1db6d',
    storageBucket: 'name-card-1db6d.appspot.com',
    androidClientId: '214289762879-e3vm2jevefpf9mpekmnvfnl9pqk0v5v7.apps.googleusercontent.com',
    iosClientId: '214289762879-alo98l5ffimgb2mebcckad3j5ugk1q9t.apps.googleusercontent.com',
    iosBundleId: 'com.efficiolu.namecardscanner',
  );

}