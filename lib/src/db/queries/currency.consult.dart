import 'package:sqflite/sqflite.dart';

import "package:wallet_monitor/src/db/services/database.service.dart";
import 'package:wallet_monitor/src/db/models/currency.model.dart';

export 'package:wallet_monitor/src/db/models/currency.model.dart';

abstract class CurrencyConsult {
  static final _db = DatabaseService().db;

  static Future<List<Currency>> getAll() async {
    final result = await _db.rawQuery("""
      SELECT * FROM currencies WHERE deleted = 0
    """);

    print("Este es el resultado de la busqueda de todas las modenas");
    print(result);

    final currencies = currenciesFromJson(result);

    return currencies;
  }

  static Future<List<Currency>> getAllByAccounts() async {
    final resultCurrenciesIds = await _db.rawQuery("""
      SELECT
        c.id
      FROM
        accounts a
        INNER JOIN currencies c ON a.currency_id = c.id
      GROUP BY
        a.currency_id
    """);

    final List<int> currenciesIds =
        resultCurrenciesIds.map((x) => x['id'] as int).toList();

    final resultCurrencies = await _db.rawQuery("""
      SELECT * FROM currencies WHERE id IN (${currenciesIds.join(",")})
    """);

    final currencies = currenciesFromJson(resultCurrencies);

    return currencies;
  }

  static Future<Currency> getById(int id) async {
    final result = await _db.rawQuery("""
      SELECT * FROM currencies WHERE id = $id
    """);

    final currencyJson = result[0];

    final currency = Currency.fromJson(currencyJson);

    return currency;
  }

  static Future<void> insertOrUpdate({
    required int id,
    required String code,
    required String name,
    required int decimalDigits,
    required double exchangeRate,
    required String symbol,
    required bool deleted,
  }) async {
    await _db.insert(
      "currencies",
      {
        "id": id,
        "code": code,
        "name": name,
        "decimal_digits": decimalDigits,
        "exchange_rate": exchangeRate,
        "symbol": symbol,
        "deleted": deleted,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
