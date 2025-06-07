import 'package:apps/auth_wrapper.dart';
import 'package:apps/screens/auth/login_screen.dart';
import 'package:apps/screens/auth/register_screen.dart';
import 'package:flutter/material.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Budget Tracker",
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          surface: Colors.grey.shade100,
          onSurface: Colors.black,
          primary: const Color(0xFF00B2E7),
          secondary: const Color(0xFFE064F7),
          tertiary: const Color(0xFFFF8D6C),
          outline: Colors.grey.shade400,
        ),
      ),

      home: const AuthWrapper(),

      routes: {
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
      },
    );
  }
}
