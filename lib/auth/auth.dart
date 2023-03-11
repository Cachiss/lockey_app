import 'package:firebase_auth/firebase_auth.dart';
import 'package:app/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth with ChangeNotifier {
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
      String name, String email, String password, Function setError) async {
    try {
      print("email: $email, password: $password");
      await _auth.createUserWithEmailAndPassword(
          email: email.trim(), password: password.trim());
      //await _userManager.addUser(name, email);
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

  Future<void> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    //info del usuario
    print("googleUser: ${googleUser}");
    await _auth.signInWithCredential(credential);
  }

  Future<void> signOutGoogle() async {
    await GoogleSignIn().signOut();
  }
}
