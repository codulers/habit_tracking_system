import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/config/routes/routes_name.dart';
import '../../bloc/home_screen_bloc/home_screen_bloc.dart';
import '../../bloc/home_screen_bloc/home_screen_event.dart';
import '../../bloc/home_screen_bloc/home_screen_state.dart';
import 'widgets/habit_list.dart';
import 'widgets/search_and_filter.dart';
import 'widgets/show_completed_checkbox.dart';
import 'widgets/add_new_habit_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'Name'; // Default filter
  bool _showCompletedHabits = false;

  @override
  void initState() {
    super.initState();
    context.read<HomeScreenBloc>().add(LoadHabitsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Habit Tracker", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        centerTitle: true,
        elevation: 4,
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Show this section only if habits are loaded
            BlocBuilder<HomeScreenBloc, HomeScreenState>(
              buildWhen: (previous, current) {
                // Rebuild only when the habits are loaded or search results are updated
                return current is HabitsLoadedState || current is HabitsErrorState;
              },
              builder: (context, state) {
                if (state is HabitsLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is HabitsErrorState) {
                  return Center(child: Text(state.error));
                } else if (state is HabitsLoadedState) {
                  final habits = state.habits;

                  // If no habits, display the message
                  if (habits.isEmpty) {
                    return Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Click on the button below to add new habits.',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                          Icon(
                            Icons.arrow_downward,
                            size: 40,
                            color: Colors.blueAccent,
                          ),
                        ],
                      ),
                    );
                  }

                  // Display habits list
                  return Expanded(
                    child: Column(
                      children: [
                        // Search and Filter Section
                        SearchAndFilter(
                          searchController: _searchController,
                          selectedFilter: _selectedFilter,
                          onSearchChanged: (query) {
                            context.read<HomeScreenBloc>().add(SearchHabitsEvent(
                              query: query,
                              filterOption: _selectedFilter,
                            ));
                          },
                          onFilterChanged: (String? newFilter) {
                            setState(() {
                              _selectedFilter = newFilter!;
                            });
                            context.read<HomeScreenBloc>().add(SearchHabitsEvent(
                              query: _searchController.text,
                              filterOption: _selectedFilter,
                            ));
                          },
                        ),

                        // Show Completed Habits Checkbox
                        ShowCompletedCheckbox(
                          showCompletedHabits: _showCompletedHabits,
                          onChanged: (value) {
                            setState(() {
                              _showCompletedHabits = value!;
                            });
                            context.read<HomeScreenBloc>().add(ShowCompletedHabitsEvent(showCompleted: _showCompletedHabits));
                          },
                        ),

                        // Habit List
                        HabitList(habits: habits),
                      ],
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: AddNewHabitButton(
        onPressed: () {
          Navigator.pushNamedAndRemoveUntil(context, RoutesName.addHabitScreen, (route) => false);
        },
      ),
    );
  }
}