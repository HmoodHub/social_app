// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/models/chat_message.dart';
import 'package:social_app/models/new_post_model.dart';
import 'package:social_app/models/username_model.dart';
import 'package:social_app/shared_pref/shared_pref.dart';

class FBStore {
  static final _firestore = FirebaseFirestore.instance;
  static final _storage = FirebaseStorage.instance;
  static final _storageRef = _storage.ref();
  static String? urlImageProfile;
  static String? urlImageCover;
  static String? urlImagePost;
  static List<String> postsId = <String>[];
  static List<int> likesNum = <int>[];

  static Future<bool> uploadProfileImage({required XFile? profileImage}) async {
    if (profileImage != null) {
      return _storageRef
          .child('users/${Uri.file(profileImage.path).pathSegments.last}')
          .putFile(File(profileImage.path))
          .then((value) async {
        urlImageProfile = await value.ref.getDownloadURL();
        return true;
      }).catchError((onError) => false);
    } else {
      return false;
    }
  }

  static Future<bool> uploadCoverImage({required XFile? coverImage}) async {
    if (coverImage != null) {
      return _storageRef
          .child('users/${Uri.file(coverImage.path).pathSegments.last}')
          .putFile(File(coverImage.path))
          .then((value) async {
        urlImageCover = await value.ref.getDownloadURL();
        return true;
      }).catchError((onError) => false);
    } else {
      return false;
    }
  }

  static Future<bool> uploadPostImage({required XFile? postImage}) async {
    if (postImage != null) {
      return _storageRef
          .child('posts/${Uri.file(postImage.path).pathSegments.last}')
          .putFile(File(postImage.path))
          .then((value) async {
        urlImagePost = await value.ref.getDownloadURL();
        return true;
      }).catchError((onError) => false);
    } else {
      return false;
    }
  }

  static Future<bool> createNewPost({required Post post}) async {
    return _firestore
        .collection('Post')
        .add(post.toMap())
        .then((value) => true)
        .catchError((onError) => false);
  }

  static Future<List<Post>> getDataPosts() async {
    QuerySnapshot snapshot = await _firestore.collection('Post').get();
    List<Post> posts = <Post>[];
    for (var element in snapshot.docs) {
      postsId.add(element.id);
      posts.add(Post.fromMap(element.data() as Map<String, dynamic>));
      QuerySnapshot snapshot = await element.reference.collection('Like').get();
      likesNum.add(snapshot.docs.length);
    }
    if (posts.isNotEmpty) {
      return posts;
    }
    return [];
  }

  static Future<bool> postsLike({required index}) async {
    return _firestore
        .collection('Post')
        .doc(postsId[index])
        .collection('Like')
        .doc(SharedPref().userId)
        .set({'like': true})
        .then((value) => true)
        .catchError((onError) => false);
  }

  static Future<List<Username>> getAllUser() async {
    QuerySnapshot snapshot = await _firestore.collection('User').get();
    List<Username> usersList = <Username>[];
    for (var element in snapshot.docs) {
      if (element.id != SharedPref().userId) {
        usersList.add(Username.fromMap(element.data() as Map<String, dynamic>));
      }
    }
    if (usersList.isNotEmpty) {
      return usersList;
    }
    return [];
  }

  static Future<bool> sendMessage1({
    required String myId,
    required String receiverId,
    required ChatMessage chatMessage,
  }) async {
    return _firestore
        .collection('User')
        .doc(myId)
        .collection('Chat')
        .doc(receiverId)
        .collection('messages')
        .add(chatMessage.toMap())
        .then((value) => true)
        .catchError((onError) {
      print(onError.toString());
      return false;
    });
  }

  static Future<bool> sendMessage2({
    required String myId,
    required String receiverId,
    required ChatMessage chatMessage,
  }) async {
    return _firestore
        .collection('User')
        .doc(receiverId)
        .collection('Chat')
        .doc(myId)
        .collection('messages')
        .add(chatMessage.toMap())
        .then((value) => true)
        .catchError((onError) {
      print(onError.toString());
      return false;
    });
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getMessages({
    required myId,
    required yourId,
  }) {
    return _firestore
        .collection('User')
        .doc(myId)
        .collection('Chat')
        .doc(yourId)
        .collection('messages')
        .orderBy('dateTime', descending: true)
        .snapshots();
  }
}
