import 'package:finance_now/screens/financial/details_financial_screen.dart';
import 'package:finance_now/screens/financial/financial_summary_screen.dart';
import 'package:finance_now/screens/form_movement_screen.dart';
import 'package:finance_now/screens/graphics_movement/category_screen.dart';
import 'package:finance_now/screens/graphics_screen.dart';
import 'package:finance_now/screens/home_screen.dart';
import 'package:finance_now/screens/menu_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Map<String, Widget Function(BuildContext)> getAppRoutes() {
    return {
      'menu': (_) => const MenuScreen(),
      'financial-sumary': (_) => FinancialSummaryScreen(),
      'home': (_) => HomeScreen(),
      'graphics': (_) => const GraphicsScreen(),
      'graphics-category': (_) => CategoryScreen(),
      'form-mevement': (_) => const FormMovementScreen(),
      'details-financial': (_) => const DetailsFinancialScreen(),
    };
  }

  // static Route<dynamic> onGenerateRoute(RouteSettings settings) {
  //   return MaterialPageRoute(builder: (context) => const AlertScreen());
  // }
}
