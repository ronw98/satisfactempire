import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:satisfactempire/models/empire.dart';
import 'package:satisfactempire/models/items.dart';
import 'package:satisfactempire/view/item_image.dart';
import 'package:satisfactempire/view/planet_view/planet_view.dart';

class ItemSummaryView extends StatelessWidget {
  const ItemSummaryView({
    super.key,
    required this.item,
    required this.empire,
  });

  final SatisfactoryItem item;
  final Empire empire;

  @override
  Widget build(BuildContext context) {
    final productionLines = empire.itemProducedIn(item);
    final consumptionLines = empire.itemConsumedIn(item);
    return Column(
      children: [
        Row(
          children: [
            ItemImage(item: item),
            Gap(8),
            Text(item.name),
          ],
        ),
        Gap(16),
        Flexible(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      'Consommation',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Gap(8),
                    Flexible(
                      child: SingleChildScrollView(
                        child: Column(
                          children: consumptionLines.entries
                              .map(
                                (entry) => _PlanetProductionsWidget(
                                  planetId: entry.key,
                                  empire: empire,
                                  productions: entry.value,
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              VerticalDivider(width: 8),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      'Production',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Gap(8),
                    Flexible(
                      child: SingleChildScrollView(
                        child: Column(
                          children: productionLines.entries
                              .map(
                                (entry) => _PlanetProductionsWidget(
                                  planetId: entry.key,
                                  empire: empire,
                                  productions: entry.value,
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PlanetProductionsWidget extends StatelessWidget {
  const _PlanetProductionsWidget({
    required this.planetId,
    required this.empire,
    required this.productions,
  });

  final String planetId;
  final Empire empire;
  final List<ProductionLine> productions;

  @override
  Widget build(BuildContext context) {
    final planet = empire.planets.firstWhere((p) => p.id == planetId);
    return Card(
      child: Column(
        children: [
          Row(
            children: [
              ItemImage(item: planet.image),
              Gap(8),
              Text(planet.name),
            ],
          ),
          Gap(8),
          Padding(padding: EdgeInsets.only(left: 8)),
          ...productions.map(
            (prod) => PlanetProductionCard(line: prod, planetId: planetId),
          ),
        ],
      ),
    );
  }
}
