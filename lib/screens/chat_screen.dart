import 'package:flutter/material.dart';
import 'package:social_app/screens/chat_item_view.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) => chatItemView(),
      separatorBuilder: (context, index) => Divider(thickness: 0.5,color: Colors.grey,),
      itemCount: 10,
    );
  }
}
