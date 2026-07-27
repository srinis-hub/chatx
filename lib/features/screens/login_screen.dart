import 'package:chatx/core/media_query.dart';
import 'package:chatx/core/sevices/google_auth_service.dart';
import 'package:chatx/features/screens/landing_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GoogleAuthService _authService = GoogleAuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "ChatX",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Powered by GeminiAi",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Image.asset('assets/chatx.png', width: context.width(0.3)),

              SizedBox(height: context.height(0.1)),
              Text(
                "Your intelligent AI assistant",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  wordSpacing: 5,
                  letterSpacing: 2,
                ),
              ),
              Text(
                "Ask, create, and discover with AI.",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  wordSpacing: 5,
                  letterSpacing: 2,
                ),
              ),
              SizedBox(height: context.height(0.2)),

              Container(
                margin: const EdgeInsets.symmetric(horizontal: 50),
                width: double.infinity,
                height: 58,
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      final user = await _authService.signInWithGoogle();

                      if (!mounted) return;

                      if (user != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Welcome ${user.displayName}"),
                          ),
                        );

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => LandingScreen(user: user),
                          ),
                        );
                      }
                    } catch (e) {
                      if (!mounted) return;

                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(e.toString())));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black87,
                    side: BorderSide(color: Colors.grey.shade300),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/google.png", width: 30),
                      const SizedBox(width: 12),
                      const Text(
                        "Get Started with Google",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Divider(
                height: 32,
                thickness: 0.5,
                color: Colors.black87,
                indent: 32,
                endIndent: 32,
              ),
              const SizedBox(height: 16),
              Text(
                'Secure • Fast • Private',
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: Colors.grey.shade300, width: 0.5),
            ),
          ),
          child: const Text(
            "Developed by Dev Srini • Powered by Gemini AI",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
