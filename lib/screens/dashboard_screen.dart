import 'dart:async'; // 1. Import this for the Timer
import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/sensor_model.dart';
import '../widgets/sensor_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final ApiService apiService = ApiService();
  late Future<SensorData> futureData;
  Timer? _timer; // 2. Declare the timer variable

  @override
  void initState() {
    super.initState();
    _refreshData(); // Initial fetch

    // 3. Set up the timer to run every 30 seconds
    _timer = Timer.periodic(const Duration(seconds: 30), (timer) {
      _refreshData();
    });
  }

  // Helper function to update the UI
  void _refreshData() {
    setState(() {
      futureData = apiService.fetchLatestData();
    });
    print("Data refreshed automatically at ${DateTime.now()}");
  }

  @override
  void dispose() {
    _timer
        ?.cancel(); // 4. VERY IMPORTANT: Stop the timer when the user leaves the screen
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      appBar: AppBar(
        title: const Text("Live Monitoring"),
        actions: [
          IconButton(
            onPressed: _refreshData, // Manual refresh still works
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: FutureBuilder<SensorData>(
        future: futureData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting &&
              !snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError)
            return Center(child: Text("Error: ${snapshot.error}"));

          final data = snapshot.data!;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                _buildLocationBanner(data.latitude, data.longitude),
                const SizedBox(height: 20),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  children: [
                    SensorCard(
                      title: "Temperature",
                      value: "${data.temperature}°C",
                      icon: Icons.thermostat,
                      color: Colors.orange,
                    ),
                    SensorCard(
                      title: "Humidity",
                      value: "${data.humidity}%",
                      icon: Icons.water_drop,
                      color: Colors.blue,
                    ),
                    SensorCard(
                      title: "Moisture",
                      value: "${data.moisture}%",
                      icon: Icons.grass,
                      color: Colors.green,
                    ),
                    SensorCard(
                      title: "Light",
                      value: "${data.light} lx",
                      icon: Icons.wb_sunny,
                      color: Colors.amber,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  "Auto-refreshing every 30s",
                  style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
                ),
                Text(
                  "Last Updated: ${data.createdAt}",
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // (Keep your _buildLocationBanner function the same as before...)
  Widget _buildLocationBanner(String lat, String lon) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF00b09b), Color(0xFF96c93d)],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const Icon(Icons.map, color: Colors.white, size: 40),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Location Tracking",
                style: TextStyle(color: Colors.white70),
              ),
              Text(
                "Lat: $lat, Lon: $lon",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
