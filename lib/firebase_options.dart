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
    apiKey: 'AIzaSyBnr74EZ0K8mA8jS-oaQJbr-PFEhc1w2po',
    appId: '1:834263737446:web:4129d36690ad40381e79a7',
    messagingSenderId: '834263737446',
    projectId: 'ju-delivery',
    authDomain: 'ju-delivery.firebaseapp.com',
    storageBucket: 'ju-delivery.appspot.com',
    measurementId: 'G-B1TMGGTMFQ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB9SUnm9CMe8yDRX18xnMnmbn-IhCGd2nI',
    appId: '1:834263737446:android:1ce3d3795aa7ca381e79a7',
    messagingSenderId: '834263737446',
    projectId: 'ju-delivery',
    storageBucket: 'ju-delivery.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDFBweo1V9DEM0Ehq9uNDMIR4CKE-HJ3Qo',
    appId: '1:834263737446:ios:b92453d8e0c35f8e1e79a7',
    messagingSenderId: '834263737446',
    projectId: 'ju-delivery',
    storageBucket: 'ju-delivery.appspot.com',
    iosBundleId: 'com.stepbystep.fip8.fip8',
  );
}
