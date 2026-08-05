import 'package:chatx/core/media_query.dart';
import 'package:chatx/core/sevices/google_auth_service.dart';
import 'package:chatx/features/screens/landing_screen.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;
  String _version = "";
  String _buildNumber = "";
  final GoogleAuthService _authService = GoogleAuthService.instance;

  @override
  void initState() {
    super.initState();
    _loadAppVersion();
  }

  Future<void> _loadAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();

    setState(() {
      _version = packageInfo.version;
      _buildNumber = packageInfo.buildNumber;
    });
  }

  Future<void> openPrivacyPolicy() async {
    final Uri url = Uri.parse(
      "https://srinis-hub.github.io/chatx-privacy-policy/",
    );

    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception("Could not launch $url");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
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
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                    children: [
                      const TextSpan(text: "By continuing, you agree to our "),
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: GestureDetector(
                          onTap: openPrivacyPolicy,
                          child: Text(
                            "Privacy Policy",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                      const TextSpan(text: "."),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 50),
                  width: double.infinity,
                  height: 58,
                  child: ElevatedButton(
                    onPressed: _isLoading
                        ? null
                        : () async {
                            setState(() {
                              _isLoading = true;
                            });

                            try {
                              final user = await _authService
                                  .signInWithGoogle();

                              if (!mounted) return;

                              if (user != null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "Welcome ${user.displayName}",
                                    ),
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

                              final message = e.toString().replaceFirst(
                                "Exception: ",
                                "",
                              );

                              ScaffoldMessenger.of(
                                context,
                              ).showSnackBar(SnackBar(content: Text(message)));
                            } finally {
                              if (mounted) {
                                setState(() {
                                  _isLoading = false;
                                });
                              }
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
                    child: _isLoading
                        ? SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Theme.of(context).primaryColor,
                              ),
                            ),
                          )
                        : Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/google.png",
                                width: context.width(0.06),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                "Google Sign-in",
                                style: TextStyle(
                                  fontSize: context.width(0.035),
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

                const SizedBox(height: 4),
                Text(
                  "Version $_version ($_buildNumber)",
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 11, color: Colors.grey),
                ),
              ],
            ),
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
