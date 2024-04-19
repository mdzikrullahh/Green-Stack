import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyBTPJMMtn-vvk7rvexM-kDk_eDDT0aSfQY",
            authDomain: "greenstack-fc700.firebaseapp.com",
            projectId: "greenstack-fc700",
            storageBucket: "greenstack-fc700.appspot.com",
            messagingSenderId: "970022121657",
            appId: "1:970022121657:web:2482dd8fb71c8562e76b68",
            measurementId: "G-8DZNCG56VR"));
  } else {
    await Firebase.initializeApp();
  }
}
