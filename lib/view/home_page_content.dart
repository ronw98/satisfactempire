import 'package:flutter/material.dart';
import 'package:satisfactempire/models/empire.dart';
import 'package:satisfactempire/view/empire_view.dart';
import 'package:satisfactempire/view/planet_view/planet_view.dart';

class HomePageContent extends StatelessWidget {
  const HomePageContent({super.key, required this.empire, this.selectedPlanet});

  final Empire empire;
  final Planet? selectedPlanet;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(child: EmpireView(empire: empire)),
          if (selectedPlanet case final planet?) ...[
            VerticalDivider(width: 32, thickness: 5),
            Expanded(child: PlanetView(planet: planet)),
          ],
        ],
      ),
    );
  }
}
