import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/home_screen_bloc/home_screen_bloc.dart';
import '../../../bloc/home_screen_bloc/home_screen_event.dart';

class HabitList extends StatelessWidget {
  final List<Map<String, dynamic>> habits;

  const HabitList({required this.habits, super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: habits.length,
        itemBuilder: (context, index) {
          final habit = habits[index];
          final startDate = DateTime.parse(habit['startDateTime']);
          final formattedDate = "${startDate.day}-${startDate.month}-${startDate.year}";
          final durationInHours = habit['duration'] ?? 0;
          final durationText = "$durationInHours hrs";

          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            elevation: 5.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16.0),
              title: Text(
                habit['name'],
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    habit['description'],
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    "Start Date: $formattedDate",
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black45,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  /*Text(
                    "Duration: $durationText",
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black45,
                    ),
                  ),*/
                ],
              ),
              trailing: Switch(
                value: habit['status'] ?? false,
                onChanged: (newStatus) {
                  context.read<HomeScreenBloc>().add(ToggleHabitStatusEvent(
                    habitIndex: index,
                    newStatus: newStatus,
                  ));
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
