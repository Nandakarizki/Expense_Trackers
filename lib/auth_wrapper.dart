import 'package:apps/screens/auth/login_screen.dart';
import 'package:apps/screens/home/views/home_screen.dart';
import 'package:apps/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  final authService = AuthService();
  User? _previousUser;
  bool _hasShownWelcome = false;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: authService.authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final currentUser = snapshot.data;

        if (currentUser != null) {
          final isNewSession = _previousUser == null && !_hasShownWelcome;

          if (isNewSession) {
            _hasShownWelcome = true;
            _previousUser = currentUser;

            final isNewUser = currentUser.metadata.creationTime != null &&
                DateTime.now().difference(currentUser.metadata.creationTime!).inSeconds < 10;

            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(isNewUser
                        ? 'Registrasi berhasil! Silahkan tekan tombol masuk 😍'
                        : 'Selamat datang kembali 😍'),
                    backgroundColor: Colors.green,
                    duration: const Duration(seconds: 3),
                  ),
                );
              }
            });
          }

          return HomeScreen(user: currentUser);
        } else {
          // User logged out, reset state
          _previousUser = null;
          _hasShownWelcome = false;
          return const LoginScreen();
        }
      },
    );
  }
}