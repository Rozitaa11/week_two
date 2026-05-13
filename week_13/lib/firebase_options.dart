import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
      case TargetPlatform.linux:
        return android;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBzpqQorEKv7iR93ZIPQuY33WLxLkom_eM',
    appId: '1:43620702304:android:87e1880962670097718b05',
    messagingSenderId: '43620702304',
    projectId: 'week-13-app',
    authDomain: 'week-13-app.firebaseapp.com',
    storageBucket: 'week-13-app.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBzpqQorEKv7iR93ZIPQuY33WLxLkom_eM',
    appId: '1:43620702304:android:87e1880962670097718b05',
    messagingSenderId: '43620702304',
    projectId: 'week-13-app',
    storageBucket: 'week-13-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBzpqQorEKv7iR93ZIPQuY33WLxLkom_eM',
    appId: '1:43620702304:android:87e1880962670097718b05',
    messagingSenderId: '43620702304',
    projectId: 'week-13-app',
    storageBucket: 'week-13-app.appspot.com',
    iosBundleId: 'com.example.yourApp',
  );
}
