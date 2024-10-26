import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:satisfactempire/models/items.dart';
import 'package:satisfactempire/view/item_picker_dialog.dart';

typedef PlanetCreationResult = ({String name, SatisfactoryItem image});

class NewPlanetDialog extends StatefulWidget {
  const NewPlanetDialog({super.key});

  @override
  State<NewPlanetDialog> createState() => _NewPlanetDialogState();
}

class _NewPlanetDialogState extends State<NewPlanetDialog> {
  SatisfactoryItem? _image;
  late final TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController()
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Nouvelle planète',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Gap(16),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox.square(
                  dimension: 60,
                  child: Stack(
                    children: [
                      if (_image case final image?)
                        Image(image: image.image)
                      else
                        InkWell(
                          onTap: _selectImage,
                          child: Center(
                            child: Text('Aucune image'),
                          ),
                        ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Ink(
                          decoration: BoxDecoration(
                              color: Colors.grey.shade600,
                              shape: BoxShape.circle),
                          padding: EdgeInsets.all(3),
                          child: InkWell(
                            onTap: _selectImage,
                            child: Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Gap(16),
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 250),
                  child: TextField(
                    controller: _nameController,
                    maxLines: 1,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      label: Text('Nom de la planète'),
                    ),
                  ),
                ),
              ],
            ),
            Gap(16),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  onPressed: Navigator.of(context).pop,
                  icon: Icon(Icons.close),
                  label: Text('Annuler'),
                ),
                Gap(8),
                ElevatedButton.icon(
                  onPressed: _nameController.text.isEmpty || _image == null
                      ? null
                      : () {
                          Navigator.pop(
                            context,
                            (name: _nameController.text, image: _image!),
                          );
                        },
                  icon: Icon(Icons.add),
                  label: Text(
                    'Créer la planète',
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> _selectImage() async {
    final selectedItem = await showDialog<SatisfactoryItem>(
        context: context, builder: (_) => ItemPickerDialog());
    if (selectedItem == null || !mounted) {
      return;
    }
    setState(() {
      _image = selectedItem;
    });
  }
}
