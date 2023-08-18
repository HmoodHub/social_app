import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:social_app/bloc/bloc_home/home_cubit.dart';
import 'package:social_app/bloc/bloc_home/home_cubit.dart';

import '../themes/themes.dart';
import '../widget/widget_app.dart';

class NewPostScreen extends StatelessWidget {
  const NewPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeCubit bloc = HomeCubit.get(context);
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is HomeCreateNewPostSuccess) {
        Get.back();
        }
      },
      builder: (context, state) {
        var userModel = bloc.username;
        return Scaffold(
          appBar: WidgetApp().appBarApp(
            title: 'Create Post',
            action: [
              TextButton(
                style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 15)),
                onPressed: () async => bloc.createNewPost(),
                child: const Text(
                  'POST',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if(state is HomeCreateNewPostLoading)
                  const LinearProgressIndicator(),
                if(state is HomeCreateNewPostLoading)
                  const SizedBox(height: 10,),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(userModel.image),
                    radius: 30,
                  ),
                  title: Text(userModel.username),
                  subtitle: const Text('Public'),
                ),
                Expanded(
                  child: WidgetApp().textFieldApp(
                    controller: bloc.writeOnPostController,
                    textInputType: TextInputType.text,
                    hint: 'What is on your mind...',
                    border: InputBorder.none,
                  ),
                ),
                if (bloc.postImage != null)
                  SizedBox(
                    height: 240,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Card(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(
                                  10,
                                ),
                                topRight: Radius.circular(
                                  10,
                                ),
                              ),
                            ),
                            child: Image.file(
                              File(bloc.postImage!.path),
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                bloc.removePostImage();
                              },
                              child: CircleAvatar(
                                radius: 20,
                                backgroundColor: Themes.bg,
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                const SizedBox(height: 50,),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            bloc.pickPostImage();
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.image_outlined,
                                color: Colors.blue,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'add photos',
                                style: TextStyle(color: Colors.blue),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: const Text(
                            '# tags',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
