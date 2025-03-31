import 'package:flutter/material.dart';
import 'package:my_app/basic/exercises/models/task.dart';

void main() {
  runApp(HomeScreen());
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _homePage(),
    );
  }
}

class _homePage extends StatelessWidget {
  const _homePage({super.key});

  @override
  Widget build(BuildContext context) {
    final tasks = _getAllTask();
    return Scaffold(
      appBar: AppBar(
        title: Text("Task Manager"),
        centerTitle: false,
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 5,
                    children: [
                      Text(task.title, style: titleTextStyle()),
                      Text(task.description, style: commonTextStyle()),
                      Text(
                          "Created: ${task.createdAt.day}/${task.createdAt.month}/${task.createdAt.year}",
                          style: commonTextStyle()),
                    ],
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

List<Task> _getAllTask() {
  return [
    Task(
      001,
      "Task 1",
      "Description for task 1",
      DateTime.now(),
    ),
    Task(
      002,
      "Task 2",
      "Description for task 2",
      DateTime.now(),
    ),
    Task(
      003,
      "Task 3",
      "Description for task 3",
      DateTime.now(),
    ),
  ];
}

TextStyle titleTextStyle({FontWeight fontWeight = FontWeight.w800}) {
  return TextStyle(fontWeight: fontWeight);
}

TextStyle commonTextStyle({FontWeight fontWeight = FontWeight.w300}) {
  return TextStyle(fontWeight: fontWeight);
}
