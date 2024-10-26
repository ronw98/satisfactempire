import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:satisfactempire/app_cubit.dart';
import 'package:satisfactempire/router.dart';

class SatisfactEmpireApp extends StatelessWidget {
  const SatisfactEmpireApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AppCubit(),
      child: MaterialApp.router(
        theme: ThemeData(textTheme: GoogleFonts.poppinsTextTheme()),
        routerConfig: router,
        builder: (context, child) {
          return FirebaseUIActions(
            actions: [
              SignedOutAction(
                (context) {
                  LoginRoute().pushReplacement(context);
                },
              ),
            ],
            child: child!,
          );
        },
      ),
    );
  }
}
