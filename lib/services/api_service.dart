import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String baseUrl = 'http://localhost:5000'; // Your Flask backend URL

  Future<dynamic> getPatientVitals() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/api/vitals'));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load patient vitals');
      }
    } catch (e) {
      throw Exception('Error connecting to server: $e');
    }
  }

  // Add more API methods similar to your React dashboard
  // For example:
  Future<dynamic> getAlerts() async {
    // Implementation
  }

  Future<dynamic> getAiAnalysis() async {
    // Implementation
  }

  Future<Map<String, dynamic>> analyzeHealth({
    required double heartRate,
    required double restingHr,
    required double sleepHours,
    required int steps,
    required double distanceKm,
    String? note,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/analyze'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'heart_rate': heartRate,
          'resting_hr': restingHr,
          'sleep_hours': sleepHours,
          'steps': steps,
          'distance_km': distanceKm,
          if (note != null) 'note': note,
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to analyze health data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error connecting to server: $e');
    }
  }
}
