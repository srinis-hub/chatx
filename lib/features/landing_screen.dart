import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatefulWidget {
  final User user;
  const LandingScreen({super.key, required this.user});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text("Landing Screen")));
  }
}
