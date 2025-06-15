import 'package:equatable/equatable.dart';

class HomeScreenState extends Equatable {
  const HomeScreenState();

  @override
  List<Object> get props => [];
}

class HabitsLoadingState extends HomeScreenState {}

class HabitsErrorState extends HomeScreenState {
  final String error;

  const HabitsErrorState(this.error);

  @override
  List<Object> get props => [error];
}

class HabitsLoadedState extends HomeScreenState {
  final List<Map<String, dynamic>> habits;

  const HabitsLoadedState(this.habits);

  @override
  List<Object> get props => [habits];
}
