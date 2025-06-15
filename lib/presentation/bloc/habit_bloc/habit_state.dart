import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class HabitState extends Equatable {
  final String? name;
  final String? description;
  final DateTime? startDateTime;
  final Duration? duration;

  const HabitState({
    this.name,
    this.description,
    this.startDateTime,
    this.duration,
  });

  HabitState copyWith({
    String? name,
    String? description,
    DateTime? startDateTime,
    Duration? duration,
  }) {
    return HabitState(
      name: name ?? this.name,
      description: description ?? this.description,
      startDateTime: startDateTime ?? this.startDateTime,
      duration: duration ?? this.duration,
    );
  }

  @override
  List<Object?> get props => [name, description, startDateTime, duration];
}

class HabitInitial extends HabitState {}

class HabitSuccess extends HabitState {
  final String message;
  const HabitSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class HabitError extends HabitState {
  final String error;
  const HabitError(this.error);

  @override
  List<Object?> get props => [error];
}
