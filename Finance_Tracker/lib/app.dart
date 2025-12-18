import 'package:flutter/material.dart';
import 'features/home/home_screen.dart';
import 'features/add_movement/add_movement_screen.dart';
import 'features/month_detail/month_detail_screen.dart';
import 'features/settings/settings_screen.dart';
import 'shared/theme/app_theme.dart';

class FinanceTrackerApp extends StatelessWidget {
  const FinanceTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Finance Tracker',
      theme: AppTheme.lightTheme,
      home: const HomeScreen(),
      routes: {
        '/add-movement': (context) => const AddMovementScreen(),
        '/month-detail': (context) => const MonthDetailScreen(),
        '/settings': (context) => const SettingsScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
