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
  });

  factory Account.fromJson(Map<String, dynamic> json) => Account(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        icon: json["icon"],
        color: json["color"],
        amount: json["amount"],
        minAmount: json["min_amount"],
        currencyId: json["currencyId"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"],
      );
}

List<Account?> accountsFromJson(List<Map<String, dynamic>> json) =>
    json.isEmpty ? [] : json.map((x) => Account.fromJson(x)).toList();
