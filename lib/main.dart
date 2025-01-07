import 'package:flutter/material.dart';
import 'package:login_app/screens/login_screen.dart';
import 'screens/profile_screen.dart';

void main() {
  runApp(const LoginApp());
}

class LoginApp extends StatelessWidget {
  const LoginApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginScreen(title: 'Flutter Demo Home Page'),
      debugShowCheckedModeBanner: false, // Removed debug banner for cleaner UI
    );
  }
}