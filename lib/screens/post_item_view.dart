import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:social_app/bloc/bloc_home/home_cubit.dart';

import '../models/new_post_model.dart';

Widget postItemView({required Post post, required index, required HomeCubit bloc}) {
  return Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: ListTile(
            leading: CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(
                post.image,
              ),
            ),
            title: Row(
              children: [
                Text(
                  post.username,
                ),
                const SizedBox(
                  width: 5,
                ),
                const Icon(
                  Icons.check_circle,
                  color: Colors.blue,
                  size: 16,
                )
              ],
            ),
            subtitle: Text(post.dateTime),
            trailing: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.more_horiz,
              ),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: 1,
          color: Colors.grey,
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            post.content,
            style: const TextStyle(
              fontSize: 14,
              height: 1.3,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
        //   child: Wrap(
        //     children: [
        //       InkWell(
        //           onTap: () {},
        //           child: const Text(
        //             '#Flutter',
        //             style: TextStyle(
        //               color: Colors.blue,
        //             ),
        //           )),
        //       InkWell(
        //           onTap: () {},
        //           child: const Text(
        //             '#Softwar',
        //             style: TextStyle(
        //               color: Colors.blue,
        //             ),
        //           )),
        //       InkWell(
        //           onTap: () {},
        //           child: const Text(
        //             '#Softwar',
        //             style: TextStyle(
        //               color: Colors.blue,
        //             ),
        //           )),
        //       InkWell(
        //           onTap: () {},
        //           child: const Text(
        //             '#Softwar',
        //             style: TextStyle(
        //               color: Colors.blue,
        //             ),
        //           )),
        //       InkWell(
        //           onTap: () {},
        //           child: const Text(
        //             '#Softwar',
        //             style: TextStyle(
        //               color: Colors.blue,
        //             ),
        //           )),
        //     ],
        //   ),
        // ),
        if (post.postImage != '')
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Image.network(
              post.postImage,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
        Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    bloc.likePosts(index: index);
                  },
                  child:  Row(
                    children: [
                      SvgPicture.asset('asset/icons/favorite.svg',color: Colors.red,),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        '${bloc.likeNumber[index]}',
                        style: const TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Row(
                  children: [
                    SvgPicture.asset('asset/icons/body_chat.svg',color: HexColor('#E2D997'),),
                    const SizedBox(
                      width: 5,
                    ),
                    const Text(
                      '0 comment',
                      style: TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          height: 1,
          color: Colors.grey,
        ),
        Row(
          children: [
            Expanded(
              flex: 4,
              child: ListTile(
                onTap: () {},
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(post.image),
                ),
                title: const Text(
                  'Write a comment...',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            const Spacer(),
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {
                  bloc.likePosts(index: index);
                },
                child:  Row(
                  children: [
                    SvgPicture.asset('asset/icons/favorite.svg',color: Colors.red,),
                    const SizedBox(
                      width: 5,
                    ),
                    const Text(
                      'Like',
                      style: TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            )
          ],
        )
      ],
    ),
  );
}
