import 'package:app/widgets/drawer/drawer_widget.dart';
import 'package:flutter/material.dart';

class LivingRoomPage extends StatelessWidget {
  const LivingRoomPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyWidget'),
      ),
      drawer: const DrawerWidget(),
      body: const Center(
        child: Text('Hello World'),
      ),
    );
  }
}
