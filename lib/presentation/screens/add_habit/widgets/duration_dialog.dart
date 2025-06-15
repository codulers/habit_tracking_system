import 'package:flutter/material.dart';

class DurationDialog {
  static void show(BuildContext context, Function(Duration) onDurationSelected) {
    final TextEditingController _durationController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter Duration in Hours'),
          content: TextField(
            controller: _durationController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: 'Enter duration in hours',
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                final durationInHours = int.tryParse(_durationController.text) ?? 0;
                final selectedDuration = Duration(hours: durationInHours);
                onDurationSelected(selectedDuration);
                Navigator.of(context).pop();
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }
}
