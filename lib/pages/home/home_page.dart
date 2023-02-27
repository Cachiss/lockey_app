import 'package:flutter/material.dart';
import 'package:app/auth.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final Auth auth = Auth();
  @override
  Widget build(BuildContext context) {
    auth.authStateChanges.listen((user) {
      if (user == null) {
        print('No ha iniciado sesión');
        Navigator.pushNamed(context, '/login');
      } else {
        print('Ha iniciado sesión');
      }
    });

    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: Container(
          child: Column(
            children: [
              Center(
                child: Text("Esta es la página de Home"),
              ),
              ElevatedButton(
                onPressed: () {
                  auth.signOut();
                },
                child: Text("Cerrar sesión"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
