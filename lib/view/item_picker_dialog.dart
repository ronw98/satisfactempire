import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:satisfactempire/extensions.dart';
import 'package:satisfactempire/models/items.dart';

class ItemPickerDialog extends StatefulWidget {
  const ItemPickerDialog({super.key});

  @override
  State<ItemPickerDialog> createState() => _ItemPickerDialogState();
}

class _ItemPickerDialogState extends State<ItemPickerDialog> {
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

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: 500,
      ),
      child: Dialog(
        insetPadding: EdgeInsets.all(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _search,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    prefix: Icon(Icons.search),
                    label: Text('Recherche')),
              ),
              Gap(16),
              Expanded(
                child: SingleChildScrollView(
                  child: Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: SatisfactoryItem.values
                        .where(
                          (item) => item.name.sanitize().contains(
                                _search.text.sanitize(),
                              ),
                        )
                        .map(
                          (item) => InkWell(
                            onTap: () => Navigator.pop(context, item),
                            child: SizedBox.square(
                              dimension: 50,
                              child: Tooltip(
                                message: item.name,
                                child: Image(image: item.image),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Annuler'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
