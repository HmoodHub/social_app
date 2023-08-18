import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_app/models/username_model.dart';

import '../../firebase/auth/fb_auth.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  static RegisterCubit get(context) => BlocProvider.of<RegisterCubit>(context);
  late TextEditingController usernameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController phoneController;

  void onStartRegister() {
    usernameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    phoneController = TextEditingController();
    emit(RegisterInitial());
  }

  bool obscureText = true;
  bool isVisible = false;

  void visibilityPass() {
    obscureText = !obscureText;
    isVisible = !isVisible;
    emit(RegisterVisibilityPass());
  }

  Username get username {
    Username username = Username(
      username : usernameController.text,
      email :emailController.text,
      phone :phoneController.text,
      image :'https://img.freepik.com/free-photo/bearded-man-denim-shirt-round-glasses_273609-11770.jpg?size=626&ext=jpg&ga=GA1.2.735232748.1691787083&semt=sph',
      cover : 'https://img.freepik.com/free-photo/emotional-bearded-male-has-surprised-facial-expression-astonished-look-dressed-white-shirt-with-red-braces-points-with-index-finger-upper-right-corner_273609-16001.jpg?size=626&ext=jpg&ga=GA1.2.735232748.1691787083&semt=sph',
      bio :'write your bio...',
    );
    return username;
  }

  void register() async {
    bool register =
        await FBAuth.registerUser(username, passwordController.text);
    if (register) {
      emit(RegisterSuccess());
    } else {
      emit(RegisterError());
    }
  }
}
