import 'package:flutter/material.dart';

class AppBarLockey extends StatelessWidget {
  const AppBarLockey({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.black,
      title: const Text("Lockey",
          style: TextStyle(
              color: Colors.white,
              fontSize: 40,
              fontFamily: 'Playfair',
              fontWeight: FontWeight.w500)),
    );
  }
}
