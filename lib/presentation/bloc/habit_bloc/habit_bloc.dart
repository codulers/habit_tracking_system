import 'package:bloc/bloc.dart';
import 'package:habit_tracking_system/domain/entries/habit.dart';

import '../../../domain/usecases/add_habit.dart';
import 'habit_event.dart';
import 'habit_state.dart';

class HabitBloc extends Bloc<HabitEvent, HabitState> {
  final AddHabit addHabit;

  HabitBloc(this.addHabit) : super(HabitInitial()) {
    on<AddHabitEvent>(_onAddHabit);
    on<UpdateStartDateEvent>(_onUpdateStartDate);
    on<UpdateDurationEvent>(_onUpdateDuration);
  }

  // Handle adding a habit
  void _onAddHabit(AddHabitEvent event, Emitter<HabitState> emit) async {
    try {
      final habit = Habit(
        name: event.name,
        description: event.description,
        startDateTime: state.startDateTime ?? DateTime.now(),
        duration: state.duration ?? Duration(hours: 1),
      );
      await addHabit.call(habit);
      emit(HabitSuccess('Habit added successfully'));
    } catch (e) {
      emit(HabitError('Failed to add habit'));
    }
  }

  // Handle start date update
  void _onUpdateStartDate(UpdateStartDateEvent event, Emitter<HabitState> emit) {
    emit(state.copyWith(startDateTime: event.startDateTime));
  }

  // Handle duration update
  void _onUpdateDuration(UpdateDurationEvent event, Emitter<HabitState> emit) {
    emit(state.copyWith(duration: event.duration));
  }
}
