import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracking_system/presentation/bloc/habit_bloc/habit_bloc.dart';
import 'package:habit_tracking_system/presentation/bloc/home_screen_bloc/home_screen_bloc.dart';
import 'package:habit_tracking_system/presentation/screens/home/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/config/routes/routes.dart';
import 'data/config/routes/routes_name.dart';
import 'data/data_sources/habit_local_data_source.dart';
import 'data/repositories/habit_repository.dart';
import 'domain/usecases/add_habit.dart';
import 'domain/usecases/get_habits.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final habitRepository = HabitRepository(HabitLocalDataSource(prefs));

  runApp(MyApp(
    habitRepository: habitRepository,
  ));
}

class MyApp extends StatelessWidget {
  final HabitRepository habitRepository;

  const MyApp({super.key, required this.habitRepository});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_)=> HabitBloc(AddHabit(habitRepository))),
          BlocProvider(create: (_)=> HomeScreenBloc(habitRepository)),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Habit Tracker',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          initialRoute: RoutesName.splashScreen,
          onGenerateRoute: Routes.generateRoute,
        ),
    );
  }
}
