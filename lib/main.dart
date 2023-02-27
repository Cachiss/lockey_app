import 'package:app/pages/home/home_page.dart';
import 'package:flutter/material.dart';

import 'package:app/pages/login/login_page.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); //Arregla error:  fix ERROR:flutter/runtime/dart_vm_initializer.cc
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const LockeyApp());
}

class LockeyApp extends StatelessWidget {
  const LockeyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('es', 'ES'),
      ],
      title: 'Lockey App',
      home: HomePage(),
      routes: {
        '/login': (context) => const LoginPage(),
      },
    );
  }
}
