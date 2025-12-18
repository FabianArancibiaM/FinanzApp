import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'app.dart';
import 'core/services/finance_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inicializar formato de fechas
  await initializeDateFormatting('es', null);
  
  runApp(
    ChangeNotifierProvider(
      create: (_) => FinanceService(),
      child: const FinanceTrackerApp(),
    ),
  );
}
