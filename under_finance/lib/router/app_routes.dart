import 'package:flutter/material.dart';
import 'package:under_finance/widget/add_movement.dart';

class AppRoutes {
  static Map<String, Widget Function(BuildContext)> getAppRoutes() {
    return {'add': (_) => const AddMovementScreen()};
  }

  // static Route<dynamic> onGenerateRoute(RouteSettings settings) {
  //   return MaterialPageRoute(builder: (context) => const AlertScreen());
  // }
}
