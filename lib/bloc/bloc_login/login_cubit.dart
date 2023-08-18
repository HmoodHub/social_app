import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_app/firebase/auth/fb_auth.dart';
import 'package:social_app/shared_pref/shared_pref.dart';

import '../../utils/utils.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(context)=> BlocProvider.of<LoginCubit>(context);
  late TextEditingController emailController;
  late TextEditingController passwordController;
  void onStartLogin(){
    emailController = TextEditingController();
    passwordController = TextEditingController();
    emit(LoginInitial());
  }
  bool obscureText = true;
  bool isVisible = false;

  void visibilityPass() {
    obscureText = !obscureText;
    isVisible = !isVisible;
    emit(LoginVisibilityPass());
  }

  void login()async{
    bool login = await FBAuth.loginUser(emailController.text, passwordController.text);

    if(login){
      id = SharedPref().userId;
      emit(LoginSuccess());
    }else{
      emit(LoginError());
    }
  }
}