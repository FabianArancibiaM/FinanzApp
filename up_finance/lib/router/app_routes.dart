import 'package:flutter/material.dart';
import 'package:up_finance/screen/add_movement.screen.dart';
import 'package:up_finance/screen/home.screen.dart';

class AppRoutes {
  static Map<String, Widget Function(BuildContext)> getAppRoutes() {
    return {
      'home': (_) => const HomeScreen(),
      'addTrx': (_) => const AddMovementScreen()
    };
  }

  // static Route<dynamic> onGenerateRoute(RouteSettings settings) {
  //   return MaterialPageRoute(builder: (context) => const AlertScreen());
  // }
}
