import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:satisfactempire/models/empire.dart';
import 'package:satisfactempire/view/production_overview_table.dart';

class EmpireView extends StatelessWidget {
  const EmpireView({
    super.key,
    required this.empire,
  });

  final Empire empire;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Empire'),
        Gap(16),
        Expanded(
          child: ProductionOverviewTable(
            production: empire.empireSummary,
          ),
        ),
      ],
    );
  }
}
