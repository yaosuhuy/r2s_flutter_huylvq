import 'package:flutter/material.dart';

void main() {
  runApp(const IntroductionPage());
}

class IntroductionPage extends StatelessWidget {
  const IntroductionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _buildHomePage(),
    );
  }

  Widget _buildHomePage() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Introduction Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Hello World",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              // overflow: TextOverflow.clip,
            ),
            Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text(
                          "You have pressed the button",
                        ),
                      ),
                    );
                  },
                  child: Text('Login'),
                );
              },
            ),
            Container(
              color: Colors.amber,
              width: 200,
              height: 200,
              padding: const EdgeInsets.only(top: 10, left: 10),
              child: const Text("Hello World"),
            ),
          ],
        ),
      ),
    );
  }
}
