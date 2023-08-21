// ignore_for_file: must_be_immutable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:social_app/bloc/bloc_home/home_cubit.dart';
import 'package:social_app/firebase/firestore/fb_store.dart';
import 'package:social_app/models/username_model.dart';
import 'package:social_app/themes/themes.dart';
import 'package:social_app/widget/widget_app.dart';

class ChatSendGetMessageScreen extends StatelessWidget {
  ChatSendGetMessageScreen({required this.user, super.key});

  Username user;

  @override
  Widget build(BuildContext context) {
    HomeCubit bloc = HomeCubit.get(context);
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: WidgetApp().appBarApp(
            title: Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundImage: NetworkImage(user.image),
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  user.username,
                ),
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 10.0,
            ),
            child: Column(
              children: [
                Expanded(
                  child: messageItems(bloc, user.id),
                ),
                Row(
                  children: [
                    Expanded(
                      child: WidgetApp().textFieldApp(
                        controller: bloc.sendMessageToFriend,
                        textInputType: TextInputType.text,
                        hint: 'message...',
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            topRight: Radius.zero,
                            bottomRight: Radius.zero,
                          ),
                        ),
                      ),
                    ),
                    WidgetApp().buttonApp(
                      onPress: () {
                        bloc.sendMessage(receiveId: user.id);
                      },
                      foregroundColor: Colors.black,
                      backgroundColor: HexColor('#4FC0D0'),
                      width: 50,
                      height: 60,
                      childButton: const Icon(
                        Icons.send_rounded,
                      ),
                      elevation: 0,
                      border: const BorderRadius.only(
                        topRight: Radius.circular(
                          10,
                        ),
                        topLeft: Radius.zero,
                        bottomLeft: Radius.zero,
                        bottomRight: Radius.circular(
                          10,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget messageItems(HomeCubit bloc, id2) {
  return StreamBuilder(
    stream: FBStore.getMessages(myId: bloc.username.id, yourId: id2),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Container();
      } else {
        final docs = snapshot.data!.docs;
        return ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(
            height: 10,
          ),
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            if (bloc.username.id == docs[index]['senderId']) {
              return Align(
                alignment: Alignment.topRight,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    color: Themes.bg,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      topLeft: Radius.circular(10),
                    ),
                  ),
                  child: Text(
                    docs[index]['message'],
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
              );
            } else {
              return Align(
                alignment: Alignment.topLeft,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  child: Text(
                    docs[index]['message'],
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
              );
            }
          },
          itemCount: docs.length,
        );
      }
    },
  );
}
