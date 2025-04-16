import 'package:flutter/material.dart';
import 'package:meal_planner_app/data/models/meal.dart';
import 'package:sqflite/sqflite.dart';

class SqliteHelper {
  static final SqliteHelper _instance = SqliteHelper._internal();
  static Database? _database;

  SqliteHelper._internal();

  factory SqliteHelper() {
    return _instance;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;

    // create database when it null
    _database = await _initDB('meal.db');

    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    return await openDatabase(filePath, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''CREATE TABLE meals(
        id INTEGER PRIMARY KEY AUTOINCREMENT, 
        mealName TEXT NOT NULL,
        mealCategory TEXT NOT NULL,
        mealCalories TEXT NOT NULL,
        mealTime TIMESTAMP NOT NULL,
        mealDate TIMESTAMP NOT NULL,
        createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        )''');

    await db.execute('''CREATE TABLE categories(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        categoryName TEXT NOT NULL
        )''');
  }

  Future<int> insertMeal(Meal meal) async {
    final db = await database;
    return await db.insert(
      'meals',
      meal.toMap(),
    );
  }

  Future<int> insertCategory(String name) async {
    final db = await database;
    return await db.insert('categories', {'categoryName': name});
  }

  Future<List<Meal>> getMeals() async {
    final db = await database;
    const orderBy = 'createdAt DESC';
    final List<Map<String, dynamic>> result =
        await db.query('meals', orderBy: orderBy);
    debugPrint('Meals in database: $result');
    return result.map((json) => Meal.fromMap(json)).toList();
  }

  Future<List<Map<String, dynamic>>> getCategories() async {
    final db = await database;
    return await db.query('categories', orderBy: 'categoryName ASC');
  }

  Future<Meal?> getMeal(int id) async {
    final db = await database;

    final List<Map<String, dynamic>> result =
        await db.query('meals', where: 'id = ?', whereArgs: [id]);

    if (result.isNotEmpty) {
      return Meal.fromMap(result.first);
    }
    return null;
  }

  Future<int> updateMeal(Meal meal) async {
    final db = await database;
    return await db.update(
      'meals',
      meal.toMap(),
      where: 'id = ?',
      whereArgs: [meal.id],
    );
  }

  Future<int> deleteMeal(int id) async {
    final db = await database;
    return await db.delete(
      'meals',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteCategory(int id) async {
    final db = await database;
    return await db.delete('categories', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> deleteAllMeals() async {
    final db = await database;
    await db.delete('meals');
  }

  Future<void> close() async {
    final db = await database;
    await db.close();
  }

  Future<List<Meal>> getMealsByDate(DateTime date) async {
    final db = await database;
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = startOfDay
        .add(const Duration(days: 1))
        .subtract(const Duration(seconds: 1));

    final List<Map<String, dynamic>> result = await db.query('meals',
        where: 'mealDate >= ? AND mealDate <= ?',
        whereArgs: [startOfDay.toIso8601String(), endOfDay.toIso8601String()],
        orderBy: 'mealTime ASC');
    return result.map((json) => Meal.fromMap(json)).toList();
  }

  Future<int> getMealsCountByWeek(DateTime startOfWeek) async {
    final db = await database;
    int totalMeals = 0;

    for (int i = 0; i < 7; i++) {
      final currentDay = startOfWeek.add(Duration(days: i));
      final startOfDay =
          DateTime(currentDay.year, currentDay.month, currentDay.day);
      final endOfDay = startOfDay
          .add(
            const Duration(
              days: 1,
            ),
          )
          .subtract(
            const Duration(
              seconds: 1,
            ),
          );
      final count = Sqflite.firstIntValue(await db.rawQuery(
          'SELECT COUNT (*) FROM meals WHERE mealDate >= ? AND mealDate <= ?',
          [startOfDay.toIso8601String(), endOfDay.toIso8601String()]));
      totalMeals += count ?? 0;
    }
    return totalMeals;
  }

  Future<List<double>> getCaloriesPerDay(DateTime startOfWeek) async {
    final db = await database;
    final List<double> caloriesPerDay = [];

    for (int i = 0; i < 7; i++) {
      final day = startOfWeek.add(Duration(days: i));
      final nextDay = day.add(Duration(days: 1));

      final result = await db.rawQuery(
          'SELECT SUM(mealCalories) FROM meals WHERE mealDate >= ? AND mealDate <= ?',
          [day.toIso8601String(), nextDay.toIso8601String()]);

      final totalCalories =
          (result.first['SUM(mealCalories)'] as num?)?.toDouble() ?? 0.0;
      debugPrint('Total calories for $day: $totalCalories');
      caloriesPerDay.add(totalCalories);
    }
    return caloriesPerDay;
  }
}
