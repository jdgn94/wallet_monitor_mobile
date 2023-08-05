import 'package:isar/isar.dart';

part 'currency.model.g.dart';

@Collection(accessor: 'currencies')
class Currency {
  final Id id;
  @Index(unique: true, caseSensitive: true)
  final String name;
  final String symbol;

  Currency({
    this.id = Isar.autoIncrement,
    required this.name,
    required this.symbol,
  });
}
