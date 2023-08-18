import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:social_app/bloc/bloc_home/home_cubit.dart';
import 'package:social_app/bloc/bloc_home/home_cubit.dart';
import 'package:social_app/screens/edit_profile_screen.dart';
import 'package:social_app/screens/settings_user_item.dart';
import 'package:social_app/themes/themes.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeCubit bloc = HomeCubit.get(context);
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var model = bloc.username;
        return Column(
          children: [
            const SizedBox(height: 10,),
            SizedBox(
              height: 240,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Card(
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
                      child: Image.network(
                        model.cover,
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: Themes.bg,
                    radius: 65,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(model.image),
                      radius: 60,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              model.username,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              model.bio,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  settingUserItem(context,
                      num: '100', label: 'Posts', onTap: () {},),
                  settingUserItem(context,
                      num: '275', label: 'Photos', onTap: () {},),
                  settingUserItem(context,
                      num: '10k', label: 'Followers', onTap: () {},),
                  settingUserItem(context,
                      num: '5', label: 'Followings', onTap: () {},),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: GFButton(
                      onPressed: () {},
                      type: GFButtonType.outline,
                      child: const Text('ADD PHOTOS'),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  GFButton(
                    onPressed: () {
                      Get.to(const EditProfileScreen());
                    },
                    type: GFButtonType.outline,
                    child: const Icon(
                      Icons.edit,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
