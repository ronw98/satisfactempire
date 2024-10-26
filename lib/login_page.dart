import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:satisfactempire/router.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SignInScreen(
      providers: [
        EmailAuthProvider(),
      ],
      showAuthActionSwitch: false,
      actions: [
        AuthStateChangeAction<SignedIn>(
          (context, state) {
            HomeRoute().pushReplacement(context);
          },
        ),
      ],
    );
  }
}
