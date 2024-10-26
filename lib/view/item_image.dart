import 'package:flutter/material.dart';
import 'package:satisfactempire/models/items.dart';

class ItemImage extends StatelessWidget {
  const ItemImage({super.key, required this.item, this.size = 50});

  final SatisfactoryItem item;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: 50,
      child: Tooltip(
        message: item.name,
        child: Image(
          image: item.image,
        ),
      ),
    );
  }
}
