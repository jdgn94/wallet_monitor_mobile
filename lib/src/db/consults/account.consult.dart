import 'package:wallet_monitor/src/db/index.db.dart';
import 'package:wallet_monitor/src/db/models/account.model.dart';
import 'package:wallet_monitor/src/db/models/currency.model.dart';

export 'package:wallet_monitor/src/db/models/account.model.dart';

class AccountConsult {
  static final _db = DataBase.db;

  static Future<List<Account?>> getAll() async =>
      await _db.txnSync(() => _db.accounts.where().findAllSync());

  static Future<List<Account?>> getAllNoDeleted() async => await _db
      .txnSync(() => _db.accounts.filter().deletedIsNotNull().findAllSync());

  static Future<Account?> getById(int id) async => await _db
      .txnSync(() => _db.accounts.filter().idEqualTo(id).findFirstSync());

  static Future<void> createOrUpdate({
    required int amount,
    required String color,
    required int alert,
    required String icon,
    required String name,
    required String description,
    required currencyId,
    DateTime? deleted,
    int? id,
  }) async {
    Account newAccount = Account(
      id: id,
      amount: amount,
      color: color,
      alert: alert,
      icon: icon,
      name: name,
      currencyId: currencyId,
      description: description,
      deleted: deleted,
    );

    _db.writeTxnSync(() {
      final currency =
          _db.currencies.filter().idEqualTo(currencyId).findFirstSync();
      newAccount.currency.value = currency;
      _db.accounts.putSync(newAccount);
    });
  }
}
