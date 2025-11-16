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
    apiKey: 'AIzaSyDDtHh_cdrsLEts5lxsv0oFYita8jC-TaE',
    appId: '1:423037626800:web:8b07ba48240a374088ce75',
    messagingSenderId: '423037626800',
    projectId: 'controle-abastecimento-app',
    authDomain: 'controle-abastecimento-app.firebaseapp.com',
    storageBucket: 'controle-abastecimento-app.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDZTcoRcuabcmUMV3vCXKcoHa6eRxlNJ5I',
    appId: '1:423037626800:android:b9c542c76d980fe688ce75',
    messagingSenderId: '423037626800',
    projectId: 'controle-abastecimento-app',
    storageBucket: 'controle-abastecimento-app.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBAeNmcfDSiFdLRED6RWvzLPodTBOPTBwE',
    appId: '1:423037626800:ios:da375100bca77c0088ce75',
    messagingSenderId: '423037626800',
    projectId: 'controle-abastecimento-app',
    storageBucket: 'controle-abastecimento-app.firebasestorage.app',
    iosBundleId: 'com.example.controleDeAbastecimento',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBAeNmcfDSiFdLRED6RWvzLPodTBOPTBwE',
    appId: '1:423037626800:ios:da375100bca77c0088ce75',
    messagingSenderId: '423037626800',
    projectId: 'controle-abastecimento-app',
    storageBucket: 'controle-abastecimento-app.firebasestorage.app',
    iosBundleId: 'com.example.controleDeAbastecimento',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDDtHh_cdrsLEts5lxsv0oFYita8jC-TaE',
    appId: '1:423037626800:web:1c6ad66d3ddab23b88ce75',
    messagingSenderId: '423037626800',
    projectId: 'controle-abastecimento-app',
    authDomain: 'controle-abastecimento-app.firebaseapp.com',
    storageBucket: 'controle-abastecimento-app.firebasestorage.app',
  );

}