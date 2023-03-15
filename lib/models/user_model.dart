import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String id = "";
  String name = "";
  String email = "";
  String password = "";
  String? photoUrl;
  String? phone;

  UserModel(
      {required this.id,
      required this.name,
      required this.email,
      required this.password,
      this.photoUrl,
      this.phone});
}
