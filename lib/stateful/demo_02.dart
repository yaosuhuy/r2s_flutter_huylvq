import 'package:flutter/material.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});



  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isClicked = false;

  void _onTap() {
    setState(() {
      _isClicked = !_isClicked;
    });
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