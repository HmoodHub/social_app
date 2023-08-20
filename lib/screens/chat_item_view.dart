import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/bloc/bloc_home/home_cubit.dart';
import 'package:social_app/screens/chat_send_get_message_screen.dart';

Widget chatItemView({
  required HomeCubit bloc,
  required index,
}) {
  return ListTile(
    onTap: () {
      Get.to(
        ChatSendGetMessageScreen(
          user: bloc.userList[index],
        ),
      );
    },
    title: Text(bloc.userList[index].username),
    leading: CircleAvatar(
      radius: 25,
      backgroundImage: NetworkImage(bloc.userList[index].image),
    ),
  );
}
