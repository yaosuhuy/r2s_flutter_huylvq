import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:meal_planner_app/core/ultis/notifications.dart';
import 'package:meal_planner_app/data/datasources/sqlite_helper.dart';
import 'package:meal_planner_app/data/models/meal.dart';
import 'package:meal_planner_app/features/meal/widgets/meal_item.dart';
import 'package:meal_planner_app/features/planner/view/planner_screen.dart';
import 'package:meal_planner_app/main.dart';

class MealScreen extends StatefulWidget {
  const MealScreen({super.key});

  @override
  State<MealScreen> createState() => _MealScreenState();
}

class _MealScreenState extends State<MealScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  final _listKey = GlobalKey<AnimatedListState>();
  final List<Meal> _animatedMeals = [];

  @override
  void initState() {
    super.initState();
    _loadMealsAnimated();
    _selectedDay = _focusedDay;
    _loadMealsByDate(_focusedDay);
    checkAndScheduleNotifications();
  }

  Future<void> _loadMealsAnimated() async {
    final meals = await SqliteHelper().getMeals();
    debugPrint('Loaded meals: ${meals.length}');
    setState(() {
      _animatedMeals.addAll(meals); // Thêm toàn bộ danh sách vào _animatedMeals
    });

    for (int i = 0; i < meals.length; i++) {
      _animatedMeals.add(meals[i]);
      _listKey.currentState
          ?.insertItem(i, duration: Duration(milliseconds: 300));
    }
  }

  void _openMealForm({Meal? meal, int? index}) async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => PlannerScreen(
          meal: meal,
          selectedDay: _selectedDay!,
        ),
      ),
    );
    if (result != null && result is Meal) {
      if (meal == null) {
        _addMeal(result);
      } else if (index != null) {
        _editMeal(result);
      }
    }
  }

  Future<void> checkAndScheduleNotifications() async {
    final meals = await SqliteHelper()
        .getMeals(); // Lấy tất cả các bữa ăn từ cơ sở dữ liệu
    final now = DateTime.now();

    for (var meal in meals) {
      if (meal.mealTime.isAfter(now)) {
        debugPrint('Checking notification for meal: ${meal.mealName}');

        // Kiểm tra nếu thông báo đã được đặt
        final pendingNotifications =
            await flutterLocalNotificationsPlugin.pendingNotificationRequests();
        final isNotificationScheduled = pendingNotifications.any(
          (notification) => notification.id == meal.id,
        );

        if (!isNotificationScheduled) {
          debugPrint('Scheduling notification for meal: ${meal.mealName}');
          await scheduleNotification(meal);
        } else {
          debugPrint(
              'Notification already scheduled for meal: ${meal.mealName}');
        }
      } else {
        debugPrint(
            'Skipping notification for meal: ${meal.mealName} (time has passed: ${meal.mealTime})');
      }
    }
  }

  Future<void> _addMeal(Meal meal) async {
    final id = await SqliteHelper().insertMeal(meal);
    final success = id > 0;
    final message = success ? 'Meal added' : 'Error adding meal';

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );

    if (success) {
      // add the new task to the animated list
      setState(() {
        final newMeal = meal.copyWith(id: id);
        _animatedMeals.add(newMeal);
        _listKey.currentState?.insertItem(
          _animatedMeals.length - 1,
          duration: const Duration(milliseconds: 300),
        );
      });
    }
  }

  Future<void> _editMeal(Meal meal) async {
    final success = await SqliteHelper().updateMeal(meal) > 0;
    final message = success ? 'Meal updated' : 'Error updating Meal';

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );

    if (success) {
      // update the task in the animated list
      final index = _animatedMeals.indexWhere((t) => t.id == meal.id);
      debugPrint('Updated meals: ${_animatedMeals.length}');
      if (index != -1) {
        setState(() {
          _animatedMeals[index] = meal;
        });
      }
    }
  }

  Future<void> _loadMealsByDate(DateTime date) async {
    final meals = await SqliteHelper().getMealsByDate(date);
    debugPrint('Loaded meals for $date: ${meals.length}');

    setState(() {
      _animatedMeals.clear();
      _animatedMeals.addAll(meals);
    });

    for (int i = 0; i < meals.length; i++) {
      _listKey.currentState?.insertItem(
        i,
        duration: const Duration(milliseconds: 300),
      );
    }
  }

  // updated to use animatedList
  Widget _buildAnimatedItem(Meal meal, Animation<double> animation,
      [int? index]) {
    return SizeTransition(
      sizeFactor: animation,
      child: MealItem(
        meal: meal,
        onDelete: () {},
        onTap: () => _openMealForm(meal: meal, index: index),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //     title: const Text('Meal Planner'),
      //     centerTitle: false,
      //     actions: [
      //       IconButton(
      //           onPressed: () {
      //             Navigator.of(context).push(
      //               MaterialPageRoute(
      //                 builder: (context) => SettingsScreen(
      //                   isDarkMode:
      //                       myAppKey.currentState?.themeMode == ThemeMode.dark,
      //                   onThemeChanged: (isDarkMode) {
      //                     myAppKey.currentState?.toggleTheme(isDarkMode);
      //                   },
      //                 ),
      //               ),
      //             );
      //           },
      //           icon: Icon(Icons.settings)),
      //     ]),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const Text(
            //   'Hello',
            //   style: TextStyle(
            //     fontSize: 28,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            // const Text(
            //   'Plan your meals',
            //   style: TextStyle(
            //     fontSize: 17,
            //   ),
            // ),
            CalendarTimeline(
              initialDate: _focusedDay,
              firstDate: DateTime(2020, 1, 1),
              lastDate: DateTime(2030, 12, 31),
              onDateSelected: (day) {
                setState(() {
                  _focusedDay = day;
                  _selectedDay = day;
                  _loadMealsByDate(day);
                });
              },
              selectableDayPredicate: (day) => true,
            ),
            const SizedBox(height: 20),
            const Text(
              'Today',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _animatedMeals.isEmpty
                  ? const Center(
                      child: Text(
                        'No tasks available',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  : AnimatedList(
                      key: _listKey,
                      initialItemCount: _animatedMeals.length,
                      itemBuilder: (_, index, animation) {
                        if (index < 0 || index >= _animatedMeals.length) {
                          return const SizedBox
                              .shrink(); // Tránh lỗi nếu chỉ số không hợp lệ
                        }
                        return _buildAnimatedItem(
                            _animatedMeals[index], animation, index);
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openMealForm,
        child: const Icon(Icons.add),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(90),
          ),
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
    );
  }
}
