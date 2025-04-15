class Meal {
  final int id;
  final String mealName;
  final String mealCategory;
  final double mealCalories;
  final DateTime mealTime;
  final DateTime mealDate;
  final DateTime createdAt;

  Meal({
    required this.id,
    required this.mealName,
    required this.mealCategory,
    required this.mealCalories,
    required this.mealTime,
    required this.mealDate,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'mealName': mealName,
      'mealCategory': mealCategory,
      'mealCalories': mealCalories.toString(),
      'mealTime': mealTime.toIso8601String(),
      'mealDate': mealDate.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Meal.fromMap(Map<String, dynamic> map) {
    return Meal(
      id: map['id'] as int,
      mealName: map['mealName'] as String,
      mealCategory: map['mealCategory'] as String,
      mealCalories: double.parse(map['mealCalories'].toString()) ,
      mealTime: DateTime.parse(map['mealTime']),
      mealDate: DateTime.parse(map['mealDate']),
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  Meal copyWith({
    int? id,
    String? mealName,
    String? mealCategory,
    double? mealCalories,
    DateTime? mealTime,
    DateTime? mealDate,
    DateTime? createdAt,
  }) {
    return Meal(
      id: id ?? this.id,
      mealName: mealName ?? this.mealName,
      mealCategory: mealCategory ?? this.mealCategory,
      mealCalories: mealCalories ?? this.mealCalories,
      mealTime: mealTime ?? this.mealTime,
      mealDate: mealDate ?? this.mealDate,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
