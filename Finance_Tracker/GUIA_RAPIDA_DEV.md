# 🚀 Finance Tracker - Guía Rápida para Desarrolladores

## ⚡ Quick Start

### Comandos Esenciales
```bash
# Ejecutar aplicación web
flutter run -d chrome

# Hot reload (durante desarrollo)
r

# Hot restart (reiniciar estado)
R

# Build para producción web
flutter build web

# Verificar dependencias
flutter pub get

# Análisis de código
flutter analyze

# Tests (cuando se implementen)
flutter test
```

### Estructura de Carpetas Críticas
```
lib/
├── main.dart                    # ⚠️  Entry point - NO MODIFICAR sin considerar providers
├── core/
│   ├── services/finance_service.dart  # 🎯 LÓGICA CENTRAL - Principal lugar de cambios
│   ├── utils/format.dart              # 💰 Formato moneda chilena
│   └── dao/                           # 📊 Capa de datos
├── features/                          # 🎨 Pantallas de la app
└── shared/widgets/                    # 🧩 Componentes reutilizables
```

## 🛠️ Modificaciones Comunes

### 1. Agregar Nueva Categoría
**Archivo:** `lib/core/utils/categories.dart`
```dart
// Agregar en la lista correspondiente:
static const List<String> incomeCategories = [
  'Salario',
  'Freelance',
  'Inversiones',
  'NUEVA_CATEGORIA', // ← Agregar aquí
];
```

### 2. Cambiar Formato de Moneda
**Archivo:** `lib/core/utils/format.dart`
```dart
static String formatCurrency(double amount) {
  // Modificar lógica de formato aquí
  // Actual: $ 100.000 (punto como separador de miles)
}
```

### 3. Agregar Nueva Pantalla
**Pasos:**
1. Crear archivo en `lib/features/nueva_pantalla/`
2. Registrar ruta en `main.dart`
3. Agregar navegación desde pantalla existente

### 4. Modificar Cálculos Financieros
**Archivo:** `lib/core/services/finance_service.dart`
```dart
// Métodos principales:
- getCurrentMonthBalance()    # Balance actual
- getCurrentMonthIncome()     # Ingresos del mes
- getCurrentMonthExpenses()   # Gastos del mes
- getMonthEndProjection()     # Proyección fin de mes
```

## 🎯 Features Más Solicitados (Ready to Implement)

### 1. Persistencia Local (Web)
```dart
// En movements_dao.dart, cambiar de InMemory a:
import 'dart:html' as html;

class WebMovementsDAO implements MovementsDAO {
  static const String _storageKey = 'finance_movements';
  
  @override
  Future<void> insert(Movement movement) async {
    var movements = await getAll();
    movements.add(movement);
    _saveToLocalStorage(movements);
  }
  
  void _saveToLocalStorage(List<Movement> movements) {
    html.window.localStorage[_storageKey] = 
        jsonEncode(movements.map((m) => m.toJson()).toList());
  }
}
```

### 2. Exportar Datos CSV
```dart
// En finance_service.dart:
String exportToCsv() {
  final buffer = StringBuffer();
  buffer.writeln('Fecha,Categoría,Tipo,Monto');
  
  for (var movement in _movements) {
    buffer.writeln('${movement.date.toIso8601String()},'
        '${movement.category},'
        '${movement.amount > 0 ? "Ingreso" : "Gasto"},'
        '${movement.amount}');
  }
  
  return buffer.toString();
}
```

### 3. Filtros por Categoría
```dart
// En finance_service.dart:
List<Movement> getMovementsByCategory(String category) {
  return _movements
      .where((m) => m.category == category)
      .toList();
}

// En UI, agregar FilterChip widgets
```

### 4. Gráficos de Gastos
```dart
// Dependencia a agregar:
dependencies:
  fl_chart: ^0.65.0

// Implementar PieChart para categorías
// Implementar LineChart para tendencias mensualess
```

## 🐛 Debugging Común

### Error: "Provider not found"
```dart
// Solución: Verificar que el widget esté dentro del ChangeNotifierProvider
Consumer<FinanceService>(
  builder: (context, service, child) {
    // Tu código aquí
  },
)

// O usar:
context.read<FinanceService>().metodo();
context.watch<FinanceService>().dato;
```

### Error: "setState called during build"
```dart
// Problema: Llamar notifyListeners() durante build
// Solución: Usar addPostFrameCallback
WidgetsBinding.instance.addPostFrameCallback((_) {
  // Tu código que causa rebuild
});
```

### Error: Formato de fecha
```dart
// Problema: Diferentes formatos de fecha
// Solución: Usar intl package y locale 'es'
import 'package:intl/intl.dart';

DateFormat('dd/MM/yyyy', 'es').format(date);
```

## 🎨 Personalización UI

### Cambiar Tema de Colores
**Archivo:** `lib/main.dart`
```dart
MaterialApp(
  theme: ThemeData(
    primarySwatch: Colors.blue,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Color(0xFF2E8B57), // Cambiar color principal
    ),
  ),
)
```

### Modificar BalanceCard
**Archivo:** `lib/shared/widgets/balance_card.dart`
```dart
// Cambiar gradiente:
gradient: LinearGradient(
  colors: balance >= 0 
    ? [Colors.green.shade400, Colors.green.shade600]
    : [Colors.red.shade400, Colors.red.shade600],
)
```

## 📱 Testing

### Setup Tests (Cuando se implementen)
```dart
// En pubspec.yaml:
dev_dependencies:
  flutter_test:
    sdk: flutter
  mockito: ^5.4.2

// Ejemplo test básico:
testWidgets('HomeScreen shows balance', (WidgetTester tester) async {
  await tester.pumpWidget(
    ChangeNotifierProvider(
      create: (_) => FinanceService(),
      child: MaterialApp(home: HomeScreen()),
    ),
  );
  
  expect(find.byType(BalanceCard), findsOneWidget);
});
```

## 🔄 Git Workflow Sugerido

```bash
# Feature nueva
git checkout -b feature/nueva-funcionalidad
git add .
git commit -m "feat: agregar nueva funcionalidad"

# Bugfix
git checkout -b fix/corregir-error
git add .
git commit -m "fix: corregir error en cálculo"

# Refactoring
git checkout -b refactor/mejorar-codigo
git add .
git commit -m "refactor: optimizar performance"
```

## 📊 Métricas de Performance

### Comandos Útiles
```bash
# Analizar tamaño de build
flutter build web --analyze-size

# Profile performance
flutter run --profile

# Verificar memory usage
flutter run --observatory-port=8080
```

### Targets de Performance
- **First Load:** < 3s
- **Navigation:** < 200ms
- **Memory Usage:** < 100MB
- **Bundle Size:** < 2MB

## 🚨 Alertas de Seguridad

### ⚠️ NO HACER
- ❌ Hardcodear URLs de API
- ❌ Almacenar datos sensibles en SharedPreferences sin encriptar
- ❌ Ignorar validaciones del lado cliente
- ❌ Hacer commits con datos reales de usuarios

### ✅ HACER
- ✅ Validar todos los inputs
- ✅ Usar constantes para configuración
- ✅ Implementar error handling
- ✅ Mantener dependencias actualizadas

## 📞 Contactos de Emergencia

### Si algo se rompe:
1. **Flutter Doctor**: `flutter doctor -v`
2. **Clean Project**: `flutter clean && flutter pub get`
3. **Restart IDE**: Cerrar y abrir VS Code
4. **Check Git**: `git status` para ver cambios

### Logs Útiles:
- **Web Console**: F12 → Console tab
- **Flutter Inspector**: En VS Code, panel lateral
- **Performance**: Flutter Inspector → Performance tab

---

> **💡 Tip:** Mantén este archivo abierto como referencia rápida mientras desarrollas. Los comandos más usados están al principio para acceso rápido.
