import 'package:chatx/core/media_query.dart';
import 'package:chatx/core/sevices/google_auth_service.dart';
import 'package:chatx/features/login_screen.dart';
import 'package:chatx/features/widgets/profile_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  final User user;
  const ProfileScreen({super.key, required this.user});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GoogleAuthService authService = GoogleAuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 40,),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(CupertinoIcons.back, size: 30),                    
                        color: Colors.black,
                      ),
                      Text("Back",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 24,color: Colors.black),)
                    ],
                  ),
                ),
        SizedBox(height: 20,),
                CircleAvatar(
                  radius: context.height(0.05),
                  backgroundColor: Colors.grey.shade200,
                  child: ClipOval(
                    child:
                        widget.user.photoURL != null &&
                            widget.user.photoURL!.isNotEmpty
                        ? Image.network(
                            widget.user.photoURL!,
                            // width: context.width(0.5),
                            height: context.height(0.097),
                            fit: BoxFit.fill,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.person, color: Colors.grey);
                            },
                            loadingBuilder: (context, child, progress) {
                              if (progress == null) return child;
                              return const SizedBox(
                                width: 50,
                                height: 50,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              );
                            },
                          )
                        : const Icon(Icons.person, color: Colors.grey),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  widget.user.displayName ?? "User",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 34),
                ),
                SizedBox(height: 6),
                Text(
                  widget.user.email ?? "example@email.com",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
                ProfileTile(
                  title: "About Developer",
                  icon: Icons.code_rounded,
                  children: const [
                    Text("Developed by Srinivasa Perumal J"),
                    SizedBox(height: 6),
                    Text("Flutter & AI Engineer"),
                  ],
                ),
                ProfileTile(
                  title: "Technology Used",
                  icon: Icons.memory_rounded,
                  children: const [
                    Text("• Flutter"),
                    SizedBox(height: 2),
                    Text("• Google Gemini AI"),
        
                    SizedBox(height: 2),
                    Text("• Firebase Authentication"),
                    SizedBox(height: 2),
                    Text("• Cloud Firestore"),
                  ],
                ),
        
                ProfileTile(
                  title: "Privacy Policy",
                  icon: Icons.privacy_tip_rounded,
                  children: const [
                    Text("Your data is securely protected."),
                    SizedBox(height: 2),
                    Text("Chat history is stored for a better experience."),
                    SizedBox(height: 2),
                    Text("We never share your personal information."),
                  ],
                ),
                ProfileTile(
                  title: "ChatX",
                  icon: Icons.dock_rounded,
                  children: const [
                    Text("ChatX is an AI-powered personal assistant."),
                    SizedBox(height: 2),
                    Text("Designed to help with everyday questions and tasks."),
                    SizedBox(height: 2),
                    Text("Powered by Gemini AI for intelligent conversations."),
                  ],
                ),
        
                ProfileTile(
                  title: "Settings",
                  icon: Icons.settings,
                  children: [
                    Text("Sign out securely from your account."),
                    SizedBox(height: 2),
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          await authService.signOut();
        
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const LoginScreen(),
                            ),
                            (route) => false,
                          );
                        },
                        icon: const Icon(Icons.logout),
                        label: const Text(
                          "Sign Out",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                      ),
                    ),
                  ],
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
