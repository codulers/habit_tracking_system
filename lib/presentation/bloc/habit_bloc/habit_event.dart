import 'package:equatable/equatable.dart';

abstract class HabitEvent extends Equatable {
  const HabitEvent();

  @override
  List<Object> get props => [];
}

class AddHabitEvent extends HabitEvent {
  final String name;
  final String description;
  final DateTime startDateTime;
  final Duration duration;

  const AddHabitEvent({
    required this.name,
    required this.description,
    required this.startDateTime,
    required this.duration,
  });

  @override
  List<Object> get props => [name, description, startDateTime, duration];
}

class UpdateStartDateEvent extends HabitEvent {
  final DateTime startDateTime;

  const UpdateStartDateEvent(this.startDateTime);

  @override
  List<Object> get props => [startDateTime];
}

class UpdateDurationEvent extends HabitEvent {
  final Duration duration;

  const UpdateDurationEvent(this.duration);

  @override
  List<Object> get props => [duration];
}
