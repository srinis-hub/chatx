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
    return Scaffold(
      appBar: AppBar(
        title: const Text("ChatX"),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: CircleAvatar(
              radius: 18,
              backgroundColor: Colors.grey.shade200,
              backgroundImage:
                  (widget.user.photoURL != null &&
                      widget.user.photoURL!.isNotEmpty)
                  ? NetworkImage(widget.user.photoURL!)
                  : null,
              child:
                  (widget.user.photoURL == null ||
                      widget.user.photoURL!.isEmpty)
                  ? const Icon(Icons.person, color: Colors.grey)
                  : null,
            ),
          ),
        ],
      ),
      body: Center(child: Text("Landing Screen")),
    );
  }
}
