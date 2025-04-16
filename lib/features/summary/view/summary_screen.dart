import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:meal_planner_app/data/datasources/sqlite_helper.dart';

class SummaryScreen extends StatefulWidget {
  const SummaryScreen({super.key});

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  // Dữ liệu mẫu: số bữa đã lên kế hoạch trong tuần
  int _totalMeals = 0;
  final List<double> _caloriesPerDay = [];

  @override
  void initState() {
    super.initState();
    _loadMealsPerWeek();
  }

  Future<void> _loadMealsPerWeek() async {
    final startOfWeek = DateTime(2025, 4, 14); // Ngày bắt đầu tuần
    final totalMeals = await SqliteHelper().getMealsCountByWeek(startOfWeek);
    final caloriesPerDay = await SqliteHelper().getCaloriesPerDay(startOfWeek);
    debugPrint('Calories pẻ day: $caloriesPerDay');
    setState(() {
      _totalMeals = totalMeals; // Cập nhật số bữa mỗi ngày
      _caloriesPerDay
        ..clear()
        ..addAll(caloriesPerDay); // Cập nhật calories mỗi ngày
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'This week summary',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Total meals planned: $_totalMeals',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              'Calories Per Day',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY:
                      2500, // Giá trị tối đa trên trục Y (có thể thay đổi tùy thuộc vào dữ liệu)
                  barTouchData: BarTouchData(enabled: true),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true, interval: 500),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          const days = [
                            'Mon',
                            'Tue',
                            'Wed',
                            'Thu',
                            'Fri',
                            'Sat',
                            'Sun'
                          ];
                          return Text(days[value.toInt()]);
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  barGroups: _caloriesPerDay.asMap().entries.map((entry) {
                    final index = entry.key;
                    final value = entry.value;
                    return BarChartGroupData(
                      x: index,
                      barRods: [
                        BarChartRodData(
                          toY: value,
                          color: Colors.blue,
                          width: 16,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
