// ignore_for_file: avoid_function_literals_in_foreach_calls
import 'package:sqflite/sqflite.dart';

import 'package:wallet_monitor/src/db/models/category.model.dart';
import 'package:wallet_monitor/src/db/services/database.service.dart';

export 'package:wallet_monitor/src/db/models/category.model.dart';

abstract class CategoryConsult {
  static final _db = DatabaseService().db;

  static Future<List<Category?>> getAll({bool? expenses, bool? deleted}) async {
    String whereQuery = "";
    if (expenses == true) {
      whereQuery = "WHERE expenses = 1";
    } else if (expenses == false) {
      whereQuery = "WHERE expenses = 0";
    }
    if (deleted == true) {
      whereQuery = whereQuery == ""
          ? "WHERE deleted_at IS NOT NULL"
          : "$whereQuery AND deleted_at IS NOT NULL";
    } else if (deleted == false) {
      whereQuery = whereQuery == ""
          ? "WHERE deleted_at IS NULL"
          : "$whereQuery AND deleted_at IS NULL";
    }

    final resultCategories = await _db.rawQuery("""
      SELECT * FROM categories $whereQuery;
    """);

    print(resultCategories);

    List<Map<String, dynamic>> tempCategories = [];
    final totalCategories = resultCategories.length;
    for (int i = 0; i < totalCategories; i++) {
      final tempCategory = resultCategories[i];
      final resultSubcategories = await _db.rawQuery("""
        SELECT
          *
        FROM
          subcategories
        WHERE
          category_id = ${tempCategory["id"]}
          AND deleted_at IS NOT NULL;
      """);

      tempCategories.add({
        "subcategories": resultSubcategories,
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
