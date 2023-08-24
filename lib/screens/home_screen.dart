import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:social_app/bloc/bloc_home/home_cubit.dart';
import 'package:social_app/screens/new_post_screen.dart';
import 'package:social_app/themes/themes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeCubit bloc = HomeCubit.get(context);
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is HomeChangeBottomNavToPost) {
          Get.to(const NewPostScreen());
        }
      },
      builder: (context, state) {
        return Scaffold(
          extendBody: true,
          appBar: AppBar(
            title: Text(bloc.titles[bloc.currentIndex.index]),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () {},
                icon: SvgPicture.asset('asset/icons/notofication.svg'),
              ),
              IconButton(
                onPressed: () {},
                icon: SvgPicture.asset('asset/icons/search.svg'),
              ),
            ],
          ),
          body: bloc.screens[bloc.currentIndex.index],
          bottomNavigationBar: MyBottomNavBar(
            currentIndex: bloc.currentIndex,
            onTap: (value) => bloc.changeBottomNav(value),
          ),
        );
      },
    );
  }
}

enum Menu {
  home,
  chat,
  addPost,
  users,
  settings,
}

class MyBottomNavBar extends StatelessWidget {
  final Menu currentIndex;
  final ValueChanged<Menu> onTap;

  const MyBottomNavBar(
      {super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 78,
      margin: const EdgeInsets.all(10),
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: 7,
            child: Container(
              height: 70,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: IconButton(
                      onPressed: () {
                        onTap(Menu.home);
                      },
                      icon: SvgPicture.asset(
                        'asset/icons/home.svg',
                        colorFilter: ColorFilter.mode(
                          currentIndex == Menu.home
                              ? Colors.black
                              : Colors.black.withOpacity(0.3),
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      onPressed: () {
                        onTap(Menu.chat);
                      },
                      icon: SvgPicture.asset(
                        'asset/icons/chat.svg',
                        colorFilter: ColorFilter.mode(
                          currentIndex == Menu.chat
                              ? Colors.black
                              : Colors.black.withOpacity(0.3),
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                  Expanded(child: Container()),
                  Expanded(
                    child: IconButton(
                      onPressed: () {
                        onTap(Menu.users);
                      },
                      icon: SvgPicture.asset(
                        'asset/icons/location.svg',
                        colorFilter: ColorFilter.mode(
                          currentIndex == Menu.users
                              ? Colors.black
                              : Colors.black.withOpacity(0.3),
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      onPressed: () {
                        onTap(Menu.settings);
                      },
                      icon: SvgPicture.asset(
                        'asset/icons/setting.svg',
                        colorFilter: ColorFilter.mode(
                          currentIndex == Menu.settings
                              ? Colors.black
                              : Colors.black.withOpacity(0.3),
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Card(
            margin: const EdgeInsets.only(bottom: 15),
            elevation: 5,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            child: SizedBox(
              width: 60,
              height: 60,
              child: InkWell(
                onTap: () => onTap(Menu.addPost),
                child: const Icon(
                  Icons.add,
                  size: 30,
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
