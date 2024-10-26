import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:satisfactempire/extensions.dart';
import 'package:satisfactempire/models/items.dart';
import 'package:satisfactempire/view/item_image.dart';

class ProductionLineResources extends StatelessWidget {
  const ProductionLineResources({
    super.key,
    required this.title,
    required this.resources,
    required this.lineQuantity,
  });

  final String title;
  final Map<SatisfactoryItem, double> resources;
  final double lineQuantity;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Entrées'),
        Gap(16),
        for (final (item, value) in resources.toIterable())
          Row(
            children: [
              ItemImage(
                item: item,
                size: 30,
              ),
              Gap(8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    Row(
                      children: [
                        Text(
                          '$value/min',
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                        Gap(16),
                        RichText(
                          text: TextSpan(
                            style: Theme.of(context).textTheme.labelSmall,
                            children: [
                              TextSpan(
                                text: '(Total ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              TextSpan(
                                text: '${value * lineQuantity}/min)',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
      ],
    );
  }
}
