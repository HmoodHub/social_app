import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:social_app/bloc/bloc_home/home_cubit.dart';
import 'package:social_app/bloc/bloc_login/login_cubit.dart';
import 'package:social_app/bloc/bloc_register/register_cubit.dart';
import 'package:social_app/firebase/notification/fb_notifications.dart';
import 'package:social_app/screens/auth/launch_screen.dart';
import 'package:social_app/shared_pref/shared_pref.dart';
import 'package:social_app/themes/themes.dart';
import 'bloc/observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SharedPref().initPref();
  Bloc.observer = MyBlocObserver();
  await FbNotification.initNotification();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginCubit()..onStartLogin(),
        ),
        BlocProvider(
          create: (context) => RegisterCubit()..onStartRegister(),
        ),
        BlocProvider(
          create: (context) => HomeCubit()..onStartHome(),
        ),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Ubuntu',
          scaffoldBackgroundColor: Themes.bg,
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Themes.bg,
            elevation: 0,
            selectedItemColor: Themes.bg,
            showSelectedLabels: false,
            showUnselectedLabels: false,
          ),
          appBarTheme: AppBarTheme(
            centerTitle: true,
            backgroundColor: Themes.bg,
            elevation: 0,
            foregroundColor: Colors.black,
          ),
          useMaterial3: true,
          // brightness: Brightness.dark
        ),
        home:const LaunchScreen(),
      ),
    );
  }
}
