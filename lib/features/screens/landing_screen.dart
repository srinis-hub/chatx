import 'package:chatx/core/sevices/datasources.dart';
import 'package:chatx/features/screens/profile_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatefulWidget {
  final User user;

  const LandingScreen({super.key, required this.user});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  late String myUserName;
  late ChatUser myUser;
  late ChatUser chatx;
  String systemInstruction = "You are a helpful AI assistant.";
  List<ChatMessage> messages = [];
  final TextEditingController _chatController = TextEditingController();
  List<Map<String, dynamic>> chatHistory = [];
  String responseText = 'Welcome to ChatZ! Ask me anything.';

  @override
  void initState() {
    super.initState();
    myUserName = widget.user.displayName ?? "User";
    myUser = ChatUser(id: "1", firstName: myUserName);
    chatx = ChatUser(id: "2", firstName: "ChatX");
    loadAssistantBehavior(widget.user);
  }

  dynamic askGemini() async {
    var input = _chatController.text;

    chatHistory.add({
      'role': 'user',
      'parts': [
        {'text': input},
      ],
    });

    messages.insert(
      0,
      ChatMessage(createdAt: DateTime.now(), text: input, user: myUser),
    );
    setState(() {
      messages;
    });
    _chatController.clear();

    final responseText = await DataSources.askGemini(
      chatHistory,
      "your name is ${chatx.firstName}, and you are a $systemInstruction",
    );
    chatHistory.add({
      'role': 'model',
      'parts': [
        {'text': responseText},
      ],
    });

    messages.insert(
      0,
      ChatMessage(createdAt: DateTime.now(), text: responseText, user: chatx),
    );
    setState(() {
      // isLoading = false;
      messages;
    });
    // if (isSpeaking) {
    //   flutterTts.speak(responseText);
    // }
  }

  Future<void> loadAssistantBehavior(User user) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('assistant_behavior')
          .doc("config")
          .collection("history")
          .orderBy('changedAt', descending: true)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final data = snapshot.docs.first.data();

        chatx.firstName = data['assistantName'] ?? "ChatX";

        systemInstruction =
            data['systemInstruction'] ?? "You are a helpful AI assistant.";
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

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
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfileScreen(user: widget.user),
                    ),
                  );
                },
                child: ClipOval(
                  child:
                      widget.user.photoURL != null &&
                          widget.user.photoURL!.isNotEmpty
                      ? Image.network(
                          widget.user.photoURL!,
                          width: 36,
                          height: 36,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.person, color: Colors.grey);
                          },
                          loadingBuilder: (context, child, progress) {
                            if (progress == null) return child;
                            return const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            );
                          },
                        )
                      : const Icon(Icons.person, color: Colors.grey),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: DashChat(
                messageListOptions: MessageListOptions(),
                messageOptions: MessageOptions(
                  // showCurrentUserAvatar: true,
                  // showOtherUsersName: true
                ),
                messages: messages,
                onSend: (m) {},
                currentUser: myUser,
                readOnly: true,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 14, top: 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _chatController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Ask me anything...",
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    askGemini();
                  },
                  icon: Icon(Icons.send, color: Theme.of(context).primaryColor),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8, top: 4),
          child: Text(
            "ChatX responses may contain inaccuracies.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
