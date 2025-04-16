import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:meal_planner_app/core/ultis/color.dart';
import 'package:meal_planner_app/data/datasources/sqlite_helper.dart';
import 'package:meal_planner_app/data/models/meal.dart';

class PlannerScreen extends StatefulWidget {
  final Meal? meal;
  final DateTime selectedDay;
  const PlannerScreen({super.key, this.meal, required this.selectedDay});

  @override
  State<PlannerScreen> createState() => _PlannerScreenState();
}

class _PlannerScreenState extends State<PlannerScreen> {
  final _formKey = GlobalKey<FormState>();

  String? _selectedValue;

  List<String> _mealCategories = [];

  final TextEditingController _mealNameController = TextEditingController();
  final TextEditingController _mealCaloriesController = TextEditingController();

  TimeOfDay? _selectedTime = TimeOfDay.now();

  @override
  void initState() {
    super.initState();
    _loadMealCategories();
    if (widget.meal != null) {
      _mealNameController.text = widget.meal!.mealName;
      _mealCaloriesController.text = widget.meal!.mealCalories.toString();
      _selectedValue = widget.meal!.mealCategory;
      _selectedTime = TimeOfDay.fromDateTime(widget.meal!.mealTime);
    }
  }

  Future<void> _loadMealCategories() async {
    final categories = await SqliteHelper().getCategories();
    setState(() {
      _mealCategories = categories
          .map((category) => category['categoryName'] as String)
          .toList();
    });
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      // Handle the selected time
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _saveMeal() async {
    try {
      if (!_formKey.currentState!.validate()) return;

      final name = _mealNameController.text;
      final calories = double.parse(_mealCaloriesController.text.trim());
      final category = _selectedValue;
      final time = _selectedTime;

      final mealDate = widget.selectedDay;

      final mealTime = time != null
          ? DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day, time.hour, time.minute)
          : null;

      Meal meal = widget.meal?.copyWith(
              mealName: name,
              mealCalories: calories,
              mealCategory: category,
              mealDate: mealDate,
              mealTime: mealTime) ??
          Meal(
            id: DateTime.now().millisecondsSinceEpoch,
            mealName: name,
            mealCategory: category ?? 'Unknown',
            mealCalories: calories,
            mealTime: mealTime ?? DateTime.now(),
            mealDate: mealDate,
            createdAt: DateTime.now(),
          );
      Navigator.of(context).pop(meal);
      debugPrint('Success!');
    } catch (e) {
      debugPrint("Error occured when adding/updating a meal: " + e.toString());
    }
  }

  // show delete dialog
  void _showDeleteDialog(int id) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Delete Meal'),
          content: const Text('Are you sure you want to delete this meal?'),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                Navigator.of(context).pop();
                _deleteMeal(id);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteMeal(int id) async {
    try {
      final success = await SqliteHelper().deleteMeal(id);
      if (success > 0) {
        Navigator.of(context).pop(true);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Meal deleted successfully!'),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to delete meal'),
            duration: Duration(seconds: 2),
          ),
        );
      };
    } catch (e) {
      debugPrint("An error occured while deleting meal: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error while deleting meal!'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _buildTextField(
      {required TextEditingController controller,
      required String hintText,
      int maxLines = 1}) {
    return Container(
      // padding: EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: textFormColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(20),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildDropdown() {
    return Container(
      decoration: BoxDecoration(
        color: textFormColor,
      ),
      child: DropdownButtonFormField<String>(
        value: _selectedValue,
        hint: const Text('Select meal type'),
        items: _mealCategories.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            _selectedValue = newValue;
          });
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.transparent, // Màu viền khi focus
              width: 2.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.transparent, // Màu viền khi không focus
            ),
          ),
        ),
        dropdownColor: textFormColor,
      ),
    );
  }

  Widget _buildTimePicker() {
    return GestureDetector(
      onTap: () => _selectTime(context),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: textFormColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          "${_selectedTime?.hour}:${_selectedTime?.minute}",
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _plannerScreen(),
    );
  }

  Widget _plannerScreen() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meal Planner'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            spacing: 15,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLabel("Meal name"),
                  const SizedBox(height: 10),
                  _buildTextField(
                      controller: _mealNameController,
                      hintText: "Enter meal name"),
                  const SizedBox(height: 10),
                  _buildLabel("Meal type"),
                  const SizedBox(height: 10),
                  _buildDropdown(),
                  const SizedBox(height: 10),
                  _buildLabel("Calories"),
                  const SizedBox(height: 10),
                  _buildTextField(
                      controller: _mealCaloriesController,
                      hintText: "Enter calories"),
                  const SizedBox(height: 10),
                  _buildLabel("Meal Time"),
                  const SizedBox(height: 10),
                  _buildTimePicker(),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (widget.meal != null)
                    ElevatedButton(
                      onPressed: () => _showDeleteDialog(widget.meal!.id),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      child: const Text(
                        "Delete",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ElevatedButton(
                    onPressed: _saveMeal,
                    child: Text(
                      widget.meal?.mealName == null
                          ? "Add Meal"
                          : "Update Meal",
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
