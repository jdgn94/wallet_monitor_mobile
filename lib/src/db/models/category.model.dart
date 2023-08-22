import 'package:wallet_monitor/src/db/models/subcategory.model.dart';

class Category {
  final int id;
  String name;
  double maxAmount;
  String color;
  String icon;
  bool expenses;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime? deletedAt;
  List<Subcategory?>? subcategories;

  Category({
    required this.id,
    required this.name,
    required this.maxAmount,
    required this.color,
    required this.icon,
    required this.expenses,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.subcategories,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
      id: json["id"],
      name: json["name"],
      maxAmount: json["max_mount"],
      color: json["color"],
      icon: json["icon"],
      expenses: json["expenses"] == 1,
      createdAt: DateTime.parse(json["created_at"]),
      updatedAt: DateTime.parse(json["updated_at"]),
      deletedAt: json["deleted_at"] == null
          ? null
          : DateTime.parse(json["deleted_at"]),
      subcategories: subcategoriesFromJson(
        json["subcategories"],
      ));
}

List<Category?> categoriesFromJson(List<Map<String, dynamic>> json) =>
    json.isEmpty ? [] : json.map((x) => Category.fromJson(x)).toList();
