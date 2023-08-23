import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:social_app/bloc/bloc_home/home_cubit.dart';
import 'package:social_app/screens/new_post_screen.dart';

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
          appBar: AppBar(
            title: Text(bloc.titles[bloc.currentIndex]),
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
          body: bloc.screens[bloc.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            unselectedItemColor: Colors.black,
            selectedItemColor: Colors.red,
            showSelectedLabels:
                Theme.of(context).bottomNavigationBarTheme.showSelectedLabels,
            showUnselectedLabels:
                Theme.of(context).bottomNavigationBarTheme.showUnselectedLabels,
            currentIndex: bloc.currentIndex,
            onTap: (value) {
              bloc.changeBottomNav(value);
            },
            items:  [
              BottomNavigationBarItem(
                icon: SvgPicture.asset('asset/icons/home.svg'),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset('asset/icons/chat.svg'),
                label: 'Chat',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset('asset/icons/add_post.svg'),
                label: 'Post',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset('asset/icons/location.svg'),
                label: 'Users',
              ),
              BottomNavigationBarItem(
                icon:SvgPicture.asset('asset/icons/setting.svg',),
                label: 'Setting',
              ),
            ],
          ),
        );
      },
    );
  }
}
