import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  Future<User?> signInWithGoogle() async {
    try {
      await _googleSignIn.initialize();

      final GoogleSignInAccount googleUser = await _googleSignIn.authenticate();

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
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? "Authentication failed");
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> _saveUserToFirestore(User user) async {
    await _firestore.collection("users").doc(user.uid).set({
      "uid": user.uid,
      "name": user.displayName,
      "email": user.email,
      "photoUrl": user.photoURL,
      "createdAt": FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }

  User? get currentUser => _firebaseAuth.currentUser;
}
