import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/bloc/bloc_home/home_cubit.dart';

import '../themes/themes.dart';
import '../widget/widget_app.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeCubit bloc = HomeCubit.get(context);
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = bloc.username;
        return Scaffold(
          appBar: WidgetApp().appBarApp(
            title: 'Edit profile',
            action: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextButton(
                  onPressed: () {
                    // bloc.uploadCoverImage();
                    // bloc.uploadProfileImage();
                    bloc.updateProfile();
                  },
                  child: const Text(
                    'UPDATE',
                  ),
                ),
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ListView(
              children: [
                if (state is HomeUpdateProfileLoading)
                  const LinearProgressIndicator(),
                if (state is HomeUpdateProfileLoading)
                  const SizedBox(
                    height: 15,
                  ),
                SizedBox(
                  height: 240,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Align(
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
                              child: bloc.coverImage == null
                                  ? Image.network(
                                      model.cover,
                                      width: double.infinity,
                                      height: 200,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.file(
                                      File(bloc.coverImage!.path),
                                      fit: BoxFit.cover,
                                    ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  bloc.pickCoverImage();
                                },
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Themes.bg,
                                  child: const Icon(
                                    Icons.edit,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            backgroundColor: Themes.bg,
                            radius: 65,
                            child: CircleAvatar(
                              backgroundImage: bloc.profile(model),
                              radius: 60,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              bloc.pickProfileImage();
                            },
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor: Themes.bg,
                              child: const Icon(
                                Icons.edit,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                WidgetApp().textFieldApp(
                  controller: bloc.profileNameController,
                  textInputType: TextInputType.name,
                  borderRadius: 10,
                  label: const Text('Name'),
                ),
                const SizedBox(
                  height: 15,
                ),
                WidgetApp().textFieldApp(
                  controller: bloc.profileBioController,
                  textInputType: TextInputType.text,
                  borderRadius: 10,
                  label: const Text('Bio'),
                ),
                const SizedBox(
                  height: 15,
                ),
                WidgetApp().textFieldApp(
                  controller: bloc.profilePhoneController,
                  textInputType: TextInputType.phone,
                  borderRadius: 10,
                  label: const Text('phone'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
