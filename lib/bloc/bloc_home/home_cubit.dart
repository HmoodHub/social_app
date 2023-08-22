import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:social_app/firebase/auth/fb_auth.dart';
import 'package:social_app/firebase/firestore/fb_store.dart';
import 'package:social_app/models/chat_message.dart';
import 'package:social_app/models/new_post_model.dart';
import 'package:social_app/models/username_model.dart';
import 'package:social_app/screens/chat_screen.dart';
import 'package:social_app/screens/feeds_screen.dart';
import 'package:social_app/screens/new_post_screen.dart';
import 'package:social_app/screens/setting_screen.dart';
import 'package:social_app/shared_pref/shared_pref.dart';

import '../../screens/users_screen.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of<HomeCubit>(context);
  late List<Widget> screens;

  late List<String> titles;

  late Username username;

  late TextEditingController profileNameController;
  late TextEditingController profileBioController;
  late TextEditingController profilePhoneController;
  late TextEditingController writeOnPostController;
  late TextEditingController sendMessageToFriend;
  List<Post> posts = [];
  List<int> likeNumber = [];

  void onStartHome() async {
    screens = <Widget>[
      const FeedsScreen(),
      const ChatScreen(),
      const NewPostScreen(),
      const UsersScreen(),
      const SettingScreen(),
    ];
    titles = <String>[
      'Feeds',
      'Chat',
      'New Post',
      'Users',
      'Setting',
    ];
    if (SharedPref().userId != null) {
      final userId = SharedPref().userId;
      final dataUser = await FBAuth.getDataUser(id: userId!);
      if (dataUser != null) {
        username = Username.fromMap(dataUser);
      }
    }
    profileBioController = TextEditingController(text: username.bio);
    profileNameController = TextEditingController(text: username.username);
    profilePhoneController = TextEditingController(text: username.phone);
    writeOnPostController = TextEditingController();
    sendMessageToFriend = TextEditingController();
    posts = await FBStore.getDataPosts();
    likeNumber = FBStore.likesNum;
    emit(HomeInitial());
  }

  int currentIndex = 0;

  void changeBottomNav(int value) {
    if (value == 2) {
      print(username.id);
      emit(HomeChangeBottomNavToPost());
    } else {
      currentIndex = value;
      emit(HomeChangeBottomNav());
    }
    if (value == 1) {
      allUsers();
      emit(HomeChangeBottomNavGetAllUser());
    }
  }

  var picker = ImagePicker();
  XFile? profileImage;
  XFile? coverImage;

  Future<void> pickProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      if (profileImage == null) {
        profileImage = pickedFile;
        emit(HomePickProfileImageSuccess());
      }
    } else {
      emit(HomePickProfileImageError());
    }
  }

  Future<void> pickCoverImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      if (coverImage == null) {
        coverImage = pickedFile;
        emit(HomePickCoverImageSuccess());
      }
    } else {
      emit(HomePickCoverImageError());
    }
  }

  ImageProvider<Object> profile(model) {
    if (profileImage == null) {
      return NetworkImage(model.image);
    } else {
      return FileImage(File(profileImage!.path));
    }
  }

  void updateProfile() async {
    Username updateProfileUser = Username(
      id: username.id,
      username: profileNameController.text,
      email: username.email,
      phone: profilePhoneController.text,
      image: FBStore.urlImageProfile ?? username.image,
      cover: FBStore.urlImageCover ?? username.cover,
      bio: profileBioController.text,
    );
    emit(HomeUpdateProfileLoading());
    FBStore.uploadCoverImage(
      coverImage: coverImage,
    ).then((value) {
      FBStore.uploadProfileImage(profileImage: profileImage).then((value) {
        FBAuth.updateProfile(userModel: updateProfileUser).then((value) async {
          print('${FBStore.urlImageProfile}');
          print('${FBStore.urlImageCover}');
          username =
              Username.fromMap(await FBAuth.getDataUser(id: username.id));
          value
              ? emit(HomeUpdateProfileSuccess())
              : emit(HomeUpdateProfileError());
        }).catchError((onError) {
          print('error in Update Profile is ${onError.toString()}');
          emit(HomeUpdateProfileError());
        });
      }).catchError((onError) {
        print('On upload profile image ${onError.toString()}');
        emit(HomeUploadProfileImageError());
      });
    }).catchError((onError) {
      print('On upload cover image ${onError.toString()}');
      emit(HomeUploadCoverImageError());
    });
  }

  XFile? postImage;

  Future<void> pickPostImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      if (postImage == null) {
        postImage = pickedFile;
        emit(HomePickPostImageSuccess());
      }
    } else {
      emit(HomePickPostImageError());
    }
  }

  void removePostImage() {
    postImage = null;
    emit(HomeRemovePostImage());
  }

  Post get post {
    Post post = Post(
      id: username.id,
      username: username.username,
      image: username.image,
      content: writeOnPostController.text,
      dateTime: DateTime.now().toString(),
      postImage: FBStore.urlImagePost ?? '',
    );
    return post;
  }

  void createNewPost() async {
    emit(HomeCreateNewPostLoading());
    FBStore.uploadPostImage(postImage: postImage).then((value) {
      FBStore.createNewPost(post: post).then((value) async {
        if (value) {
          posts = await FBStore.getDataPosts();
          emit(HomeCreateNewPostSuccess());
        } else {
          emit(HomeCreateNewPostError());
        }
      }).catchError((onError) {
        print(onError.toString());
        emit(HomeCreateNewPostError());
      });
      emit(HomeUploadPostImageSuccess());
    }).catchError((onError) {
      print(onError.toString());
      emit(HomeUploadPostImageError());
    });
  }

  void likePosts({required index}) async {
    bool liked = await FBStore.postsLike(index: index);
    if (liked) {
      emit(HomeLikePostSuccess());
    } else {
      emit(HomeLikePostError());
    }
  }

  List<Username> userList = [];

  void allUsers() async {
    emit(HomeGetAllUserLoading());
    userList = await FBStore.getAllUser();
    if (userList.isNotEmpty) {
      emit(HomeGetAllUserSuccess());
    } else {
      emit(HomeGetAllUserError());
    }
  }

  void sendMessage({required String receiveId}) async {
    ChatMessage message = ChatMessage(
      dateTime: DateTime.now().toString(),
      senderId: username.id,
      receiverId: receiveId,
      message: sendMessageToFriend.text,
    );
    bool send1 = await FBStore.sendMessage1(
      myId: username.id,
      receiverId: receiveId,
      chatMessage: message,
    );
    bool send2 = await FBStore.sendMessage2(
      myId: username.id,
      receiverId: receiveId,
      chatMessage: message,
    );

    if (send1) {
      if (send2) {
        sendMessageToFriend.clear();
        emit(HomeSendMessageSuccess());
      } else {
        emit(HomeSendMessageError());
      }
    } else {
      emit(HomeSendMessageError());
    }
  }


  List<ChatMessage> messages = [];
}
