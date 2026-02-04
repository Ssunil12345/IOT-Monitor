class SensorData {
  final String id, temperature, humidity, moisture, light, latitude, longitude, createdAt;

  SensorData({
    required this.id, required this.temperature, required this.humidity,
    required this.moisture, required this.light, required this.latitude,
    required this.longitude, required this.createdAt,
  });

  factory SensorData.fromJson(Map<String, dynamic> json) {
    return SensorData(
      id: json['id'] ?? '0',
      temperature: json['temperature'] ?? '0',
      humidity: json['humidity'] ?? '0',
      moisture: json['moisture'] ?? '0',
      light: json['light'] ?? '0',
      latitude: json['latitude'] ?? '0',
      longitude: json['longitude'] ?? '0',
      createdAt: json['created_at'] ?? '',
    );
  }
}