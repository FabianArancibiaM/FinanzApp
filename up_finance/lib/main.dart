import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:up_finance/providers/provider.dart';
import 'package:up_finance/router/app_routes.dart';
import 'package:up_finance/screen/home.screen.dart';
import 'package:up_finance/theme/app_theme.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ParametricDataProvider()),
        ChangeNotifierProvider(create: (_) => TypeMovementProvider()),
        ChangeNotifierProvider(create: (_) => MovementProvider()),
      ],
      child: MaterialApp(
        theme: AppTheme.theme,
        home: const HomeScreen(),
        debugShowCheckedModeBanner: false,
        routes: AppRoutes.getAppRoutes(),
        locale: const Locale('es', 'ES'), // Configura el locale para español
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate, // Para componentes Material
          GlobalWidgetsLocalizations.delegate, // Para widgets
          GlobalCupertinoLocalizations.delegate, // Para widgets Cupertino
        ],
        supportedLocales: const [
          Locale('es', 'ES'), // Español
          Locale('en', 'US'), // Inglés (u otros locales que quieras soportar)
        ],
      ),
    );
  }
}
