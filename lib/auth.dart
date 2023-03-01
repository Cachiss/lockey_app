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

  Future<bool?> signUpWithEmailAndPassword(
      String email, String password, Function setError) async {
    try {
      print("email: $email, password: $password");
      await _auth.createUserWithEmailAndPassword(
          email: email.trim(), password: password.trim());

      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        setError("La contraseña es muy débil");
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        setError("El correo ya está en uso");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
