import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<void> signInWithEmailAndPassword(
      String email, String password, Function errorState) async {
    try {
      print("email: $email, password: $password");
      var response = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      print("response: $response");
    } catch (e) {
      print(e);
      errorState();
    }
  }

  Future<void> signUpWithEmailAndPassword(String email, String password) async {
    var response = await _auth.createUserWithEmailAndPassword(
        email: email.trim(), password: password.trim());
    print(response);
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
