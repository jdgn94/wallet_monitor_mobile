import 'package:wallet_monitor/src/db/index.db.dart';
import 'package:wallet_monitor/src/db/models/currency.model.dart';

export 'package:wallet_monitor/src/db/models/currency.model.dart';

class CurrencyConsult {
  final db = DataBase.db;

  Future<List<Currency>> getAll() async =>
      await db.txn(() async => db.currencies.where().findAll());

  Future<Currency?> getById(int id) async => await db
      .txn(() async => await db.currencies.where().idEqualTo(id).findFirst());
}
