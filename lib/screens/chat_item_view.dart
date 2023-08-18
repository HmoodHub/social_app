import 'package:flutter/material.dart';

Widget chatItemView() {
  return const ListTile(
    title: Text('Mohammed Khalid'),
    leading: CircleAvatar(
      radius: 25,
      backgroundImage: NetworkImage('https://img.freepik.com/free-photo/portrait-beautiful-young-woman-standing-grey-wall_231208-10760.jpg?w=1380&t=st=1692303032~exp=1692303632~hmac=ed6bea0bcc3b2ba52ff79602f9570231857667b27cd3c3d043fee5aabc92e844'),
    ),
  );
}
