import 'package:flutter/material.dart';
import 'package:meal_planner_app/data/models/meal.dart';

class MealItem extends StatelessWidget {
  final Meal meal;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  const MealItem(
      {super.key,
      required this.meal,
      required this.onTap,
      required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title:  Text(
          meal.mealName,
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: const Text('Calories'),
        trailing: Text(
          meal.mealCalories.toString(),
          style: TextStyle(
            fontSize: 17,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
