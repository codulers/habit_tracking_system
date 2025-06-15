import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/config/routes/routes_name.dart';
import '../../bloc/habit_bloc/habit_bloc.dart';
import '../../bloc/habit_bloc/habit_event.dart';
import '../../bloc/habit_bloc/habit_state.dart';
import '../../../data/utils/flash_bar_helper.dart';
import 'widgets/input_field.dart';
import 'widgets/action_button.dart';
import 'widgets/duration_dialog.dart';

class AddHabitScreen extends StatelessWidget {
  const AddHabitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _nameController = TextEditingController();
    final TextEditingController _descriptionController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Habit", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
        centerTitle: true,
        elevation: 4,
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Habit Name
              InputField(
                controller: _nameController,
                label: "Habit Name",
                hintText: "Enter the habit name",
              ),

              const SizedBox(height: 16),

              // Habit Description
              InputField(
                controller: _descriptionController,
                label: "Description",
                hintText: "Describe the habit",
              ),

              const SizedBox(height: 16),

              // Start Date Button
              ActionButton(
                label: "Select Start Date",
                onPressed: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (picked != null) {
                    context.read<HabitBloc>().add(UpdateStartDateEvent(picked));
                  }
                },
              ),

              const SizedBox(height: 16),

              // Duration Button
              ActionButton(
                label: "Select Duration",
                onPressed: () async {
                  DurationDialog.show(context, (selectedDuration) {
                    context.read<HabitBloc>().add(UpdateDurationEvent(selectedDuration));
                  });
                },
              ),

              const SizedBox(height: 24),

              // BlocListener for Success/Error
              BlocListener<HabitBloc, HabitState>(
                listener: (context, state) {
                  if (state is HabitSuccess) {
                    FlashBarHelper.flashBarErrorMessage(state.message.toString(), context);
                  }
                  if (state is HabitError) {
                    FlashBarHelper.flashBarErrorMessage(state.error.toString(), context);
                  }
                },
                child: ActionButton(
                  label: "Add Habit",
                  onPressed: () {
                    final startDateTime = context.read<HabitBloc>().state.startDateTime ?? DateTime.now();
                    final duration = context.read<HabitBloc>().state.duration ?? Duration(hours: 1);

                    context.read<HabitBloc>().add(AddHabitEvent(
                      name: _nameController.text,
                      description: _descriptionController.text,
                      startDateTime: startDateTime,
                      duration: duration,
                    ));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ActionButton(
          label: "View All Habits",
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(context, RoutesName.homeScreen, (route) => false);
          },
        ),
      ),
    );
  }
}
