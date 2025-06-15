import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class HabitLocalDataSource {
  final SharedPreferences sharedPreferences;

  HabitLocalDataSource(this.sharedPreferences);

  // Save habit with status (pending by default)
  Future<void> saveHabit(Map<String, dynamic> habit) async {
    final habits = await getHabits();
    habits.add(habit);
    await sharedPreferences.setString('habits', json.encode(habits));
  }

  // Update habit status
  Future<void> updateHabitStatus(int index, bool status) async {
    final habits = await getHabits();
    habits[index]['status'] = status;
    await sharedPreferences.setString('habits', json.encode(habits));
  }

  // Get all habits
  Future<List<Map<String, dynamic>>> getHabits() async {
    final habitsData = sharedPreferences.getString('habits');
    if (habitsData != null) {
      return List<Map<String, dynamic>>.from(json.decode(habitsData));
    }
    return [];
  }
}
