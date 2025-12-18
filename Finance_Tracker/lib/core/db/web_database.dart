import 'package:flutter/foundation.dart' show kIsWeb;

abstract class AppDatabase {
  Future<void> init();
  Future<void> close();
  
  static AppDatabase create() {
    if (kIsWeb) {
      return WebDatabase();
    } else {
      return SqliteAppDatabase();
    }
  }
}

class WebDatabase implements AppDatabase {
  @override
  Future<void> init() async {
    // No initialization needed for web
  }
  
  @override
  Future<void> close() async {
    // No close needed for web
  }
}

// Placeholder for SqliteAppDatabase
class SqliteAppDatabase implements AppDatabase {
  @override
  Future<void> init() async {}
  
  @override
  Future<void> close() async {}
}
