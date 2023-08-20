class Currency {
  final int id;
  final String name;
  final String symbol;
  final String code;
  final double exchangeRate;
  final int decimalDigits;
  final bool deleted;

  Currency({
    required this.id,
    required this.name,
    required this.symbol,
    required this.code,
    required this.exchangeRate,
    required this.decimalDigits,
    this.deleted = false,
  });

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
        id: json["id"],
        name: json["name"],
        symbol: json["symbol"],
        code: json["code"],
        exchangeRate: json["exchange_rate"],
        decimalDigits: json["decimal_digits"],
        deleted: json["deleted"] == 1,
      );
}

List<Currency> currenciesFromJson(List<Map<String, dynamic>> json) =>
    json.isEmpty ? [] : json.map((x) => Currency.fromJson(x)).toList();
