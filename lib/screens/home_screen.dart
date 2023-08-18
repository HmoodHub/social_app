import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

            title:  Text(bloc.titles[bloc.currentIndex]),
            centerTitle: true,
            actions: [
              IconButton(onPressed: (){}, icon: const Icon(Icons.notifications),),
              IconButton(onPressed: (){}, icon: const Icon(Icons.search),),
            ],
          ),
          body: bloc.screens[bloc.currentIndex],
          bottomNavigationBar: BottomNavigationBar(

            type: BottomNavigationBarType.fixed,
            unselectedItemColor: Colors.black,
            selectedItemColor: HexColor('#4E6AFF'),
            showSelectedLabels: Theme.of(context).bottomNavigationBarTheme.showSelectedLabels,
            showUnselectedLabels: Theme.of(context).bottomNavigationBarTheme.showUnselectedLabels,
            currentIndex: bloc.currentIndex,
            onTap: (value) {
              bloc.changeBottomNav(value);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.chat,
                ),
                label: 'Chat',
              ),BottomNavigationBarItem(
                icon: Icon(
                  Icons.post_add,
                ),
                label: 'Post',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.location_on,
                ),
                label: 'Users',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings,
                ),
                label: 'Setting',
              ),
            ],
          ),

        );
      },
    );
  }
}
