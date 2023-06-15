import 'package:finance_now/providers/financial_movement.dart';
import 'package:finance_now/router/app_routes.dart';
import 'package:finance_now/screens/home_screen.dart';
import 'package:finance_now/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => FinancialMovement())],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: AppTheme.ligthTheme,
          debugShowCheckedModeBanner: false,
          home: HomeScreen(),
          routes: AppRoutes.getAppRoutes()),
    );
  }
}
