import 'package:sqflite/sqlite_api.dart';

class WalletMonitorDB {
  Future<void> createTables(Database database) async {
    await database.execute("""
        CREATE TABLE IF NOT EXISTS currencies (
          id INTEGER NOT NULL,
          name TEXT NOT NULL,
          symbol CHAR(5) NOT NULL,
          code CHAR(5) NOT NULL,
          exchange_rate REAL NOT NULL,
          decimal_digits INTEGER DEFAULT 0,
          deleted INTEGER DEFAULT 0,
          PRIMARY KEY (id AUTOINCREMENT)
        );
      """);

    await database.execute("""
      CREATE TABLE IF NOT EXISTS accounts (
        id INTEGER NOT NULL,
        name TEXT NOT NULL,
        description TEXT,
        icon TEXT NOT NULL,
        color TEXT NOT NULL,
        amount REAL DEFAULT 0,
        min_amount REAL DEFAULT 0,
        currency_id INTEGER NOT NULL,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        deleted_at DATETIME,
        PRIMARY KEY (id AUTOINCREMENT),
        FOREIGN KEY (currency_id) REFERENCES currencies (id)
      );
    """);

    await database.execute("""
      CREATE TABLE IF NOT EXISTS categories (
        id INTEGER NOT NULL,
        name TEXT NOT NULL UNIQUE,
        description TEXT,
        max_amount REAL DEFAULT 0,
        color TEXT NOT NULL,
        icon TEXT NOT NULL,
        expenses INTEGER NOT NULL,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        deleted_at DATETIME,
        PRIMARY KEY (id AUTOINCREMENT)
      );
    """);

    await database.execute("""
      CREATE TABLE IF NOT EXISTS subcategories (
        id INTEGER NOT NULL,
        name TEXT NOT NULL UNIQUE,
        category_id INTEGER NOT NULL,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        deleted_at DATETIME,
        PRIMARY KEY (id AUTOINCREMENT),
        FOREIGN KEY (category_id) REFERENCES categories (id)
      );
    """);
  }
}
