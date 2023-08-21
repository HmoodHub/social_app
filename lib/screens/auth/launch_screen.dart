import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:social_app/screens/auth/login_screen.dart';
import 'package:social_app/screens/home_screen.dart';

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({super.key});

  @override
  State<LaunchScreen> createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
late Widget screen;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    screen = StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const HomeScreen();
        } else {
          return  const LoginScreen();
        }
      },
    );
    Future.delayed(
      const Duration(seconds: 3),
      () {
        Get.off(screen);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: HexColor('#E7EFFF'),
        ),
        Center(
          child: SizedBox(
            width: 100,
            height: 100,
            child: Image.asset(
              'asset/images/messanger.png',
              width: 100,
              height: 100,
            ),
          ),
        ),
      ],
    );
  }
}
