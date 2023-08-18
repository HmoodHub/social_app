import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/bloc/bloc_home/home_cubit.dart';
import 'package:social_app/bloc/bloc_home/home_cubit.dart';
import 'package:social_app/firebase/firestore/fb_store.dart';
import 'package:social_app/screens/post_item_view.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeCubit bloc = HomeCubit.get(context);
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) async{
        if (state is HomeLikePostSuccess) {
          bloc.posts = await FBStore.getDataPosts();
          bloc.likeNumber = FBStore.likesNum;
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: bloc.posts.isNotEmpty,
          builder: (context) => SingleChildScrollView(
            child: Column(
              children: [
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 10,
                  child: Image.network(
                    bloc.username.cover,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 10),
                // Add spacing between the image and the list
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  // Disable scrolling of the list
                  itemBuilder: (context, index) =>
                      postItemView(post: bloc.posts[index],bloc: bloc,index: index),
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 5,
                  ),
                  itemCount: bloc.posts.length,
                ),
              ],
            ),
          ),
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
