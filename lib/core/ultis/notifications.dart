import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:meal_planner_app/data/datasources/sqlite_helper.dart';
import 'package:meal_planner_app/data/models/meal.dart';
import 'package:meal_planner_app/main.dart';
import 'package:timezone/timezone.dart' as tz;

Future<void> checkAndSendNotifications() async {
  final meals = await SqliteHelper().getMeals();
  final now = DateTime.now();
  for (var meal in meals){
    if (meal.mealTime.isAfter(now)) {
      debugPrint('Scheduling notification for meal: ${meal.mealName}');
      await scheduleNotification(meal);
    } else {
      debugPrint('Meal time has passed, not scheduling notification for: ${meal.mealName}');
    }
  }
}

Future<void> scheduleNotification(Meal meal) async {
  try {
    final scheduledTime = tz.TZDateTime.from(meal.mealTime, tz.local);

     // Sử dụng ID hợp lệ (giới hạn trong phạm vi 32-bit)
    final notificationId = (meal.id ?? 0) % 2147483647;

    final androidDetails = AndroidNotificationDetails(
      'meal_channel',
      'Meal Notifications',
      channelDescription: 'Notifications for meal times',
      importance: Importance.max,
      priority: Priority.high,
    );

    final notificationDetails = NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      notificationId,
      'Meal Reminder',
      'It\'s time for your meal: ${meal.mealName}',
      scheduledTime.toUtc().add(const Duration(seconds: 1)),
      notificationDetails,
      matchDateTimeComponents: DateTimeComponents
          .time, // sử dụng để kích hoạt thông báo vào thời gian cụ thể mỗi ngafy
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
    debugPrint(
        'Notification scheduled successfully for meal: ${meal.mealName}');
  } catch (e) {
    debugPrint(
        'Error scheduling notification for meal: ${meal.mealName}, Error: $e');
  }
}

Future<void> requestNotificationPermissions() async {
  final bool? granted = await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
      ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
  if (granted != null && granted) {
    debugPrint('Notification Permission Granted!');
  } else {
    debugPrint('Notification Permission Denied!');
  }
}

