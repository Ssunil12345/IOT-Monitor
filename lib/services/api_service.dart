import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/sensor_model.dart';

class ApiService {
  Future<SensorData> fetchLatestData() async {
    final response = await http.get(Uri.parse('https://aislyntech.com/Api/oo-get.php'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return SensorData.fromJson(data['data'][0]);
    } else {
      throw Exception('Failed to load API data');
    }
  }
}