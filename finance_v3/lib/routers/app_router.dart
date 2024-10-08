import 'package:finance_v3/screens/common/menu_screen.dart';
import 'package:finance_v3/screens/financial/add_movement_screen.dart';
import 'package:finance_v3/screens/financial/summary_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Map<String, Widget Function(BuildContext)> getAppRoutes() {
    return {
      'menu': (_) => const MenuScreen(),
      'summary': (_) => const SummaryScreen(),
      'add_movement': (_) => const AddMovementScreen(),
    };
  }

  // static Route<dynamic> onGenerateRoute(RouteSettings settings) {
  //   return MaterialPageRoute(builder: (context) => const AlertScreen());
  // }
}
