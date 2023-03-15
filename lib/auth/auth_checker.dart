import 'package:app/pages/get_started_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthChecker extends StatelessWidget {
  final Widget child;
  const AuthChecker({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    if (user == null) {
      return const GetStarted();
    } else {
      return child;
    }
  }
}
