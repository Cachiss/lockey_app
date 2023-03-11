import 'package:app/pages/auth/register_page.dart';
import 'package:app/pages/get_started_page.dart';
import 'package:app/pages/home/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:app/pages/auth/login_page.dart';

import 'package:firebase_core/firebase_core.dart';
import 'auth/auth.dart';
import 'firebase_options.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); //Arregla error:  fix ERROR:flutter/runtime/dart_vm_initializer.cc
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Auth()),
        StreamProvider<User?>.value(
          value: Auth().authStateChanges,
          initialData: null,
        ),
      ],
      child: const LockeyApp(),
    ),
  );
}

class LockeyApp extends StatelessWidget {
  const LockeyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lockey App',
      home: GetStarted(),
      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/home': (context) => HomePage(),
      },
    );
  }
}
