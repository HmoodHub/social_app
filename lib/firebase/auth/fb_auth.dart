import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_app/shared_pref/shared_pref.dart';

import '../../models/username_model.dart';

class FBAuth {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static UserCredential? userCredential;

  static Future<bool> loginUser(email, password) async {
    return _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      SharedPref().setUserId(value.user?.uid);
      return true;
    }).catchError((onError) => false);
  }

  static Future<bool> registerUser({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String cover,
    required String image,
    required String bio,

  }) async {
    return _auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      userCredential ??= value;
      createUser(
        name: name,
        email: email,
        phone: phone,
        image: image,
        cover: cover,
        bio: bio,
        uid: userCredential!.user!.uid,
      );
      return true;
    }).catchError((onError) => false);
  }

  static Future<void> createUser({
    required String name,
    required String email,
    required String phone,
    required String image,
    required String cover,
    required String bio,
    required String uid,
  }) async {
    Username user = Username(
      id: uid,
      username: name,
      email: email,
      phone: phone,
      image: image,
      cover: cover,
      bio: bio,
    );
    _firestore.collection('User').doc(uid).set(user.toMap());
  }

  static Future<bool> logout() async {
    return _auth.signOut().then((value) => true).catchError((onError) => false);
  }

  static Future<Map<String, dynamic>> getDataUser({required String id}) async {
    DocumentSnapshot snapshot =
        await _firestore.collection('User').doc(id).get();
    if (snapshot.exists) {
      return snapshot.data() as Map<String, dynamic>;
    } else {
      return {};
    }
  }

  static Future<bool> updateProfile({required Username userModel}) async {
    return _firestore
        .collection('User')
        .doc(userModel.id)
        .update(userModel.toMap())
        .then((value) {
      getDataUser(id: userModel.id);
      print('success');
      return true;
    }).catchError((onError) => false);
  }
}
