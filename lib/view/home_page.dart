import 'package:collection/collection.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:satisfactempire/app_cubit.dart';
import 'package:satisfactempire/view/app_drawer.dart';
import 'package:satisfactempire/view/home_page_content.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? selectedPlanetId;

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text('Satisfactory'),
      actions: [
        IconButton(
          onPressed: () {
            FirebaseUIAuth.signOut(context: context);
          },
          icon: Icon(Icons.logout),
        ),
      ],
    );
    return BlocBuilder<AppCubit, AppCubitState>(
      builder: (context, state) {
        switch (state) {
          case AppLoading():
            return Scaffold(
              appBar: appBar,
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case AppLoaded(empire: final empire):
            final selectedPlanet = empire.planets
                .firstWhereOrNull((p) => p.id == selectedPlanetId);
            return Scaffold(
              appBar: appBar,
              drawer: AppDrawer(
                  onPlanetSelected: (planet) {
                    setState(() {
                      selectedPlanetId = planet.id;
                    });
                  },
                  empire: empire,
                  selectedPlanet: selectedPlanet),
              body: HomePageContent(
                empire: empire,
                selectedPlanet: selectedPlanet,
              ),
            );
          case AppError(error: final e):
            return Scaffold(
              appBar: appBar,
              body: Placeholder(
                child: Center(
                  child: Text(e),
                ),
              ),
            );
          case AppInitial():
            return const SizedBox.shrink();
        }
      },
    );
  }
}
