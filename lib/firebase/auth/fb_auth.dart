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
    })
        .catchError((onError) => false);
  }

  static Future<bool> registerUser(Username username,password) async {
    return _auth
        .createUserWithEmailAndPassword(email: username.email, password: password)
        .then((value) {
      if (userCredential == null) {
        userCredential = value;
        _firestore
            .collection('User')
            .doc(userCredential!.user!.uid)
            .set(username.toMap());
      }
      return true;
    }).catchError((onError) => false);
  }

  static Future<bool> logout() async {
    return _auth.signOut().then((value) => true).catchError((onError) => false);
  }
  
  static Future<Map<String, dynamic>> getDataUser() async{
     DocumentSnapshot snapshot = await  _firestore.collection('User').doc(SharedPref().userId).get();
     if(snapshot.exists){
       return snapshot.data() as Map<String, dynamic>;
     }else
       {
         return {};
       }

  }
  
  static Future<bool> updateProfile({required Username userModel})async{
    return _firestore.collection('User').doc(SharedPref().userId).update(userModel.toMap()).then((value) {
      getDataUser();
      print('success');
      return true;
    }).catchError((onError) => false);
  }


}
