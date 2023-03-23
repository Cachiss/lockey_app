import 'package:app/widgets/cards/thing_card.dart';
import 'package:app/widgets/cards/user_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:app/auth/auth.dart';
import 'package:app/auth/auth_checker.dart';
import 'package:provider/provider.dart';

import '../../widgets/drawer/drawer_widget.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final Auth auth = Auth();
  @override
  Widget build(BuildContext context) {
    //consume provider
    User? user = Provider.of<User?>(context);
    print("Hola: ${user?.email}");
    return AuthChecker(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black,
          title: const Text("Lockey",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontFamily: 'Playfair',
                  fontWeight: FontWeight.w500)),
        ),
        drawer: DrawerWidget(),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  ThingCard(
                    child: Container(),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
