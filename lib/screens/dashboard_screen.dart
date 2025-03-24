import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../widgets/health_metrics_form.dart';
import '../widgets/health_metrics_chart.dart';
import '../widgets/health_analysis_card.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final ApiService _apiService = ApiService();
  Map<String, dynamic>? _analysisData;
  bool _isLoading = false;
  List<double> _heartRates = [];
  List<String> _timeLabels = [];

  Future<void> _analyzeHealth(Map<String, dynamic> healthData) async {
    setState(() => _isLoading = true);
    try {
      final result = await _apiService.analyzeHealth(
        heartRate: healthData['heart_rate'],
        restingHr: healthData['resting_hr'],
        sleepHours: healthData['sleep_hours'],
        steps: healthData['steps'],
        distanceKm: healthData['distance_km'],
        note: healthData['note'],
      );
      
      setState(() {
        _analysisData = result;
        _isLoading = false;
        // Add new data point to chart
        _heartRates.add(healthData['heart_rate']);
        _timeLabels.add(DateTime.now().hour.toString() + ':00');
        // Keep only last 10 readings
        if (_heartRates.length > 10) {
          _heartRates.removeAt(0);
          _timeLabels.removeAt(0);
        }
      });
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Health Dashboard'),
        backgroundColor: Colors.blue,
      ),
      body: Center(  // Test widget
        child: Text('Test - Dashboard Screen', 
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
} 