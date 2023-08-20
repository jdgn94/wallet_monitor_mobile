import 'package:wallet_monitor/src/db/models/account.model.dart';
import 'package:wallet_monitor/src/db/services/database.service.dart';

export 'package:wallet_monitor/src/db/models/account.model.dart';

class _AccountsTotals {
  final List<Account?> accounts;

  _AccountsTotals({
    required this.accounts,
  });
}

class AccountConsult {
  static final _db = DatabaseService().db;

  static Future<_AccountsTotals> getAll() async {
    final result = await _db.query("""
      SELECT * FROM accounts
    """);

    final accounts = accountsFromJson(result);

    return _AccountsTotals(accounts: accounts);
  }

  static Future<List<Account?>> getAllNoDeleted() async {
    final result = await _db.query("""
      SELECT * FROM accounts WHERE deleted_at IS NOT NULL
    """);

    final accounts = accountsFromJson(result);

    return accounts;
  }

  static Future<Account?> getById(int id) async {
    final result = await _db.query("""
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
    required double alert,
    required String icon,
    required String name,
    required String description,
    required int currencyId,
    required DateTime createdAt,
    DateTime? deleted,
  }) async {}
  // static final _db = DataBase.db;

  // static Future<_AccountsTotals> getAll() async {
  //   final accounts =
  //       await _db.txnSync(() => _db.accounts.where().findAllSync());

  //   return _AccountsTotals(accounts: accounts);
  // }

  // static Future<List<Account?>> getAllNoDeleted() async => await _db
  //     .txnSync(() => _db.accounts.filter().deletedIsNotNull().findAllSync());

  // static Future<Account?> getById(int id) async => await _db
  //     .txnSync(() => _db.accounts.filter().idEqualTo(id).findFirstSync());

  // static Future<void> createOrUpdate({
  //   required double amount,
  //   required String color,
  //   required double alert,
  //   required String icon,
  //   required String name,
  //   required String description,
  //   required currencyId,
  //   DateTime? deleted,
  //   int? id,
  // }) async {
  //   Account newAccount = Account(
  //     id: id,
  //     amount: amount,
  //     color: color,
  //     alert: alert,
  //     icon: icon,
  //     name: name,
  //     currencyId: currencyId,
  //     description: description,
  //     deleted: deleted,
  //   );

  //   _db.writeTxnSync(() {
  //     final currency =
  //         _db.currencies.filter().idEqualTo(currencyId).findFirstSync();
  //     newAccount.currency.value = currency;
  //     _db.accounts.putSync(newAccount);
  //   });
  // }
}
