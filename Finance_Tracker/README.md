# Finance Tracker - MVP

Una aplicación móvil simple y eficiente para el control y análisis básico de finanzas personales, desarrollada en Flutter.

## 🎯 Características

- **Simplicidad**: Interfaz clara y fácil de usar
- **Sin dependencias externas**: Sin login, backend o cloud
- **Persistencia local**: Datos almacenados en SQLite
- **Material 3**: Diseño moderno siguiendo las últimas pautas de Material Design
- **Multiplataforma**: Compatible con Android e iOS

## 📱 Funcionalidades

### ✅ Implementadas
- Registro de movimientos (ingresos y gastos)
- Categorización automática
- Resumen mensual con balance
- Proyección simple de fin de mes
- Visualización de movimientos recientes
- Detalle mensual completo
- Eliminación de movimientos

### 🔄 Próximas funcionalidades
- Exportación de datos
- Estadísticas avanzadas
- Gráficos y reportes
- Configuración de categorías personalizadas

## 🏗️ Arquitectura

```
lib/
├── main.dart                    → Entry point
├── app.dart                     → MaterialApp + rutas
├── core/
│   ├── db/
│   │   ├── database.dart        → Inicialización SQLite
│   │   └── movements_dao.dart   → CRUD movimientos
│   ├── models/
│   │   └── movement.dart        → Modelo de datos
│   ├── services/
│   │   └── finance_service.dart → Lógica de negocio
│   ├── utils/
│   │   └── format.dart          → Formatos (moneda, fecha)
│   └── constants/
│       └── categories.dart      → Categorías predefinidas
├── features/
│   ├── home/
│   │   └── home_screen.dart     → Pantalla principal
│   ├── add_movement/
│   │   └── add_movement_screen.dart → Agregar movimientos
│   ├── month_detail/
│   │   └── month_detail_screen.dart → Detalle mensual
│   └── settings/
│       └── settings_screen.dart → Configuración
└── shared/
    ├── widgets/
    │   ├── balance_card.dart    → Tarjeta de balance
    │   └── movement_tile.dart   → Item de movimiento
    └── theme/
        └── app_theme.dart       → Tema de la aplicación
```

## 🛠️ Stack Tecnológico

- **Flutter** (última versión estable)
- **Dart**
- **Material 3** para el diseño
- **SQLite** para persistencia local
- **Provider** para gestión de estado

## 📦 Dependencias

```yaml
dependencies:
  flutter:
    sdk: flutter
  sqflite: ^2.3.0      # Base de datos SQLite
  path_provider: ^2.1.0 # Acceso al sistema de archivos
  intl: ^0.19.0        # Internacionalización y formatos
  provider: ^6.1.0     # Gestión de estado
```

## 🚀 Instalación y Ejecución

1. **Clonar el repositorio**
   ```bash
   git clone <repository-url>
   cd finance_tracker
   ```

2. **Instalar dependencias**
   ```bash
   flutter pub get
   ```

3. **Ejecutar la aplicación**
   ```bash
   flutter run
   ```

## 💾 Modelo de Datos

### Movement (SQLite)
- `id`: int (Primary Key, autoincrement)
- `amount`: double (positivo = ingreso, negativo = gasto)
- `category`: String
- `date`: String (ISO 8601)

## 🎨 Diseño

La aplicación utiliza Material 3 con una paleta de colores personalizada:
- **Verde** para ingresos y balances positivos
- **Rojo** para gastos y balances negativos
- **Diseño responsivo** adaptado a diferentes tamaños de pantalla

## 📊 Lógica de Negocio

### Cálculos principales:
- **Balance mensual**: Suma de todos los movimientos del mes
- **Ingresos**: Suma de movimientos positivos
- **Gastos**: Suma absoluta de movimientos negativos
- **Proyección**: Balance actual - (gasto promedio diario × días restantes)

## 🔧 Gestión de Estado

Utiliza **Provider** con **ChangeNotifier** para:
- Gestión simple y eficiente del estado
- Actualización automática de la UI
- Separación clara entre lógica y presentación

## 🚀 Próximos pasos

1. **Exportación de datos** (CSV, PDF)
2. **Gráficos y estadísticas** avanzadas
3. **Categorías personalizables**
4. **Filtros y búsqueda** de movimientos
5. **Backup y restore** de datos
6. **Notificaciones** para recordatorios

## 📝 Notas de Desarrollo

- **Principio KISS**: Keep It Simple, Stupid
- **MVP funcional**: Prioriza funcionalidad sobre complejidad
- **Código limpio**: Fácil de mantener y extender
- **Sin over-engineering**: Evita patrones innecesarios para el MVP

## 🤝 Contribución

Este es un proyecto personal, pero las sugerencias y mejoras son bienvenidas.

---

**Desarrollado con ❤️ en Flutter**
