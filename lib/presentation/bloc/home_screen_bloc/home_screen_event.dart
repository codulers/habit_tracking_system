import 'package:equatable/equatable.dart';

abstract class HomeScreenEvent extends Equatable {
  const HomeScreenEvent();

  @override
  List<Object> get props => [];
}

class LoadHabitsEvent extends HomeScreenEvent {}

class SearchHabitsEvent extends HomeScreenEvent {
  final String query;
  final String filterOption;

  const SearchHabitsEvent({required this.query, required this.filterOption});

  @override
  List<Object> get props => [query, filterOption];
}

class ToggleHabitStatusEvent extends HomeScreenEvent {
  final int habitIndex;
  final bool newStatus;

  const ToggleHabitStatusEvent({required this.habitIndex, required this.newStatus});

  @override
  List<Object> get props => [habitIndex, newStatus];
}

// New event to filter completed habits
class ShowCompletedHabitsEvent extends HomeScreenEvent {
  final bool showCompleted;

  const ShowCompletedHabitsEvent({required this.showCompleted});

  @override
  List<Object> get props => [showCompleted];
}
