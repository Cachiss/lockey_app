import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final db = FirebaseFirestore.instance;

  Future<void> addUser(Map<String, dynamic> data) async {
    await db.collection('users').add(data);
  }

  Future<void> addFingerprint(Map<String, dynamic> data) async {
    //query de todos los id de cada documento de la colección fingerprints
    final users = await db.collection('fingerprints').get();
    final List ids = [];

    users.docs.forEach((element) {
      ids.add(element.data()['id_fingerprint']);
    });
    int id = 1;
    while (ids.contains(id)) {
      //generate number 1-255
      id = Random().nextInt(255) + 1;
    }
    data['id_fingerprint'] = id;
    await db.collection('fingerprints').add(data);
  }

  //get all fingerprints
  Future<List> getAllFingerprints() async {
    final users = await db.collection('fingerprints').get();
    List<Map<String, dynamic>> list = [];
    users.docs.forEach((element) {
      print(element.data());
      Map<String, dynamic> userData = element.data();
      userData['id_user'] = element.id;
      list.add(userData);
    });
    print(list);
    return list;
  }

  Future<void> deleteFingerprint(String id) async {
    await db.collection('fingerprints').doc(id).delete();
  }

  Future<void> updateFingerprint(String id, String name) async {
    await db.collection('fingerprints').doc(id).update({'name': name});
  }

  //get user by email
  Future<Map<String, dynamic>?> getUserByEmail(String email) async {
    final users = await db.collection('users').get();
    Map<String, dynamic>? userData;
    users.docs.forEach((element) {
      if (element.data()['email'] == email) {
        userData = element.data();
        userData?['id_user'] = element.id;
      }
    });
    return userData;
  }
}
