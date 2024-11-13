import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
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
    apiKey: 'AIzaSyAZ0dqNF2Vs9VNT-LIpKSRAxVdBC1sfh0w',
    appId: '1:219532317084:android:32612753f078b2aedfb859',
    messagingSenderId: '219532317084',
    projectId: 'blogs-app-fb0a1',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCL_tLXPzGtCqlO9CqSNLHqbaiFpjpDqPY',
    appId: '1:219532317084:ios:5911ead558c003e2dfb859',
    messagingSenderId: '219532317084',
    projectId: 'blogs-app-fb0a1',
    iosBundleId: 'com.blogs.app',
  );

}