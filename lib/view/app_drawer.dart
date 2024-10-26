import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:satisfactempire/app_cubit.dart';
import 'package:satisfactempire/models/empire.dart';
import 'package:satisfactempire/view/confirm_dialog.dart';
import 'package:satisfactempire/view/item_image.dart';
import 'package:satisfactempire/view/new_planet_dialog.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer(
      {super.key,
      required this.onPlanetSelected,
      required this.empire,
      required this.selectedPlanet});

  final Empire empire;
  final Planet? selectedPlanet;
  final ValueChanged<Planet> onPlanetSelected;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(child: Text('Satisfactory empire')),
          Gap(16),
          Flexible(
            child: ListView.builder(
              itemCount: empire.planets.length,
              // separatorBuilder: (_, __) => Divider(),
              itemBuilder: (context, index) {
                final planet = empire.planets[index];

                return ListTile(
                  title: Text(planet.name),
                  onTap: () {
                    onPlanetSelected(planet);
                  },
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  selectedColor:
                      Theme.of(context).colorScheme.secondaryContainer,
                  selected: planet == selectedPlanet,
                  leading: ItemImage(item: planet.image),
                  trailing: IconButton(
                    onPressed: () async {
                      final confirm = await showDialog<bool>(
                            context: context,
                            builder: (_) => ConfirmDialog(),
                          ) ??
                          false;

                      if (confirm && context.mounted) {
                        context.read<AppCubit>().deletePlanet(planet);
                      }
                    },
                    icon: Icon(Icons.delete),
                    color: Colors.red,
                  ),
                );
              },
            ),
          ),
          Gap(16),
          ElevatedButton.icon(
            onPressed: () async {
              final planetData = await showDialog<PlanetCreationResult>(
                context: context,
                builder: (_) => NewPlanetDialog(),
              );
              if (context.mounted && planetData != null) {
                context.read<AppCubit>().createPlanet(planetData);
              }
            },
            icon: Icon(Icons.add),
            label: Text('Nouvelle planète'),
          ),
          Gap(16),
        ],
      ),
    );
  }
}
