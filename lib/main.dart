import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';
import 'package:satisfactempire/app.dart';
import 'package:satisfactempire/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseUIAuth.configureProviders([
    GoogleProvider(
        clientId:
            '838634770317-po69tfj6jv7n521uhhclhnvs97goabcm.apps.googleusercontent.com'),
  ]);
  runApp(const SatisfactEmpireApp());
}
