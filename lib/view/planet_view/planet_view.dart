import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:satisfactempire/app_cubit.dart';
import 'package:satisfactempire/extensions.dart';
import 'package:satisfactempire/models/empire.dart';
import 'package:satisfactempire/models/items.dart';
import 'package:satisfactempire/view/collapse_card.dart';
import 'package:satisfactempire/view/confirm_dialog.dart';
import 'package:satisfactempire/view/item_image.dart';
import 'package:satisfactempire/view/item_picker_dialog.dart';
import 'package:satisfactempire/view/planet_view/planet_production_lines_tab.dart';
import 'package:satisfactempire/view/planet_view/production_line_resource.dart';
import 'package:satisfactempire/view/production_overview_table.dart';
import 'package:uuid/uuid.dart';

class PlanetView extends StatelessWidget {
  const PlanetView({super.key, required this.planet});

  final Planet planet;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ItemImage(item: planet.image),
              Gap(16),
              Text(planet.name),
            ],
          ),
          Gap(16),
          TabBar(
            tabs: [
              Tab(
                text: 'Résumé planète',
                icon: Icon(Icons.book),
              ),
              Tab(
                text: 'Lignes de production',
                icon: Icon(Icons.handyman),
              ),
            ],
          ),
          Gap(16),
          Flexible(
            child: TabBarView(
              children: [
                ProductionOverviewTable(
                  production: planet.planetSummary,
                ),
                PlanetProductionLinesTab(planet: planet),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PlanetProductionCard extends StatelessWidget {
  const PlanetProductionCard(
      {super.key, required this.line, required this.planetId});

  final String planetId;
  final ProductionLine line;

  @override
  Widget build(BuildContext context) {
    return CollapseCard(
      borderColor: line.exists ? null : Theme.of(context).colorScheme.error,
      title: Row(
        children: [
          ItemImage(item: line.image),
          Gap(8),
          Text(
            line.name,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          Gap(8),
          Text(
            'x ${line.quantity}',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          if (!line.exists) ...[
            Gap(16),
            Text(
              'Off',
              style: Theme.of(context)
                  .textTheme
                  .labelMedium
                  ?.copyWith(color: Theme.of(context).colorScheme.error),
            ),
          ],
          Spacer(),
          IconButton(
            onPressed: () async {
              final confirm = await showDialog(
                context: context,
                builder: (_) => ConfirmDialog(),
              );
              if ((confirm ?? false) && context.mounted) {
                context.read<AppCubit>().deleteProductionLine(planetId, line);
              }
            },
            icon: Icon(
              Icons.delete,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cost
              Expanded(
                child: ProductionLineResources(
                  title: 'Entrées',
                  lineQuantity: line.quantity,
                  resources: line.baseConsumption,
                ),
              ),
              Gap(16),
              //Prod
              Expanded(
                child: ProductionLineResources(
                  title: 'Sorties',
                  lineQuantity: line.quantity,
                  resources: line.baseProduction,
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton.icon(
              onPressed: () async {
                final editedLine = await showDialog<ProductionLine>(
                  context: context,
                  builder: (_) => ProductionLineEditionDialog(line: line),
                );

                if (editedLine != null && context.mounted) {
                  context
                      .read<AppCubit>()
                      .updatePlanetLine(planetId, editedLine);
                }
              },
              icon: Icon(Icons.edit),
              label: Text('Modifier'),
            ),
          ),
          Gap(4),
        ],
      ),
    );
  }
}

class ProductionLineEditionDialog extends StatefulWidget {
  const ProductionLineEditionDialog({super.key, required this.line});

  final ProductionLine? line;

  @override
  State<ProductionLineEditionDialog> createState() =>
      _ProductionLineEditionDialogState();
}

class _ProductionLineEditionDialogState
    extends State<ProductionLineEditionDialog> {
  late Map<SatisfactoryItem, double> baseConsumption;
  late Map<SatisfactoryItem, double> baseProduction;
  late TextEditingController _name;
  late TextEditingController quantity;
  late SatisfactoryItem? image;

  late bool exists;
  late String id;

  @override
  void initState() {
    super.initState();
    baseConsumption = {...widget.line?.baseConsumption ?? {}};
    baseProduction = {...widget.line?.baseProduction ?? {}};
    quantity = TextEditingController(text: '${widget.line?.quantity ?? 1}')
      ..addListener(() {
        setState(() {});
      });
    _name = TextEditingController(text: widget.line?.name ?? '')
      ..addListener(() {
        setState(() {});
      });
    image = widget.line?.image;
    exists = widget.line?.exists ?? true;
    id = widget.line?.id ?? Uuid().v4();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Edition de ligne de production'),
            Divider(height: 32),
            Row(
              children: [
                SizedBox.square(
                  dimension: 50,
                  child: Stack(
                    children: [
                      if (image case final image?)
                        ItemImage(item: image)
                      else
                        Text(
                          'Aucune image',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      Positioned.fill(
                        child: Center(
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(.3),
                                shape: BoxShape.circle),
                            child: IconButton(
                              onPressed: () async {
                                final newItem =
                                    await showDialog<SatisfactoryItem>(
                                  context: context,
                                  builder: (_) => ItemPickerDialog(
                                    showEnergy: false,
                                    showPlanet: false,
                                  ),
                                );
                                if (newItem != null && mounted) {
                                  setState(() {
                                    image = newItem;
                                    if (_name.text.isEmpty) {
                                      _name.text = newItem.name;
                                    }
                                  });
                                }
                              },
                              icon: Icon(Icons.edit),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Gap(16),
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 200),
                  child: TextField(
                    controller: _name,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      label: Text('Nom de la ligne'),
                    ),
                  ),
                ),
                Gap(16),
                Text(
                  'Off',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                Gap(4),
                Switch(
                    value: exists,
                    onChanged: (value) {
                      setState(() {
                        exists = value;
                      });
                    }),
                Gap(4),
                Text(
                  'On',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ],
            ),
            Gap(16),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Quantity'),
                Gap(8),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 150,
                  ),
                  child: TextField(
                    controller: quantity,
                    maxLines: 1,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      hintText: '0',
                    ),
                  ),
                ),
              ],
            ),
            Gap(16),
            Row(
              children: [
                // Costs
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'Consommation',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      for (final (item, value) in baseConsumption.toIterable())
                        Row(
                          children: [
                            Stack(
                              children: [
                                ItemImage(item: item, size: 20),
                                Positioned.fill(
                                  child: Center(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white.withOpacity(.3),
                                      ),
                                      child: IconButton(
                                        onPressed: () async {
                                          final newItem = await showDialog<
                                              SatisfactoryItem>(
                                            context: context,
                                            builder: (_) => ItemPickerDialog(
                                                showEnergy: false),
                                          );
                                          if (newItem == null || !mounted) {
                                            return;
                                          }
                                          setState(() {
                                            // Remove previous item
                                            baseConsumption.remove(item);
                                            // Add new one or update existing
                                            // selected items ith previous item value.
                                            baseConsumption.update(
                                              newItem,
                                              (v) => v + value,
                                              ifAbsent: () => value,
                                            );
                                          });
                                        },
                                        icon: Icon(Icons.edit),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Gap(8),
                            Text(item.name,
                                style: Theme.of(context).textTheme.labelSmall),
                            Gap(16),
                            ConstrainedBox(
                              constraints: BoxConstraints(maxWidth: 100),
                              child: TextFormField(
                                initialValue: '$value',
                                style: Theme.of(context).textTheme.labelSmall,
                                onChanged: (newValue) {
                                  setState(() {
                                    baseConsumption[item] =
                                        double.parse(newValue);
                                  });
                                },
                              ),
                            ),
                            Gap(16),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  baseConsumption.remove(item);
                                });
                              },
                              icon: Icon(Icons.delete),
                            ),
                          ],
                        ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          onPressed: () {
                            final unusedItem = SatisfactoryItem.values
                                .firstWhereOrNull((item) =>
                                    !baseConsumption.containsKey(item));
                            if (unusedItem == null) return;
                            setState(() {
                              baseConsumption[unusedItem] = 0;
                            });
                          },
                          icon: Icon(Icons.add),
                        ),
                      ),
                    ],
                  ),
                ),
                // Production
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'Production',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      for (final (item, value) in baseProduction.toIterable())
                        Row(
                          children: [
                            Stack(
                              children: [
                                ItemImage(item: item, size: 20),
                                Positioned.fill(
                                  child: Center(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white.withOpacity(.3),
                                      ),
                                      child: IconButton(
                                        onPressed: () async {
                                          final newItem = await showDialog<
                                              SatisfactoryItem>(
                                            context: context,
                                            builder: (_) => ItemPickerDialog(
                                              showPlanet: false,
                                            ),
                                          );
                                          if (newItem == null || !mounted) {
                                            return;
                                          }
                                          setState(() {
                                            // Remove previous item
                                            baseProduction.remove(item);
                                            // Add new one or update existing
                                            // selected items ith previous item value.
                                            baseProduction.update(
                                              newItem,
                                              (v) => v + value,
                                              ifAbsent: () => value,
                                            );
                                          });
                                        },
                                        icon: Icon(Icons.edit),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Gap(8),
                            Text(item.name,
                                style: Theme.of(context).textTheme.labelSmall),
                            Gap(16),
                            ConstrainedBox(
                              constraints: BoxConstraints(maxWidth: 100),
                              child: TextFormField(
                                initialValue: '$value',
                                style: Theme.of(context).textTheme.labelSmall,
                                onChanged: (newValue) {
                                  setState(() {
                                    baseProduction[item] =
                                        double.parse(newValue);
                                  });
                                },
                              ),
                            ),
                            Gap(16),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  baseProduction.remove(item);
                                });
                              },
                              icon: Icon(Icons.delete),
                            ),
                          ],
                        ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          onPressed: () {
                            final unusedItem = SatisfactoryItem.values
                                .firstWhereOrNull((item) =>
                                    !baseProduction.containsKey(item));
                            if (unusedItem == null) return;
                            setState(() {
                              baseProduction[unusedItem] = 0;
                            });
                          },
                          icon: Icon(Icons.add),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Annuler'),
                  ),
                  Gap(8),
                  ElevatedButton(
                    onPressed: _canConfirm
                        ? () {
                            final newProductionLine = ProductionLine(
                              id: id,
                              name: _name.text,
                              baseConsumption: baseConsumption,
                              baseProduction: baseProduction,
                              quantity: double.parse(quantity.text),
                              image: image!,
                              exists: exists,
                            );
                            Navigator.pop(context, newProductionLine);
                          }
                        : null,
                    child: Text('Confirmer'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  bool get _canConfirm {
    return baseConsumption.isNotEmpty &&
        baseProduction.isNotEmpty &&
        _name.text.isNotEmpty &&
        double.tryParse(quantity.text) != null &&
        image != null;
  }
}
