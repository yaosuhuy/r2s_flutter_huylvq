class Category {
  final int id;
  final String categoryName;

  Category({
    required this.id,
    required this.categoryName,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'categoryName': categoryName,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'] as int,
      categoryName: map['categoryName'] as String,
    );
  }

  Category copyWith({
    int? id,
    String? categoryName,
  }) {
    return Category(
      id: id ?? this.id,
      categoryName: categoryName ?? this.categoryName,
    );
  }
}
