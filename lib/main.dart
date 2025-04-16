import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:meal_planner_app/core/ultis/notifications.dart';
// import 'package:meal_planner_app/data/models/meal.dart';
// import 'package:meal_planner_app/features/meal/view/meal_screen.dart';
import 'package:meal_planner_app/home_screen.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:workmanager/workmanager.dart';

final GlobalKey<_MyAppState> myAppKey = GlobalKey<_MyAppState>();
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void callbackDispatcher() {
  // This function will be called when the notification is triggered
  // You can perform any background task here
  debugPrint('Notification triggered in background');
  Workmanager().executeTask((task, inputData) async {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Ho_Chi_Minh'));  

    await checkAndSendNotifications();

    return Future.value(true);
  });
} 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // khởi tạo múi giờ cho timezone chạy
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('Asia/Ho_Chi_Minh'));

  // cấu hình notification cho android
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  // cấu hình noti cho ios
  const DarwinInitializationSettings initializationSettingsIOS =
      DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );

  // thiết lập cấu hình cho cả hai hệ
  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
    debugPrint('Notification clicked: ${response.payload}');
  });

  Workmanager().initialize(
    callbackDispatcher,
    isInDebugMode: true,
  );
  Workmanager().registerPeriodicTask(
    'check_notifications',
    'check_notifications',
    frequency: const Duration(minutes: 15),
  );

  await requestNotificationPermissions();

  runApp(MyApp(key: myAppKey));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode get themeMode => _themeMode;

  ThemeMode _themeMode = ThemeMode.light;

  void toggleTheme(bool isDarkMode) {
    setState(() {
      _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _themeMode,
      home: const HomeScreen(),
    );
  }
}
