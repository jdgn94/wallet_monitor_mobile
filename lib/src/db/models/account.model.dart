import 'package:isar/isar.dart';
import 'package:wallet_monitor/src/db/models/currency.model.dart';

part 'account.model.g.dart';

@Collection(accessor: 'accounts')
class Account {
  final Id? id;
  String name;
  String? description;
  String icon;
  String color;
  int amount;
  int alert;
  int currencyId;
  DateTime? deleted;
  // @Index(composite: [CompositeIndex('id')])
  final currency = IsarLink<Currency>();

  Account({
    this.id = Isar.autoIncrement,
    required this.name,
    this.description,
    required this.icon,
    required this.color,
    required this.amount,
    required this.alert,
    required this.currencyId,
    this.deleted,
  });
}
