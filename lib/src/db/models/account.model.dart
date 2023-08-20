class Account {
  final int id;
  String name;
  String? description;
  String icon;
  String color;
  double amount;
  double minAmount;
  int currencyId;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime? deletedAt;
  String currencyName;
  String currencySymbol;
  String currencyCode;
  double exchangeRate;
  int decimalDigits;

  Account({
    required this.id,
    required this.name,
    this.description,
    required this.icon,
    required this.color,
    required this.amount,
    required this.minAmount,
    required this.currencyId,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.currencyName,
    required this.currencySymbol,
    required this.currencyCode,
    required this.exchangeRate,
    required this.decimalDigits,
  });

  factory Account.fromJson(Map<String, dynamic> json) => Account(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        icon: json["icon"],
        color: json["color"],
        amount: json["amount"],
        minAmount: json["min_amount"],
        currencyId: json["currency_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"] == null
            ? null
            : DateTime.parse(json["deleted_at"]),
        currencyName: json["currency_name"],
        currencySymbol: json["currency_symbol"],
        currencyCode: json["currency_code"],
        exchangeRate: json["exchange_rate"],
        decimalDigits: json["decimal_digits"],
      );
}

List<Account?> accountsFromJson(List<Map<String, dynamic>> json) =>
    json.isEmpty ? [] : json.map((x) => Account.fromJson(x)).toList();
