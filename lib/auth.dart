import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    print("email: $email, password: $password");
    var response = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    print("response: $response");
  }

  Future<void> signUpWithEmailAndPassword(String email, String password) async {
    await _auth.createUserWithEmailAndPassword(
        email: email.trim(), password: password.trim());
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
