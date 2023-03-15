import 'package:flutter/material.dart';
import 'package:app/auth/auth.dart';
import 'package:app/auth/auth_checker.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final Auth auth = Auth();
  @override
  Widget build(BuildContext context) {
    return AuthChecker(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.all(20),
          child: Container(
            child: Column(
              children: [
                const Center(
                  child: Text("Esta es la página de Home"),
                ),
                ElevatedButton(
                  onPressed: () {
                    auth.signOut();
                    auth.signOutGoogle();
                  },
                  child: Text("Cerrar sesión"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
