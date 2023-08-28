// ignore_for_file: depend_on_referenced_packages

import "package:sqflite/sqflite.dart";
import "package:path/path.dart";

import 'package:wallet_monitor/src/db/services/wallet_monitor_db.dart';

class DatabaseService {
  static Database? _database;

  Future<Database> database() async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initialize();
    return _database!;
  }

  Future<String> fullPath() async {
    const name = 'wallet_monitor.db';
    final path = await getDatabasesPath();
    return join(path, name);
  }

  Database get db => _database!;

  Future<Database> _initialize() async {
    final path = await fullPath();
    Database database = await openDatabase(
      path,
      version: 1,
      onCreate: create,
      singleInstance: true,
    );

    return database;
  }

  Future<void> create(Database db, int version) async =>
      await WalletMonitorDB().createTables(db);
}
