# 📊 Finance Tracker - Documentación Técnica Completa

## 🎯 Descripción del Proyecto

**Finance Tracker** es una aplicación móvil MVP desarrollada en Flutter para el control y análisis básico de finanzas personales. La aplicación está diseñada para uso personal, sin login, backend o dependencias cloud, manteniendo toda la información localmente.

### ✅ Estado Actual: FUNCIONAL
- ✅ Aplicación web completamente operativa
- ✅ Formato de moneda chilena ($ 100.000)
- ✅ Persistencia en memoria (web-compatible)
- ✅ Todas las funcionalidades core implementadas

---

## 🏗️ Arquitectura del Proyecto

### 📁 Estructura de Directorios

```
lib/
├── main.dart                           → Entry point de la aplicación
├── app.dart                            → MaterialApp + configuración de rutas
│
├── core/                               → Núcleo de la aplicación
│   ├── db/                            → Capa de datos
│   │   ├── database.dart              → Implementación SQLite (móvil)
│   │   ├── movements_dao.dart         → DAO SQLite con operaciones CRUD
│   │   ├── web_database.dart          → Factory para web/móvil
│   │   └── web_movements_dao.dart     → DAO en memoria (web)
│   │
│   ├── models/                        → Modelos de datos
│   │   └── movement.dart              → Modelo Movement con validaciones
│   │
│   ├── services/                      → Lógica de negocio
│   │   └── finance_service.dart      → Servicio principal con Provider
│   │
│   ├── utils/                         → Utilidades
│   │   └── format.dart               → Formateo de moneda, fechas, etc.
│   │
│   └── constants/                     → Constantes
│       └── categories.dart           → Categorías predefinidas chilenas
│
├── features/                          → Funcionalidades por pantalla
│   ├── home/                         → Pantalla principal
│   │   └── home_screen.dart         → Dashboard con balance y resumen
│   │
│   ├── add_movement/                 → Agregar movimientos
│   │   └── add_movement_screen.dart → Formulario con tabs ingreso/gasto
│   │
│   ├── month_detail/                 → Detalle mensual
│   │   └── month_detail_screen.dart → Vista completa de movimientos
│   │
│   └── settings/                     → Configuración
│       └── settings_screen.dart     → Información y configuraciones
│
└── shared/                           → Componentes compartidos
    ├── widgets/                      → Widgets reutilizables
    │   ├── balance_card.dart        → Tarjeta de balance principal
    │   └── movement_tile.dart       → Item de lista de movimientos
    │
    └── theme/                        → Tema y colores
        └── app_theme.dart           → Configuración Material 3
```

---

## 📋 Componentes Principales

### 🔧 **Core Components**

#### 1. **Movement Model** (`core/models/movement.dart`)
```dart
class Movement {
  final int? id;
  final double amount;     // Positivo = ingreso, negativo = gasto
  final String category;
  final DateTime date;
  
  // Getters calculados
  bool get isIncome => amount > 0;
  bool get isExpense => amount < 0;
  double get absoluteAmount => amount.abs();
}
```

**Funcionalidades:**
- Serialización/deserialización JSON
- Validaciones de tipos
- Cálculos automáticos de ingreso/gasto

#### 2. **FinanceService** (`core/services/finance_service.dart`)
**Patrón:** ChangeNotifier (Provider)

```dart
class FinanceService extends ChangeNotifier {
  // Estado
  List<Movement> _movements = [];
  bool _isLoading = false;
  String? _error;
  
  // Operaciones CRUD
  Future<bool> addMovement(Movement movement);
  Future<bool> deleteMovement(int id);
  
  // Cálculos de negocio
  double getCurrentMonthBalance();
  double getCurrentMonthIncome();
  double getCurrentMonthExpenses();
  double getMonthEndProjection();
}
```

**Responsabilidades:**
- Gestión de estado global
- CRUD de movimientos
- Cálculos financieros
- Proyecciones automáticas
- Notificación de cambios a la UI

#### 3. **Data Access Layer**

##### **Abstracción DAO** (`core/db/web_movements_dao.dart`)
```dart
abstract class MovementsDAO {
  Future<int> insert(Movement movement);
  Future<List<Movement>> getAll();
  Future<List<Movement>> getByMonth(int year, int month);
  Future<int> delete(int id);
  // ... más métodos
}
```

##### **Implementaciones:**
- **`InMemoryMovementsDAO`**: Para web (actual)
- **`SqliteMovementsDAO`**: Para móvil (preparado)

#### 4. **FormatUtils** (`core/utils/format.dart`)
**Formato chileno implementado:**
```dart
static String formatCurrency(double amount) {
  // Genera: $ 100.000, $ 1.500.000, -$ 50.000
  final formatter = NumberFormat('#,###', 'es');
  final formattedNumber = formatter.format(absAmount).replaceAll(',', '.');
  return '$prefix$formattedNumber';
}
```

### 🎨 **UI Components**

#### 1. **BalanceCard** (`shared/widgets/balance_card.dart`)
**Widget principal del dashboard:**

```dart
BalanceCard({
  required double balance,
  required double income,
  required double expenses,
  required double projection,
  VoidCallback? onTap,
})
```

**Características:**
- Gradiente dinámico (verde/rojo según balance)
- Resumen de ingresos/gastos
- Proyección de fin de mes
- Navegación al detalle mensual

#### 2. **MovementTile** (`shared/widgets/movement_tile.dart`)
**Item de lista de movimientos:**

```dart
MovementTile({
  required Movement movement,
  VoidCallback? onTap,
  VoidCallback? onLongPress,  // Para eliminar
})
```

**Funcionalidades:**
- Iconos y colores según tipo (ingreso/gasto)
- Formato de moneda chilena
- Eliminación con confirmación
- Información de categoría y fecha

---

## 🎯 Funcionalidades Implementadas

### ✅ **Core Features**

1. **Gestión de Movimientos**
   - ➕ Agregar ingresos/gastos
   - 🗑️ Eliminar movimientos (long press)
   - 📂 Categorización automática
   - 📅 Fechas personalizables

2. **Dashboard Financiero**
   - 💰 Balance mensual actual
   - 📈 Total ingresos del mes
   - 📉 Total gastos del mes
   - 🔮 Proyección fin de mes
   - 📊 Movimientos recientes (últimos 5)

3. **Análisis Mensual**
   - 📅 Navegación por meses
   - 📋 Lista completa de movimientos
   - 💹 Estadísticas del período
   - 🎯 Resumen visual con colores

4. **UX/UI Optimizada**
   - 🎨 Material 3 con tema chileno
   - 📱 Diseño responsivo
   - 🔄 Pull-to-refresh
   - ⚡ Hot reload funcional
   - 🌈 Estados visuales claros

### 💰 **Sistema Monetario Chileno**

```dart
// Formato implementado
$ 100.000        // Cien mil pesos
$ 1.500.000      // Un millón quinientos mil
-$ 50.000        // Cincuenta mil negativos

// Configuración
locale: 'es'                    // Español
symbol: '$ '                    // Peso chileno con espacio
decimalDigits: 0               // Sin decimales
thousandSeparator: '.'         // Punto como separador
```

### 📋 **Categorías Chilenas**

**Ingresos:**
- Sueldo, Freelance, Venta, Inversión, Regalo, Bono, Otros ingresos

**Gastos:**
- Alimentación, Transporte, Arriendo/Vivienda, Entretenimiento, Salud, Educación, Ropa, Servicios Básicos, Tecnología, Viajes, Mascotas, Regalos, Otros gastos

---

## 🛠️ Stack Tecnológico

### 📦 **Dependencias Core**
```yaml
dependencies:
  flutter: sdk
  provider: ^6.1.0        # Gestión de estado
  intl: ^0.19.0          # Internacionalización/formato
  sqflite: ^2.3.0        # SQLite (móvil)
  path_provider: ^2.1.0  # Acceso al filesystem
  path: ^1.9.0           # Utilidades de rutas
```

### 🏗️ **Patrones de Arquitectura**

1. **Provider Pattern**
   - Estado global con ChangeNotifier
   - Separación vista/lógica
   - Reactividad automática

2. **Repository Pattern**
   - Abstracción de datos (DAO)
   - Intercambiable (web/móvil)
   - Testeable

3. **Feature-Based Organization**
   - Separación por funcionalidades
   - Código cohesivo
   - Fácil navegación

### 🌐 **Compatibilidad Multiplataforma**

```dart
// Factory pattern para plataforma
static AppDatabase create() {
  if (kIsWeb) {
    return WebDatabase();           // Memoria
  } else {
    return SqliteAppDatabase();     // SQLite
  }
}
```

---

## 📊 Algoritmos y Lógica de Negocio

### 💹 **Cálculo de Proyección**
```dart
double getMonthEndProjection() {
  final now = DateTime.now();
  final daysInMonth = DateTime(now.year, now.month + 1, 0).day;
  final daysPassed = now.day;
  final remainingDays = daysInMonth - daysPassed;
  
  final currentExpenses = getCurrentMonthExpenses();
  final avgDailyExpenses = currentExpenses / daysPassed;
  final projectedRemainingExpenses = avgDailyExpenses * remainingDays;
  
  return getCurrentMonthBalance() - projectedRemainingExpenses;
}
```

**Lógica:**
1. Calcula promedio de gasto diario del mes actual
2. Proyecta gastos para días restantes
3. Resta proyección del balance actual
4. Resultado: balance estimado al final del mes

### 🔍 **Filtros y Consultas**
```dart
// Movimientos por mes
List<Movement> getMovementsForMonth(int year, int month) {
  return _movements.where((movement) {
    return movement.date.year == year && 
           movement.date.month == month;
  }).toList();
}

// Cálculo de balance
double getCurrentMonthBalance() {
  final movements = getCurrentMonthMovements();
  return movements.fold(0.0, (sum, movement) => sum + movement.amount);
}
```

---

## 🎨 Sistema de Diseño

### 🌈 **Paleta de Colores**
```dart
// Colores principales
static const Color incomeColor = Color(0xFF4CAF50);      // Verde
static const Color expenseColor = Color(0xFFF44336);     // Rojo
static const Color balancePositiveColor = Color(0xFF2E7D32);
static const Color balanceNegativeColor = Color(0xFFD32F2F);

// Gradientes
static const LinearGradient balanceGradient = LinearGradient(
  colors: [Color(0xFF2E7D32), Color(0xFF388E3C)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);
```

### 📱 **Componentes UI**

**Material 3 Configuration:**
```dart
ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
  cardTheme: CardThemeData(elevation: 2, shape: rounded),
  scaffoldBackgroundColor: Color(0xFFF8F9FA),
)
```

---

## 🧪 Testing y Calidad

### 🔍 **Análisis Estático**
```yaml
# analysis_options.yaml
include: package:flutter_lints/flutter.yaml
linter:
  rules:
    prefer_const_constructors: true
    prefer_const_literals_to_create_immutables: true
```

### 🧪 **Tests Implementados**
```dart
// test/movement_test.dart
testWidgets('Movement model tests', (WidgetTester tester) async {
  // Tests de serialización
  // Tests de validación
  // Tests de cálculos
});
```

---

## 🚀 Comandos de Desarrollo

### ⚡ **Ejecución**
```bash
# Desarrollo web
flutter run -d chrome

# Hot reload
r

# Hot restart
R

# Análisis de código
flutter analyze

# Tests
flutter test
```

### 📦 **Dependencias**
```bash
# Instalar dependencias
flutter pub get

# Actualizar dependencias
flutter pub upgrade

# Verificar dependencias obsoletas
flutter pub outdated
```

---

## 🔮 Próximas Funcionalidades

### 📋 **Backlog Priorizado**

1. **🔄 Persistencia Avanzada**
   - localStorage para web
   - SQLite para móvil
   - Sincronización offline

2. **📊 Analytics Avanzados**
   - Gráficos con charts_flutter
   - Tendencias mensuales
   - Categorías más usadas
   - Comparaciones período a período

3. **💾 Exportación de Datos**
   - Export CSV
   - Export PDF
   - Backup/Restore

4. **⚙️ Configuración Avanzada**
   - Categorías personalizables
   - Metas de ahorro
   - Notificaciones

5. **🎯 UX Improvements**
   - Onboarding
   - Búsqueda y filtros
   - Modo oscuro
   - Animaciones

---

## 🐛 Issues Conocidos y Soluciones

### ⚠️ **Limitaciones Actuales**

1. **Web Persistence**
   - **Issue**: Datos se pierden al recargar
   - **Solución planeada**: localStorage/IndexedDB
   - **Workaround**: Los datos persisten durante la sesión

2. **Localización Parcial**
   - **Issue**: Algunas fechas en inglés
   - **Solución**: Completar inicialización i18n
   - **Status**: Funcional en español básico

3. **Responsive Design**
   - **Issue**: Optimizado para móvil
   - **Solución**: Media queries para desktop
   - **Status**: Funcional en web, mejorable

### ✅ **Problemas Resueltos**

1. ~~SQLite en Web~~ → Implementado DAO en memoria
2. ~~Formato de moneda europea~~ → Cambiado a formato chileno
3. ~~Errores de localización~~ → Configuración 'es' genérica
4. ~~Provider state management~~ → Implementado correctamente

---

## 👥 Guía para Nuevos Desarrolladores

### 🎯 **Quick Start para Agentes**

1. **Entender la estructura:**
   - `core/` → lógica de negocio
   - `features/` → pantallas de usuario
   - `shared/` → componentes reutilizables

2. **Puntos de extensión principales:**
   - Nuevas categorías: `core/constants/categories.dart`
   - Nueva funcionalidad: crear en `features/`
   - Nuevos cálculos: extender `FinanceService`
   - Nuevo widget: agregar en `shared/widgets/`

3. **Patrones a seguir:**
   - Provider para estado global
   - StatefulWidget para estado local
   - Separación vista/lógica
   - Formateo centralizado en `FormatUtils`

### 🔧 **Flujo de Desarrollo Típico**

1. **Nueva Feature:**
   ```
   1. Crear directorio en features/
   2. Implementar screen widget
   3. Agregar ruta en app.dart
   4. Extender service si es necesario
   5. Crear tests correspondientes
   ```

2. **Nuevo Widget Compartido:**
   ```
   1. Crear en shared/widgets/
   2. Documentar props requeridas
   3. Implementar estados (loading, error, success)
   4. Agregar a exports si es necesario
   ```

3. **Modificar Lógica de Negocio:**
   ```
   1. Extender FinanceService
   2. Actualizar tests relevantes
   3. Verificar impacto en UI
   4. Documentar cambios de API
   ```

---

## 📚 Referencias Útiles

### 🔗 **Documentación Técnica**
- [Flutter Documentation](https://docs.flutter.dev/)
- [Provider Package](https://pub.dev/packages/provider)
- [Material 3 Guidelines](https://m3.material.io/)

### 📖 **Recursos del Proyecto**
- `README.md` → Descripción general y setup
- `pubspec.yaml` → Dependencias y metadata
- `analysis_options.yaml` → Reglas de linting

### 🎨 **Diseño y UX**
- Material 3 color system
- Responsive design principles
- Chilean UX patterns

---

**Documentación generada:** 17 de diciembre de 2025  
**Versión del proyecto:** 1.0.0+1  
**Estado:** ✅ Funcional en web con datos en memoria  
**Próximo milestone:** Persistencia local y móvil nativo
