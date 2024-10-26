import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:satisfactempire/app_cubit.dart';
import 'package:satisfactempire/view/home_page.dart';

class SatisfactEmpireApp extends StatelessWidget {
  const SatisfactEmpireApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme()
      ),
      home: BlocProvider(
        create: (_) => AppCubit(),
        child: const HomePage(),
      ),
    );
  }
}
