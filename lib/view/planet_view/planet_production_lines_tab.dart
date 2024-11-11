import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:satisfactempire/app_cubit.dart';
import 'package:satisfactempire/models/empire.dart';
import 'package:satisfactempire/view/planet_view/planet_view.dart';

class PlanetProductionLinesTab extends StatelessWidget {
  const PlanetProductionLinesTab({super.key, required this.planet});

  final Planet planet;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Lignes de production'),
        Flexible(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: planet.productions.length,
            itemBuilder: (context, index) {
              return PlanetProductionCard(
                line: planet.productions[index],
                planetId: planet.id,
              );
            },
          ),
        ),
        Gap(16),
        Align(
          alignment: Alignment.centerRight,
          child: ElevatedButton.icon(
            onPressed: () async {
              final newProduction = await showDialog<ProductionLine>(
                context: context,
                builder: (_) => ProductionLineEditionDialog(line: null),
              );
              if (newProduction != null && context.mounted) {
                context.read<AppCubit>().addProductionLine(
                      planet.id,
                      newProduction,
                    );
              }
            },
            label: Text('Ajouter une ligne de production'),
            icon: Icon(Icons.add),
          ),
        ),
        Gap(4),
      ],
    );
  }
}
