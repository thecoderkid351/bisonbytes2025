import 'package:flutter/material.dart';

class HealthPage extends StatelessWidget {
  const HealthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Data'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Welcome to the Health Data Page!',
              style: TextStyle(fontSize: 24),
            ),
            // Here you can add more widgets to show health data
          ],
        ),
      ),
    );
  }
}
