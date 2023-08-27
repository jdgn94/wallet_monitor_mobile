// ignore_for_file: library_private_types_in_public_api
import 'package:sqflite/sqflite.dart';

import 'package:wallet_monitor/src/db/models/account.model.dart';
import 'package:wallet_monitor/src/db/models/account_summary.model.dart';
import 'package:wallet_monitor/src/db/queries/currency.consult.dart';
import 'package:wallet_monitor/src/db/services/database.service.dart';

export 'package:wallet_monitor/src/db/models/account.model.dart';

class _AccountsTotals {
  final List<Account?> accounts;
  final List<SummaryAccount?> summaryAccounts;

  _AccountsTotals({
    required this.accounts,
    required this.summaryAccounts,
  });
}

class AccountConsult {
  static final _db = DatabaseService().db;

  static Future<_AccountsTotals> getAll() async {
    final resultAccounts = await _db.rawQuery("""
      SELECT
        a.id,
        a.name,
        a.description,
        a.icon,
        a.color,
        a.amount,
        a.min_amount,
        a.created_at,
        a.updated_at,
        a.deleted_at,
        a.currency_id,
        c.name currency_name,
        c.symbol currency_symbol,
        c.code currency_code,
        c.exchange_rate,
        c.decimal_digits
      FROM
        accounts a
        INNER JOIN currencies c ON a.currency_id = c.id;
    """);

    print(resultAccounts);
    final accounts = accountsFromJson(resultAccounts);

    final resultSummaryAccounts = await _db.rawQuery("""
      SELECT
        COUNT(a.id) total_accounts,
        SUM(a.amount) total_amounts,
        c.name currency_name,
        c.symbol currency_symbol,
        c.exchange_rate,
        c.decimal_digits
      FROM
        accounts a
        INNER JOIN currencies c ON a.currency_id = c.id
      GROUP BY
        a.currency_id
    """);

    print(resultSummaryAccounts);
    final summaryAccounts = summaryAccountFromJson(resultSummaryAccounts);

    return _AccountsTotals(
      accounts: accounts,
      summaryAccounts: summaryAccounts,
    );
  }

  static Future<SummaryAccount> getSummaryByCurrency(int id) async {
    final currency = await CurrencyConsult.getById(id);

    final resultSummary = await _db.rawQuery("""
      SELECT
        COUNT(a.id) total_accounts,
        SUM(a.amount / c.exchange_rate) as total_amount_usd
      FROM
        accounts a
        INNER JOIN currencies c ON a.currency_id = c.id
    """);

    final resSummary = resultSummary[0];
    final double totalAmountsUsd = resSummary["total_amount_usd"] as double;
    final Map<String, dynamic> tempSummary = {
      "total_accounts": resSummary["total_accounts"],
      "total_amounts": totalAmountsUsd * currency.exchangeRate,
      "currency_name": currency.name,
      "currency_symbol": currency.symbol,
      "exchange_rate": currency.exchangeRate,
      "decimal_digits": currency.decimalDigits,
    };

    final summary = SummaryAccount.fromJson(tempSummary);

    return summary;
  }

  static Future<List<Account?>> getAllNoDeleted() async {
    final result = await _db.rawQuery("""
      SELECT
        a.id,
        a.name,
        a.description,
        a.icon,
        a.color,
        a.amount,
        a.min_amount,
        a.created_at,
        a.updated_at,
        a.deleted_at,
        a.currency_id,
        c.name currency_name,
        c.symbol currency_symbol,
        c.code currency_code,
        c.exchange_rate,
        c.decimal_digits
      FROM
        accounts a
        INNER JOIN currencies c ON a.currency_id = c.id
      WHERE
        a.deleted_at IS NULL;
    """);

    final accounts = accountsFromJson(result);

    return accounts;
  }

  static Future<Account?> getById(int id) async {
    final result = await _db.rawQuery("""
      SELECT * FROM accounts WHERE id = $id
    """);

    if (result.isEmpty) return null;

    final account = Account.fromJson(result[0]);

    return account;
  }

  static Future<void> createOrUpdate({
    int? id,
    required double amount,
    required String color,
    required double minAmount,
    required String icon,
    required String name,
    required String description,
    required int currencyId,
    required DateTime createdAt,
    DateTime? deletedAt,
  }) async {
    await _db.insert(
      "accounts",
      {
        "id": id,
        "amount": amount,
        "color": color,
        "min_amount": minAmount,
        "icon": icon,
        "name": name,
        "description": description,
        "currency_id": currencyId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": DateTime.now().toIso8601String(),
        "deleted_at": deletedAt?.toIso8601String(),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
