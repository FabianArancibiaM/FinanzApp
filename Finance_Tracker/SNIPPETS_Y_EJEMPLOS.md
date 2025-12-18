# 💡 Finance Tracker - Snippets y Ejemplos de Código

## 🔧 Snippets Útiles para VS Code

### 1. Crear Nueva Pantalla Flutter
```json
// Agregar en VS Code snippets (Dart)
"Flutter Screen Template": {
  "prefix": "fscreen",
  "body": [
    "import 'package:flutter/material.dart';",
    "import 'package:provider/provider.dart';",
    "import '../core/services/finance_service.dart';",
    "",
    "class ${1:ScreenName}Screen extends StatefulWidget {",
    "  const ${1:ScreenName}Screen({super.key});",
    "",
    "  @override",
    "  State<${1:ScreenName}Screen> createState() => _${1:ScreenName}ScreenState();",
    "}",
    "",
    "class _${1:ScreenName}ScreenState extends State<${1:ScreenName}Screen> {",
    "  @override",
    "  Widget build(BuildContext context) {",
    "    return Scaffold(",
    "      appBar: AppBar(",
    "        title: const Text('${2:Screen Title}'),",
    "      ),",
    "      body: Consumer<FinanceService>(",
    "        builder: (context, financeService, child) {",
    "          if (financeService.isLoading) {",
    "            return const Center(child: CircularProgressIndicator());",
    "          }",
    "",
    "          if (financeService.error != null) {",
    "            return Center(",
    "              child: Text('Error: ${financeService.error}'),",
    "            );",
    "          }",
    "",
    "          return ${3:// Your UI here};",
    "        },",
    "      ),",
    "    );",
    "  }",
    "}"
  ]
}
```

### 2. Widget Consumer
```json
"Provider Consumer": {
  "prefix": "pconsumer",
  "body": [
    "Consumer<FinanceService>(",
    "  builder: (context, financeService, child) {",
    "    return ${1:Widget}();",
    "  },",
    ")"
  ]
}
```

### 3. Card con Padding Estándar
```json
"Standard Card": {
  "prefix": "scard",
  "body": [
    "Card(",
    "  child: Padding(",
    "    padding: const EdgeInsets.all(16),",
    "    child: ${1:child},",
    "  ),",
    ")"
  ]
}
```

## 🎯 Ejemplos de Funcionalidades Extendidas

### 1. Sistema de Notificaciones
```dart
// notifications_service.dart
import 'package:flutter/material.dart';

class NotificationsService {
  static void showSnackBar(BuildContext context, String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'OK',
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  static void showBottomSheet(BuildContext context, Widget content) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: content,
      ),
    );
  }
}

// Uso en screens:
NotificationsService.showSnackBar(context, 'Movimiento agregado exitosamente!');
```

### 2. Validador de Formularios Personalizado
```dart
// form_validators.dart
class FormValidators {
  static String? validateAmount(String? value) {
    if (value == null || value.isEmpty) {
      return 'El monto es requerido';
    }
    
    final amount = double.tryParse(value);
    if (amount == null) {
      return 'Ingresa un número válido';
    }
    
    if (amount <= 0) {
      return 'El monto debe ser mayor a 0';
    }
    
    if (amount > 999999999) {
      return 'El monto es demasiado grande';
    }
    
    return null;
  }

  static String? validateCategory(String? value) {
    if (value == null || value.isEmpty) {
      return 'Selecciona una categoría';
    }
    return null;
  }

  static String? validateDescription(String? value, {bool required = false}) {
    if (required && (value == null || value.isEmpty)) {
      return 'La descripción es requerida';
    }
    
    if (value != null && value.length > 100) {
      return 'La descripción debe tener menos de 100 caracteres';
    }
    
    return null;
  }
}

// Uso en forms:
TextFormField(
  validator: FormValidators.validateAmount,
  // ...
)
```

### 3. Widget de Estadísticas Avanzadas
```dart
// statistics_card.dart
import 'package:flutter/material.dart';
import '../core/services/finance_service.dart';

class StatisticsCard extends StatelessWidget {
  final FinanceService financeService;
  
  const StatisticsCard({super.key, required this.financeService});

  @override
  Widget build(BuildContext context) {
    final movements = financeService.movements;
    final stats = _calculateStats(movements);
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Estadísticas del Mes',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            _buildStatRow('Total Transacciones', stats.totalTransactions.toString()),
            _buildStatRow('Promedio por Día', FormatUtils.formatCurrency(stats.avgPerDay)),
            _buildStatRow('Transacción Más Grande', FormatUtils.formatCurrency(stats.largestTransaction)),
            _buildStatRow('Categoría Top', stats.topCategory),
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  MonthlyStats _calculateStats(List<Movement> movements) {
    final now = DateTime.now();
    final currentMonth = movements.where((m) => 
      m.date.year == now.year && m.date.month == now.month
    ).toList();

    final totalTransactions = currentMonth.length;
    final avgPerDay = totalTransactions > 0 
        ? currentMonth.map((m) => m.amount.abs()).reduce((a, b) => a + b) / now.day
        : 0.0;
    
    final largestTransaction = currentMonth.isNotEmpty
        ? currentMonth.map((m) => m.amount.abs()).reduce((a, b) => a > b ? a : b)
        : 0.0;
    
    final categoryCount = <String, int>{};
    for (var movement in currentMonth) {
      categoryCount[movement.category] = (categoryCount[movement.category] ?? 0) + 1;
    }
    
    final topCategory = categoryCount.isNotEmpty
        ? categoryCount.entries.reduce((a, b) => a.value > b.value ? a : b).key
        : 'N/A';

    return MonthlyStats(
      totalTransactions: totalTransactions,
      avgPerDay: avgPerDay,
      largestTransaction: largestTransaction,
      topCategory: topCategory,
    );
  }
}

class MonthlyStats {
  final int totalTransactions;
  final double avgPerDay;
  final double largestTransaction;
  final String topCategory;

  MonthlyStats({
    required this.totalTransactions,
    required this.avgPerDay,
    required this.largestTransaction,
    required this.topCategory,
  });
}
```

### 4. Buscador de Movimientos
```dart
// search_delegate.dart
import 'package:flutter/material.dart';
import '../core/models/movement.dart';
import '../core/utils/format.dart';

class MovementsSearchDelegate extends SearchDelegate<Movement?> {
  final List<Movement> movements;

  MovementsSearchDelegate(this.movements);

  @override
  String get searchFieldLabel => 'Buscar movimientos...';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults();
  }

  Widget _buildSearchResults() {
    final filteredMovements = movements.where((movement) {
      final queryLower = query.toLowerCase();
      return movement.category.toLowerCase().contains(queryLower) ||
             (movement.description?.toLowerCase().contains(queryLower) ?? false) ||
             FormatUtils.formatCurrency(movement.amount).contains(query);
    }).toList();

    if (filteredMovements.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text('No se encontraron movimientos'),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: filteredMovements.length,
      itemBuilder: (context, index) {
        final movement = filteredMovements[index];
        return ListTile(
          leading: Icon(
            movement.amount > 0 ? Icons.add_circle : Icons.remove_circle,
            color: movement.amount > 0 ? Colors.green : Colors.red,
          ),
          title: Text(movement.category),
          subtitle: Text(FormatUtils.formatDate(movement.date)),
          trailing: Text(
            FormatUtils.formatCurrency(movement.amount),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: movement.amount > 0 ? Colors.green : Colors.red,
            ),
          ),
          onTap: () => close(context, movement),
        );
      },
    );
  }
}

// Uso en HomeScreen:
AppBar(
  title: Text('Finance Tracker'),
  actions: [
    IconButton(
      icon: const Icon(Icons.search),
      onPressed: () {
        showSearch(
          context: context,
          delegate: MovementsSearchDelegate(financeService.movements),
        );
      },
    ),
  ],
)
```

### 5. Sistema de Backup/Restauración
```dart
// backup_service.dart
import 'dart:convert';
import 'dart:html' as html;
import '../models/movement.dart';

class BackupService {
  static void exportData(List<Movement> movements) {
    final jsonData = {
      'version': '1.0',
      'exportDate': DateTime.now().toIso8601String(),
      'movements': movements.map((m) => m.toJson()).toList(),
    };

    final jsonString = const JsonEncoder.withIndent('  ').convert(jsonData);
    final bytes = utf8.encode(jsonString);
    final blob = html.Blob([bytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    
    final anchor = html.AnchorElement()
      ..href = url
      ..style.display = 'none'
      ..download = 'finance_backup_${DateTime.now().millisecondsSinceEpoch}.json';
    
    html.document.body?.children.add(anchor);
    anchor.click();
    html.document.body?.children.remove(anchor);
    html.Url.revokeObjectUrl(url);
  }

  static Future<List<Movement>?> importData() async {
    final completer = Completer<List<Movement>?>();
    
    final input = html.FileUploadInputElement()..accept = '.json';
    input.click();
    
    input.onChange.listen((e) async {
      final files = input.files;
      if (files?.isEmpty ?? true) {
        completer.complete(null);
        return;
      }

      final file = files!.first;
      final reader = html.FileReader();
      
      reader.onLoad.listen((e) {
        try {
          final content = reader.result as String;
          final jsonData = jsonDecode(content) as Map<String, dynamic>;
          
          final movementsList = jsonData['movements'] as List;
          final movements = movementsList
              .map((m) => Movement.fromJson(m as Map<String, dynamic>))
              .toList();
          
          completer.complete(movements);
        } catch (e) {
          print('Error importing data: $e');
          completer.complete(null);
        }
      });
      
      reader.readAsText(file);
    });
    
    return completer.future;
  }
}

// Uso en SettingsScreen:
ElevatedButton(
  onPressed: () {
    BackupService.exportData(financeService.movements);
    NotificationsService.showSnackBar(context, 'Datos exportados exitosamente!');
  },
  child: const Text('Exportar Datos'),
),

ElevatedButton(
  onPressed: () async {
    final movements = await BackupService.importData();
    if (movements != null) {
      await financeService.importMovements(movements);
      NotificationsService.showSnackBar(context, 'Datos importados exitosamente!');
    }
  },
  child: const Text('Importar Datos'),
),
```

### 6. Widget de Gráfico Simple (sin dependencias externas)
```dart
// simple_chart.dart
import 'package:flutter/material.dart';
import 'dart:math' as math;

class SimpleBarChart extends StatelessWidget {
  final List<double> values;
  final List<String> labels;
  final Color? color;

  const SimpleBarChart({
    super.key,
    required this.values,
    required this.labels,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    if (values.isEmpty) return const SizedBox();

    final maxValue = values.reduce(math.max);
    final theme = Theme.of(context);
    final barColor = color ?? theme.colorScheme.primary;

    return Container(
      height: 200,
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(values.length, (index) {
          final value = values[index];
          final height = (value / maxValue) * 150;
          
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: height,
                    decoration: BoxDecoration(
                      color: barColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    labels[index],
                    style: theme.textTheme.bodySmall,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

// Uso:
SimpleBarChart(
  values: [100000, 150000, 80000, 200000, 120000],
  labels: ['Ene', 'Feb', 'Mar', 'Abr', 'May'],
  color: Colors.green,
)
```

## 🔄 Patterns de Estado Avanzados

### 1. Estado con AsyncValue
```dart
// async_value.dart
class AsyncValue<T> {
  final T? data;
  final Object? error;
  final bool isLoading;

  const AsyncValue._({this.data, this.error, this.isLoading = false});

  factory AsyncValue.data(T data) => AsyncValue._(data: data);
  factory AsyncValue.error(Object error) => AsyncValue._(error: error);
  factory AsyncValue.loading() => AsyncValue._(isLoading: true);

  bool get hasData => data != null;
  bool get hasError => error != null;

  R when<R>({
    required R Function(T data) data,
    required R Function(Object error) error,
    required R Function() loading,
  }) {
    if (isLoading) return loading();
    if (hasError) return error(this.error!);
    return data(this.data as T);
  }
}

// Uso en FinanceService:
class FinanceService extends ChangeNotifier {
  AsyncValue<List<Movement>> _movements = AsyncValue.loading();
  
  AsyncValue<List<Movement>> get movements => _movements;

  Future<void> loadMovements() async {
    _movements = AsyncValue.loading();
    notifyListeners();

    try {
      final data = await _dao.getAll();
      _movements = AsyncValue.data(data);
    } catch (e) {
      _movements = AsyncValue.error(e);
    }
    notifyListeners();
  }
}

// Uso en UI:
Consumer<FinanceService>(
  builder: (context, service, child) {
    return service.movements.when(
      data: (movements) => ListView.builder(/* ... */),
      error: (error) => Center(child: Text('Error: $error')),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  },
)
```

### 2. Repository Pattern
```dart
// movements_repository.dart
abstract class MovementsRepository {
  Future<List<Movement>> getMovements();
  Future<void> saveMovement(Movement movement);
  Future<void> deleteMovement(String id);
  Future<void> updateMovement(Movement movement);
  Stream<List<Movement>> watchMovements();
}

class MovementsRepositoryImpl implements MovementsRepository {
  final MovementsDAO _localDao;
  final MovementsAPI? _remoteApi;

  MovementsRepositoryImpl(this._localDao, [this._remoteApi]);

  @override
  Future<List<Movement>> getMovements() async {
    try {
      // Intentar obtener datos remotos primero
      if (_remoteApi != null) {
        final remoteMovements = await _remoteApi!.getMovements();
        await _syncWithLocal(remoteMovements);
        return remoteMovements;
      }
    } catch (e) {
      // Fallback a datos locales
      print('Failed to fetch remote data: $e');
    }
    
    return _localDao.getAll();
  }

  Future<void> _syncWithLocal(List<Movement> remoteMovements) async {
    // Lógica de sincronización
    for (final movement in remoteMovements) {
      await _localDao.insert(movement);
    }
  }
}
```

## 🧪 Testing Examples

### 1. Unit Tests
```dart
// test/finance_service_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../lib/core/services/finance_service.dart';
import '../lib/core/dao/movements_dao.dart';
import '../lib/core/models/movement.dart';

class MockMovementsDAO extends Mock implements MovementsDAO {}

void main() {
  group('FinanceService', () {
    late FinanceService financeService;
    late MockMovementsDAO mockDao;

    setUp(() {
      mockDao = MockMovementsDAO();
      financeService = FinanceService(mockDao);
    });

    test('calculates current month balance correctly', () {
      // Arrange
      final movements = [
        Movement(
          id: '1',
          amount: 100000,
          category: 'Salario',
          date: DateTime.now(),
        ),
        Movement(
          id: '2',
          amount: -50000,
          category: 'Supermercado',
          date: DateTime.now(),
        ),
      ];
      
      when(mockDao.getAll()).thenAnswer((_) async => movements);

      // Act
      financeService.loadMovements();

      // Assert
      expect(financeService.getCurrentMonthBalance(), 50000);
    });
  });
}
```

### 2. Widget Tests
```dart
// test/home_screen_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import '../lib/features/home/home_screen.dart';
import '../lib/core/services/finance_service.dart';

void main() {
  testWidgets('HomeScreen shows balance card', (tester) async {
    // Arrange
    final financeService = FinanceService();
    
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider.value(
          value: financeService,
          child: const HomeScreen(),
        ),
      ),
    );

    // Assert
    expect(find.byType(BalanceCard), findsOneWidget);
    expect(find.text('Balance Actual'), findsOneWidget);
  });
}
```

---

> **💡 Consejo:** Guarda estos snippets en VS Code usando Ctrl+Shift+P → "Configure User Snippets" → "dart.json" para acceso rápido durante el desarrollo.
