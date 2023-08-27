// ignore_for_file: avoid_function_literals_in_foreach_calls
import 'package:sqflite/sqflite.dart';

import 'package:wallet_monitor/src/db/models/category.model.dart';
import 'package:wallet_monitor/src/db/services/database.service.dart';

export 'package:wallet_monitor/src/db/models/category.model.dart';

abstract class CategoryConsult {
  static final _db = DatabaseService().db;

  static Future<List<Category?>> getAll({bool? expenses}) async {
    String whereQuery = "";
    if (expenses == true) {
      whereQuery = "WHERE expenses = 1";
    } else if (expenses == false) {
      whereQuery = "WHERE expenses = 0";
    }

    final resultCategories = await _db.rawQuery("""
      SELECT * FROM categories $whereQuery
    """);

    print(resultCategories);

    List<Map<String, dynamic>> tempCategories = [];
    final totalCategories = resultCategories.length;
    for (int i = 0; i < totalCategories; i++) {
      final tempCategory = resultCategories[i];
      final resultSubcategories = await _db.rawQuery("""
        SELECT * FROM subcategories where category_id = ${tempCategory["id"]};
      """);

      tempCategories.add({
        // "id": tempCategory["id"],
        // "name": tempCategory["name"],
        // "max_amount": tempCategory["max_amount"],
        // "color": tempCategory["color"],
        // "icon": tempCategory["icon"],
        // "expenses": tempCategory["expenses"],
        "subcategories": resultSubcategories,
        // "created_at": tempCategory["created_at"],
        // "updated_at": tempCategory["updated_at"],
        // "deleted_at": tempCategory["deleted_at"],
        ...tempCategory,
      });
    }

    print(tempCategories);
    final categories = categoriesFromJson(tempCategories);
    print(categories);

    return categories;
  }

  static Future<void> createOrUpdate({
    int? id,
    required String name,
    double maxAmount = 0,
    required String description,
    required String color,
    required String icon,
    required bool expenses,
    required DateTime createdAt,
    DateTime? deletedAt,
  }) async {
    await _db.insert(
      "categories",
      {
        "id": id,
        "name": name,
        "description": description,
        "color": color,
        "icon": icon,
        "max_amount": maxAmount,
        "expenses": expenses == true ? 1 : 0,
        "created_at": createdAt.toIso8601String(),
        "updated_at": DateTime.now().toIso8601String(),
        "deleted_at": deletedAt?.toIso8601String(),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
