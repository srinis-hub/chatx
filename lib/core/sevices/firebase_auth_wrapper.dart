import 'package:chatx/core/splash_screen.dart';
import 'package:chatx/features/screens/landing_screen.dart';
import 'package:chatx/features/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SplashScreen();
        }

        if (snapshot.hasData) {
          return LandingScreen(user: snapshot.data!);
        }
        return const LoginScreen();
      },
    );
  }
}
