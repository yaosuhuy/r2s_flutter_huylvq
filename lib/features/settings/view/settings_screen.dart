import 'package:flutter/material.dart';
import 'package:meal_planner_app/core/ultis/show_categories_dialog.dart';

class SettingsScreen extends StatefulWidget {
  final Function(bool) onThemeChanged;
  final bool isDarkMode;
  const SettingsScreen({
    super.key,
    required this.onThemeChanged,
    required this.isDarkMode,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late bool _isDarkMode;

  @override
  void initState() {
    setState(() {
      super.initState();
      _isDarkMode = widget.isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: const Text('Dark Mode'),
              trailing: Switch(
                value: _isDarkMode,
                onChanged: (value) {
                  setState(() {
                    _isDarkMode = value;
                  });
                  widget.onThemeChanged(value);
                },
              ),
            ),
            const Divider(),
            ListTile(
              title: const Text('Edit Meal Categories'),
              onTap: () {
                // Xử lý khi nhấn vào
                showCategoriesDialog(context);
              },
            ),
            const Divider(),
            ListTile(
              title: const Text('Edit Notifications'),
              onTap: () {
                // Xử lý khi nhấn vào
                debugPrint('Edit Notifications tapped');
              },
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
