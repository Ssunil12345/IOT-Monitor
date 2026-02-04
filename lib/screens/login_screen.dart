import 'package:flutter/material.dart';
import 'dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _handleLogin() {
    // Simple validation: if fields aren't empty, go to dashboard
    if (_emailController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const DashboardScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter your credentials")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [Color(0xFF1e3c72), Color(0xFF2a5298)],
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 80),
            const Icon(Icons.cloud_sync, size: 100, color: Colors.white),
            const Text("IoT Monitor", style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
            const Spacer(),
            Container(
              padding: const EdgeInsets.all(30),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
              ),
              child: Column(
                children: [
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(hintText: "Email", border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(hintText: "Password", border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
                  ),
                  const SizedBox(height: 30),
                  SUpdateElevatedButton(onPressed: _handleLogin),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

// Custom styled button for login
class SUpdateElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  const SUpdateElevatedButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1e3c72),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
        onPressed: onPressed,
        child: const Text("LOGIN", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
      ),
    );
  }
}