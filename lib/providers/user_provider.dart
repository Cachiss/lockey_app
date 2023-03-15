import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String _name = "";
  String _email = "";
  String _password = "";
  String? _photoUrl;
  String? _phone;

  String get name => _name;
  String get email => _email;
  String get password => _password;
  String? get photoUrl => _photoUrl;
  String? get phone => _phone;

  set name(String name) {
    _name = name;
    notifyListeners();
  }

  set email(String email) {
    _email = email;
    notifyListeners();
  }

  set password(String password) {
    _password = password;
    notifyListeners();
  }

  set photoUrl(String? photoUrl) {
    _photoUrl = photoUrl;
    notifyListeners();
  }

  set phone(String? phone) {
    _phone = phone;
    notifyListeners();
  }
}
