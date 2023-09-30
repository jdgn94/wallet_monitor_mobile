import 'package:sqflite/sqflite.dart';

import 'package:wallet_monitor/src/db/models/subcategory.model.dart';
import 'package:wallet_monitor/src/db/services/database.service.dart';

export 'package:wallet_monitor/src/db/models/subcategory.model.dart';

abstract class SubcategoryConsult {
  static final _db = DatabaseService().db;

  static Future<List<Subcategory?>> getAllByCategory(
    int categoryId, {
    bool? showDelete,
  }) async {
    String whereConditions = "";

    if (showDelete == true) {
      whereConditions = "AND deleted_at IS NULL";
    }
    if (showDelete == false) {
      whereConditions = "AND deleted_at IS NOT NULL";
    }

    final response = await _db.rawQuery("""
      SELECT * FROM subcategories WHERE category_id = $categoryId $whereConditions;
    """);

    final subcategories = subcategoriesFromJson(response);

    return subcategories;
  }

  static Future<void> createOrUpdate({
    int? id,
    required String name,
    String? icon,
    required int categoryId,
    required DateTime createdAt,
    DateTime? deletedAt,
  }) async {
    await _db.insert(
      "subcategories",
      {
        "id": id,
        "name": name,
        "icon": icon,
        "category_id": categoryId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": DateTime.now().toIso8601String(),
        "deleted_at": deletedAt?.toIso8601String(),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
