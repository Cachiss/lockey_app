import 'package:app/widgets/cards/thing_card.dart';
import 'package:app/widgets/cards/user_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:app/auth/auth.dart';
import 'package:app/auth/auth_checker.dart';
import 'package:provider/provider.dart';

import '../../providers/topic_values.dart';
import '../../widgets/drawer/drawer_widget.dart';
import '../../widgets/slider/slider_widget.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final Auth auth = Auth();
  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<User?>(context);
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
                  Text(
                    "Hola, ${user?.displayName}",
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Playfair'),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 50),
                    child: ThingCard(
                      child: Container(),
                    ),
                  ),
                  /*Container(
                      margin: const EdgeInsets.only(top: 20),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Luz en la sala Principal",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Playfair'),
                      )),*/
                  //SliderWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
