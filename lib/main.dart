import 'package:app/certs_manager/certs_manager.dart';
import 'package:app/pages/auth/register_page.dart';
import 'package:app/pages/bedroom/bedroom_page.dart';
import 'package:app/pages/get_started_page.dart';
import 'package:app/pages/home/home_page.dart';
import 'package:app/pages/kitchen/kitchen_page.dart';
import 'package:app/pages/leds_control/leds_control_page.dart';
import 'package:app/pages/living_room/living_room_page.dart';
import 'package:app/providers/topic_values.dart';
import 'package:app/providers/topic_values.dart';
import 'package:app/services/mqtt_client_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:app/pages/auth/login_page.dart';

import 'package:firebase_core/firebase_core.dart';
import 'auth/auth.dart';
import 'firebase_options.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:app/services/mqtt_client_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); //Arregla error:  fix ERROR:flutter/runtime/dart_vm_initializer.cc

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await CertificateManager.init();

  runApp(
    MultiProvider(
      providers: [
        StreamProvider<User?>.value(
          value: Auth().authStateChanges,
          initialData: null,
        ),
        ChangeNotifierProvider<TopicValueProvider>.value(
            value: TopicValueProvider())
      ],
      child: const LockeyApp(),
    ),
  );
}

class LockeyApp extends StatelessWidget {
  const LockeyApp({super.key});

  @override
  Widget build(BuildContext context) {
    TopicValueProvider topicValueProvider =
        Provider.of<TopicValueProvider>(context);
    topicValueProvider.test = "esta es la prueba no mames";
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lockey App',
      home: GetStarted(),
      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/home': (context) => HomePage(),
        '/livingroom': (context) => const LivingRoomPage(),
        '/kitchen': (context) => KitchenPage(),
        '/bedroom': (context) => BedroomPage(),
      },
    );
  }
}
