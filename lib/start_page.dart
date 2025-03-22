import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

class StartPage extends StatelessWidget {
  const StartPage({super.key, required this.userName});

  final String userName;

  void _showDialog(context) {
    if (Platform.isIOS) {
      // for IOS
      showCupertinoDialog(
        context: context,
        builder:
            (ctx) => CupertinoAlertDialog(
              title: Text('Invalid Input'),
              content: Text('Please make sure all information is valid'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                  },
                  child: const Text('Okay'),
                ),
              ],
            ),
      );
    } else {
      showDialog(
        context: context,
        builder:
            (ctx) => AlertDialog(
              title: Text('Invalid Input'),
              content: Text('Please make sure all information is valid'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                  },
                  child: const Text('Okay'),
                ),
              ],
            ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Health Tracking")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome, $userName!", // Displays the user's name
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20), // Space below welcome message
            const Text(
              "Health Categories Being Tracked:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: const [
                  ListTile(
                    leading: Icon(Icons.favorite, color: Colors.red),
                    title: Text("Heart Rate"),
                  ),
                  ListTile(
                    leading: Icon(Icons.run_circle, color: Colors.green),
                    title: Text("Steps Count"),
                  ),
                  ListTile(
                    leading: Icon(Icons.local_hospital, color: Colors.blue),
                    title: Text("Blood Pressure"),
                  ),
                  ListTile(
                    leading: Icon(Icons.water_drop, color: Colors.purple),
                    title: Text("Hydration Level"),
                  ),
                  ListTile(
                    leading: Icon(Icons.bedtime, color: Colors.orange),
                    title: Text("Sleep Quality"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
