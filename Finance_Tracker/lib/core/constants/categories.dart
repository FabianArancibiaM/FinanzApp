class Categories {
  // Categorías de ingresos
  static const List<String> incomeCategories = [
    'Sueldo',
    'Freelance',
    'Venta',
    'Inversión',
    'Regalo',
    'Bono',
    'Otros ingresos',
  ];

  // Categorías de gastos
  static const List<String> expenseCategories = [
    'Alimentación',
    'Transporte',
    'Arriendo/Vivienda',
    'Entretenimiento',
    'Salud',
    'Educación',
    'Ropa',
    'Servicios Básicos',
    'Tecnología',
    'Viajes',
    'Mascotas',
    'Regalos',
    'Otros gastos',
  ];

  static List<String> getAllCategories() {
    return [...incomeCategories, ...expenseCategories];
  }

  static bool isIncomeCategory(String category) {
    return incomeCategories.contains(category);
  }

  static bool isExpenseCategory(String category) {
    return expenseCategories.contains(category);
  }
}
