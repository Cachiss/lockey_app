import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import '../../auth/auth.dart';
import '../cards/user_card.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<User?>(context);

    final Auth auth = Auth();
    return Drawer(
      child: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              Container(
                height: 80,
                color: Colors.black,
              ),
              const SizedBox(
                height: 10,
              ),
              CardUser(email: user?.email ?? "", photo: user?.photoURL),
              const SizedBox(
                height: 50,
              ),
              //list of pages with icons
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text("Inicio"),
                onTap: () {
                  Navigator.pushNamed(context, "/home");
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.chair),
                title: const Text("Sala"),
                onTap: () {
                  Navigator.pushNamed(context, "/livingroom");
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.bedtime),
                title: const Text("Dormitorio"),
                onTap: () {
                  Navigator.pushNamed(context, "/bedroom");
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.kitchen),
                title: const Text("Cocina"),
                onTap: () {
                  Navigator.pushNamed(context, "/kitchen");
                },
              ),
              const Divider(),
              //ledcontrol section
              ListTile(
                leading: const Icon(Icons.lightbulb),
                title: const Text("Control de luces"),
                onTap: () {
                  Navigator.pushReplacementNamed(context, "/ledscontrol");
                },
              ),
              Container(
                margin: const EdgeInsets.only(top: 80),
                child: ElevatedButton(
                  onPressed: () {
                    auth.signOut();
                    auth.signOutGoogle();
                  },
                  child: const Text("Cerrar sesión"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
