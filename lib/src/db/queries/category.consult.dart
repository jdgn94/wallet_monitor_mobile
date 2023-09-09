// ignore_for_file: avoid_function_literals_in_foreach_calls
import 'package:sqflite/sqflite.dart';

import 'package:wallet_monitor/src/db/models/category.model.dart';
import 'package:wallet_monitor/src/db/queries/subcategory.consult.dart';
import 'package:wallet_monitor/src/db/services/database.service.dart';

export 'package:wallet_monitor/src/db/models/category.model.dart';
export 'package:wallet_monitor/src/db/queries/subcategory.consult.dart';

abstract class CategoryConsult {
  static final _db = DatabaseService().db;

  static Future<List<Category?>> getAll({
    bool? expenses,
    bool? showDelete,
  }) async {
    String whereQuery = "";
    if (expenses == true) {
      whereQuery = "WHERE expenses = 1";
    } else if (expenses == false) {
      whereQuery = "WHERE expenses = 0";
    }
    if (showDelete == true) {
      whereQuery = whereQuery == ""
          ? "WHERE deleted_at IS NOT NULL"
          : "$whereQuery AND deleted_at IS NOT NULL";
    } else if (showDelete == false) {
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
      final Map<String, dynamic> tempCategory = resultCategories[i];
      final resultSubcategories = await SubcategoryConsult.getAllByCategory(
        tempCategory["id"],
        showDelete: showDelete,
      );

      tempCategories.add({
        "subcategories": resultSubcategories,
        ...tempCategory,
      });
    }

    print(tempCategories);
    final categories = categoriesFromJson(tempCategories);

    return categories;
  }

  static Future<int> createOrUpdate({
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
    final categoryId = await _db.insert(
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

    return categoryId;
  }
}
