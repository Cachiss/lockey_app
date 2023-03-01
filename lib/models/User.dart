import 'package:cloud_firestore/cloud_firestore.dart';

class UserManager {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addUser(
    String name,
    String email,
  ) async {
    final user = <String, String>{
      'name': name,
      'email': email,
    };
    await _db.collection('users').doc().set(user);
  }

  Future<DocumentSnapshot> getUser(String uid) async {
    return await _db.collection('users').doc(uid).get();
  }
}
