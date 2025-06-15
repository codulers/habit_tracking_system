
import '../../data/repositories/habit_repository.dart';

class GetHabits {
  final HabitRepository habitRepository;

  GetHabits(this.habitRepository);

  Future<List<Map<String, dynamic>>> call() async {
    return await habitRepository.getHabits();
  }
}
