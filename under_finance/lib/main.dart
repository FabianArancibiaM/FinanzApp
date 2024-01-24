import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:under_finance/provider/category_provider.dart';
import 'package:under_finance/provider/movement_provider.dart';
import 'package:under_finance/provider/type_movement_provider.dart';
import 'package:under_finance/router/app_routes.dart';
import 'package:under_finance/theme/app_theme.dart';
import 'package:under_finance/widget/menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CategoryProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TypeMovementProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => MovementProvider(),
        )
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: AppTheme.ligthTheme,
          home: const MenuScreen(),
          debugShowCheckedModeBanner: false,
          routes: AppRoutes.getAppRoutes()),
    );
  }
}

MaterialColor materialColor(Color color) {
  return MaterialColor(
    color.value,
    <int, Color>{
      50: color.withOpacity(0.1),
      100: color.withOpacity(0.2),
      200: color.withOpacity(0.3),
      300: color.withOpacity(0.4),
      400: color.withOpacity(0.5),
      500: color.withOpacity(0.6),
      600: color.withOpacity(0.7),
      700: color.withOpacity(0.8),
      800: color.withOpacity(0.9),
      900: color,
    },
  );
}
