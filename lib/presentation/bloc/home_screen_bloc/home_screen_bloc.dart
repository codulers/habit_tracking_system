import 'package:bloc/bloc.dart';

import '../../../data/repositories/habit_repository.dart';
import '../../../domain/usecases/get_habits.dart';
import 'home_screen_event.dart';
import 'home_screen_state.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  final HabitRepository habitRepository;
  late GetHabits getHabits;
  bool showCompletedHabits = false;

  HomeScreenBloc(this.habitRepository) : super(HabitsLoadingState()) {
    getHabits = GetHabits(habitRepository); // Initialize GetHabits use case
    on<LoadHabitsEvent>(_onLoadHabits);
    on<SearchHabitsEvent>(_onSearchHabits);
    on<ToggleHabitStatusEvent>(_onToggleHabitStatus);
    on<ShowCompletedHabitsEvent>(_onShowCompletedHabits);  // New event for show completed habits
  }

  // Handle loading habits
  void _onLoadHabits(LoadHabitsEvent event, Emitter<HomeScreenState> emit) async {
    emit(HabitsLoadingState());
    try {
      final habits = await getHabits.call();
      emit(HabitsLoadedState(habits));
    } catch (e) {
      emit(HabitsErrorState('Failed to load habits'));
    }
  }

  // Handle search functionality
  void _onSearchHabits(SearchHabitsEvent event, Emitter<HomeScreenState> emit) async {
    emit(HabitsLoadingState());
    try {
      final habits = await getHabits.call();

      List<Map<String, dynamic>> filteredHabits = habits.where((habit) {
        final nameMatches = habit['name']
            .toLowerCase()
            .contains(event.query.toLowerCase());
        final descriptionMatches = habit['description']
            .toLowerCase()
            .contains(event.query.toLowerCase());
        final startDateMatches = habit['startDateTime']
            .toLowerCase()
            .contains(event.query.toLowerCase());

        if (event.filterOption == 'Name') {
          return nameMatches;
        } else if (event.filterOption == 'Description') {
          return descriptionMatches;
        } else if (event.filterOption == 'Start Date') {
          return startDateMatches;
        } else {
          return false;
        }
      }).toList();

      emit(HabitsLoadedState(filteredHabits));
    } catch (e) {
      emit(HabitsErrorState('Failed to load habits'));
    }
  }

  // Handle toggling habit status
  void _onToggleHabitStatus(ToggleHabitStatusEvent event, Emitter<HomeScreenState> emit) async {
    try {
      // Update the habit status in shared preferences
      await habitRepository.updateHabitStatus(event.habitIndex, event.newStatus);

      // Reload habits to reflect updated status
      final habits = await habitRepository.getHabits();
      emit(HabitsLoadedState(habits));
    } catch (e) {
      emit(HabitsErrorState('Failed to update habit status'));
    }
  }

  // Handle showing completed habits
  void _onShowCompletedHabits(ShowCompletedHabitsEvent event, Emitter<HomeScreenState> emit) async {
    showCompletedHabits = event.showCompleted;
    emit(HabitsLoadingState());

    try {
      final habits = await habitRepository.getHabits();
      List<Map<String, dynamic>> filteredHabits;

      // If the "Show Completed" is true, only show habits marked as completed
      if (showCompletedHabits) {
        filteredHabits = habits.where((habit) => habit['status'] == true).toList();
      } else {
        filteredHabits = habits; // Show all habits if "Show Completed" is false
      }

      emit(HabitsLoadedState(filteredHabits));
    } catch (e) {
      emit(HabitsErrorState('Failed to load habits'));
    }
  }
}
