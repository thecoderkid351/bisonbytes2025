import 'package:flutter/material.dart';
import 'package:health/health.dart';  // Import the health package

class HealthPermissionPage extends StatefulWidget {
  @override
  _HealthPermissionPageState createState() => _HealthPermissionPageState();
}

class _HealthPermissionPageState extends State<HealthPermissionPage> {
  // Health data types that we want permission for
  final List<HealthDataType> _healthDataTypes = [
    HealthDataType.STEPS,
    HealthDataType.HEART_RATE,
  ];

  bool _hasPermissions = false;

  @override
  void initState() {
    super.initState();
    _checkPermissions();
  }

  // Check if we have permissions to access the health data
  Future<void> _checkPermissions() async {
    bool hasPermission = await Health.hasPermissions(_healthDataTypes);
    setState(() {
      _hasPermissions = hasPermission;
    });
  }

  // Request permission to access health data
  Future<void> _requestPermissions() async {
    bool requested = await Health.requestPermissions(_healthDataTypes);
    setState(() {
      _hasPermissions = requested;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Health Permission'),
      ),
      body: Center(
        child: _hasPermissions
            ? ElevatedButton(
                onPressed: () {
                  // Navigate to the next screen if permissions are granted
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NextScreen()),
                  );
                },
                child: Text("Permission Granted! Go to Next Screen"),
              )
            : ElevatedButton(
                onPressed: _requestPermissions,
                child: Text("Request Health Permission"),
              ),
      ),
    );
  }
}

class NextScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Next Screen")),
      body: Center(child: Text("Now you can fetch and display health data!")),
    );
  }
}
