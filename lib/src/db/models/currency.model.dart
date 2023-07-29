import 'package:isar/isar.dart';

part 'currency.model.g.dart';

@Collection(accessor: 'currencies')
class Currency {
  Currency({
    this.id = Isar.autoIncrement,
    required this.name,
    required this.symbol,
  });

  final Id id;
  @Index(unique: true, caseSensitive: true)
  final String name;
  final String symbol;
}
