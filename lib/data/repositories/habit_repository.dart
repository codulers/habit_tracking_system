import 'dart:async';
import '../data_sources/habit_local_data_source.dart';

class HabitRepository {
  final HabitLocalDataSource localDataSource;

  HabitRepository(this.localDataSource);

  // Get all habits from the local data source
  Future<List<Map<String, dynamic>>> getHabits() async {
    return await localDataSource.getHabits();
  }

  // Save habit to local data source
  Future<void> addHabit(Map<String, dynamic> habit) async {
    await localDataSource.saveHabit(habit);
  }

  // Update habit status in the local data source
  Future<void> updateHabitStatus(int index, bool status) async {
    await localDataSource.updateHabitStatus(index, status);
  }
}
