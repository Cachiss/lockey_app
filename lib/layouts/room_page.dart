import 'package:app/widgets/drawer/drawer_widget.dart';
import 'package:flutter/material.dart';

class LockeyLayout extends StatelessWidget {
  final Widget child;
  const LockeyLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: child,
      ),
    );
  }
}
