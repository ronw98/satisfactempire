import 'package:flutter/material.dart';

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Confirmer ?'),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          child: Text('Annuler'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context, true);
          },
          child: Text('Confirmer'),
        ),
      ],
    );
  }
}
