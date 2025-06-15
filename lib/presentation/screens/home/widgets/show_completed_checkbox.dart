import 'package:flutter/material.dart';

class ShowCompletedCheckbox extends StatelessWidget {
  final bool showCompletedHabits;
  final ValueChanged<bool?> onChanged;

  const ShowCompletedCheckbox({
    required this.showCompletedHabits,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: showCompletedHabits,
          onChanged: onChanged,
        ),
        const Text("Show Completed Habits", style: TextStyle(fontSize: 16)),
      ],
    );
  }
}
