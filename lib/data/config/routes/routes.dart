import 'package:flutter/material.dart';
import 'package:habit_tracking_system/data/config/routes/routes_name.dart';
import 'package:habit_tracking_system/presentation/screens/view.dart';


class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splashScreen:
        return MaterialPageRoute(builder: (BuildContext context) => const SplashScreen());

      case RoutesName.homeScreen:
        return MaterialPageRoute(builder: (BuildContext context) => const HomeScreen());

      case RoutesName.addHabitScreen:
        return MaterialPageRoute(builder: (BuildContext context) => const AddHabitScreen());

      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text('No route defined'),
            ),
          );
        });
    }
  }
}