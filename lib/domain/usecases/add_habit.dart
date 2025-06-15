
import '../../data/repositories/habit_repository.dart';
import '../entries/habit.dart';

class AddHabit {
  final HabitRepository habitRepository;

  AddHabit(this.habitRepository);

  Future<void> call(Habit habit) async {
    final habitData = {
      'name': habit.name,
      'description': habit.description,
      'startDateTime': habit.startDateTime.toIso8601String(),
      'duration': habit.duration.inMinutes,
    };

    await habitRepository.addHabit(habitData);
  }
}
