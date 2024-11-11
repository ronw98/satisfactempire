import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:satisfactempire/extensions.dart';
import 'package:satisfactempire/models/empire.dart';
import 'package:satisfactempire/models/items.dart';
import 'package:satisfactempire/view/item_image.dart';

class ProductionOverviewTable extends StatefulWidget {
  const ProductionOverviewTable({super.key, required this.production});

  final Map<SatisfactoryItem, ResourceSummary> production;

  @override
  State<ProductionOverviewTable> createState() =>
      _ProductionOverviewTableState();
}

class _ProductionOverviewTableState extends State<ProductionOverviewTable> {
  int sortingColumn = 0;
  bool sortAscending = true;
  late final TextEditingController _search;

  @override
  void initState() {
    super.initState();
    _search = TextEditingController()
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  void _onSort(int index, bool ascending) {
    setState(() {
      sortAscending = ascending;
      sortingColumn = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final sortedProduction = widget.production
        .toIterable()
        // Filter Rien
        .where(
          (entry) =>
              entry.$1 != SatisfactoryItem.aucun &&
              entry.$1 != SatisfactoryItem.planet,
        )
        // Search
        .where(
      (entry) {
        return entry.$1.name.sanitize().contains(_search.text.sanitize());
      },
    ).toList()
      ..sort(
        (entryA, entryB) {
          // Sort by name
          if (sortingColumn == 0) {
            return entryA.$1.name.compareTo(entryB.$1.name) *
                (sortAscending ? 1 : -1);
          }
          // Sort by production
          if (sortingColumn == 1) {
            return entryA.$2.production.compareTo(entryB.$2.production) *
                (sortAscending ? 1 : -1);
          }
          if (sortingColumn == 2) {
            return entryA.$2.consumption.compareTo(entryB.$2.consumption) *
                (sortAscending ? 1 : -1);
          }
          if (sortingColumn == 3) {
            return entryA.$2.differential.compareTo(entryB.$2.differential) *
                (sortAscending ? 1 : -1);
          }
          return 0;
        },
      );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _search,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.zero,
            ),
            label: Text('Rechercher'),
            prefix: Icon(Icons.search),
          ),
        ),
        Gap(16),
        Expanded(
          child: FractionallySizedBox(
            widthFactor: 1,
            child: SingleChildScrollView(
              child: DataTable(
                dataRowMaxHeight: 60,
                sortColumnIndex: sortingColumn,
                sortAscending: sortAscending,
                columns: [
                  DataColumn(
                    label: Expanded(
                      child: Text('Item'),
                    ),
                    onSort: _onSort,
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Text('Production'),
                    ),
                    onSort: _onSort,
                  ),
                  DataColumn(
                    label: Expanded(child: Text('Consommation')),
                    onSort: _onSort,
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Text('Différentiel'),
                    ),
                    onSort: _onSort,
                  ),
                ],
                rows: sortedProduction.map<DataRow>(
                  (data) {
                    final (item, summary) = data;
                    return DataRow(
                      cells: [
                        DataCell(
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ItemImage(item: item),
                                Gap(8),
                                Expanded(child: Text(item.name)),
                              ],
                            ),
                          ),
                        ),
                        DataCell(
                          Text(
                            '${summary.production.roundToPrecision(2)}',
                          ),
                        ),
                        DataCell(
                          Text(
                            '${summary.consumption.roundToPrecision(2)}',
                          ),
                        ),
                        DataCell(
                          Text(
                            '${summary.differential.roundToPrecision(2)}',
                            style: TextStyle(
                              color: switch (summary.differential) {
                                0 => null,
                                > 0 => Colors.green,
                                _ => Colors.red,
                              },
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ).toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
