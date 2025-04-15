import 'package:flutter/material.dart';
import 'package:meal_planner_app/features/meal/view/meal_screen.dart';
import 'package:meal_planner_app/features/settings/view/settings_screen.dart';
import 'package:meal_planner_app/features/summary/view/summary_screen.dart';
import 'package:meal_planner_app/main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    MealScreen(),
    SummaryScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Meal Planner'),
          centerTitle: false,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SettingsScreen(
                        isDarkMode:
                            myAppKey.currentState?.themeMode == ThemeMode.dark,
                        onThemeChanged: (isDarkMode) {
                          myAppKey.currentState?.toggleTheme(isDarkMode);
                        },
                      ),
                    ),
                  );
                },
                icon: Icon(Icons.settings)),
          ]),
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.restaurant), label: 'Meals'),
          BottomNavigationBarItem(
              icon: Icon(Icons.query_stats), label: 'Statistics'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
