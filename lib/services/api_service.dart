// import 'package:http/http.dart' as http;
// import 'dart:convert';

// Future<void> sendHealthData(List<Map<String, dynamic>> data) async {
//   final response = await http.post(
//     Uri.parse('http://10.23.136.215:5000/'), // Replace with your backend URL
//     headers: {'Content-Type': 'application/json'},
//     body: jsonEncode(data), // Convert data to JSON
//   );

//   if (response.statusCode == 200) {
//     print('Data sent successfully');
//   } else {
//     print('Failed to send data: ${response.body}');
//   }
// }
