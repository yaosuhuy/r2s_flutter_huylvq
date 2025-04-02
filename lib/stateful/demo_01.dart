import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  // co bien nen class nay ddoongj
  bool _isClicked = false;

  void _onTap() {
    _isClicked = !_isClicked;
    print("Container tapped: $_isClicked");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Stateful Widget Sample"),
        ),
        body: GestureDetector(
          onTap: _onTap,
          child: Container(
            width: 100,
            height: 100,
            color: _isClicked ? Colors.blue : Colors.red,
          ),
        ),
      ),
    );
  }
}
