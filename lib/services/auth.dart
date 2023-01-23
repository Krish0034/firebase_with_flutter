import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_with_flutter/models/Users.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Create user object based on UserCredintial
  Users? _usersCredential(User user) {
    return user != null ? Users(uid: user.uid) : null;
  }

  // Sign in anon
  Future signInAnon() async {
    try {
      final userCredential = await _auth.signInAnonymously();
      User? user = userCredential.user;
      return _usersCredential(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Sign in with email & password

  // register with email & password

  // Sing out
}
