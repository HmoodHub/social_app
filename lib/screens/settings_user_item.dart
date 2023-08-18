import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget settingUserItem(BuildContext context, {
  required String num,
  required String label,
  void Function()? onTap
}){
  return InkWell(
    onTap: onTap,
    child: Column(
      children: [
        Text(num, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(
          height: 7,
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
            color: Colors.grey,
          ),
        ),
      ],
    ),
  );
}