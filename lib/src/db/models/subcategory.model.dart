class Subcategory {
  final int id;
  String name;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime? deletedAt;

  Subcategory({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory Subcategory.fromJson(Map<String, dynamic> json) => Subcategory(
        id: json["id"],
        name: json["name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"] == null
            ? null
            : DateTime.parse(json["deleted_at"]),
      );
}

List<Subcategory?> subcategoriesFromJson(List<Map<String, dynamic>> json) =>
    json.isEmpty ? [] : json.map((x) => Subcategory.fromJson(x)).toList();
