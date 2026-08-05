import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthService {
  GoogleAuthService._();

  static final GoogleAuthService instance = GoogleAuthService._();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  bool _initialized = false;

  Future<void> _initialize() async {
    if (_initialized) return;

    await _googleSignIn.initialize();
    _initialized = true;
  }

  Future<User?> signInWithGoogle() async {
    try {
      await _initialize();

      final GoogleSignInAccount googleUser = await _googleSignIn
          .authenticate()
          .timeout(const Duration(seconds: 30));

      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _firebaseAuth
          .signInWithCredential(credential);

      final User? user = userCredential.user;

      if (user != null) {
        await _saveUserToFirestore(user);
      }

      return user;
    } on GoogleSignInException catch (e, stackTrace) {
      print("========== GOOGLE SIGN IN ==========");
      print("Code: ${e.code}");
      print("Description: ${e.description}");
      print(stackTrace);
      rethrow;
    } on FirebaseAuthException catch (e, stackTrace) {
      print("========== FIREBASE AUTH ==========");
      print("Code: ${e.code}");
      print("Message: ${e.message}");
      print(stackTrace);
      rethrow;
    } catch (e, stackTrace) {
      print("========== UNKNOWN ==========");
      print(e);
      print(stackTrace);
      rethrow;
    }
  }

  Future<void> _saveUserToFirestore(User user) async {
    final userRef = _firestore.collection("users").doc(user.uid);

    final snapshot = await userRef.get();

    if (!snapshot.exists) {
      await userRef.set({
        "uid": user.uid,
        "name": user.displayName,
        "email": user.email,
        "photoUrl": user.photoURL,
        "createdAt": FieldValue.serverTimestamp(),
        "lastLogin": FieldValue.serverTimestamp(),
      });
    } else {
      await userRef.set({
        "name": user.displayName,
        "email": user.email,
        "photoUrl": user.photoURL,
        "lastLogin": FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    }

    final assistantConfig = userRef
        .collection("assistant_behavior")
        .doc("config");

    final assistantSnapshot = await assistantConfig.get();

    if (!assistantSnapshot.exists) {
      await assistantConfig.set({
        "assistantName": "ChatX",
        "systemInstruction": "You are a helpful AI assistant.",
        "updatedAt": FieldValue.serverTimestamp(),
        "isDefault": true,
      });
    }
  }

  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
    } catch (_) {}

    await _firebaseAuth.signOut();
  }

  User? get currentUser => _firebaseAuth.currentUser;
}
