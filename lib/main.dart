import 'package:flutter/material.dart';
import 'screens/login_screen.dart'; // We will create this next

void main() {
  runApp(const IoTApp());
}

class IoTApp extends StatelessWidget {
  const IoTApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IoT Monitor',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      home: const LoginScreen(),
    );
  }
}
