import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/screens/chat_item_view.dart';

import '../bloc/bloc_home/home_cubit.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeCubit bloc = HomeCubit.get(context);
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return ConditionalBuilder(
          fallback:(context) => Center(child: CircularProgressIndicator(),) ,
          condition: bloc.userList.isNotEmpty,
          builder: (context) => ListView.separated(
            itemBuilder: (context, index) => chatItemView(index: index, bloc: bloc),
            separatorBuilder: (context, index) => const Divider(
              thickness: 0.5,
              color: Colors.grey,
            ),
            itemCount: bloc.userList.length,
          ),
        );
      },
    );
  }
}
