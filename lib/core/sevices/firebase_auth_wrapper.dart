import 'package:chatx/core/splash_screen.dart';
import 'package:chatx/features/landing_screen.dart';
import 'package:chatx/features/login_screen.dart';
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
          print("Loading");
          return const SplashScreen();
        }

        if (snapshot.hasData) {
          print("Loaded");
          return LandingScreen(user: snapshot.data!);
        }
        print("Loaded");
        return const LoginScreen();
      },
    );
  }
}
