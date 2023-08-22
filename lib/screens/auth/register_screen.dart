import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:social_app/bloc/bloc_register/register_cubit.dart';
import 'package:social_app/bloc/bloc_register/register_cubit.dart';
import 'package:social_app/screens/auth/login_screen.dart';
import 'package:social_app/widget/widget_app.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    RegisterCubit bloc = RegisterCubit.get(context);
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is RegisterSuccess) {
         Get.back();
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            physics: const BouncingScrollPhysics(),
            children: [
              Text(
                'REGISTER',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                'Hello, register in Social Media App.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Colors.grey,
                    ),
              ),
              const SizedBox(
                height: 35,
              ),
              WidgetApp().textFieldApp(
                controller: bloc.usernameController,
                textInputType: TextInputType.text,
                borderRadius: 10,
                label: const Text('User Name'),
                colorFill: Colors.grey.shade200,
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: bloc.emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  label: const Text('E-mail'),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  fillColor: Colors.grey.shade200,
                  filled: true,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: bloc.passwordController,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  label: const Text('Password'),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  fillColor: Colors.grey.shade200,
                  filled: true,
                  suffixIcon: IconButton(
                    onPressed: () {
                      bloc.visibilityPass();
                    },
                    icon: Icon(
                      bloc.isVisible
                          ? Icons.visibility_off_sharp
                          : Icons.visibility_sharp,
                    ),
                  ),
                ),
                obscureText: bloc.obscureText,
              ),
              const SizedBox(
                height: 15,
              ),
              WidgetApp().textFieldApp(
                controller: bloc.phoneController,
                textInputType: TextInputType.number,
                borderRadius: 10,
                label: const Text('Phone Number'),
                colorFill: Colors.grey.shade200,
              ),
              const SizedBox(
                height: 20,
              ),
              WidgetApp().buttonApp(
                onPress: () async => bloc.register(),
                foregroundColor: Colors.black54,
                backgroundColor: Colors.grey.shade200,
                width: double.infinity,
                height: 50,
                childButton: const Text('SIGN UP'),
                borderRadius: 10,
                elevation: 10,
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Do have an account?'),
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    style: TextButton.styleFrom(padding: EdgeInsets.zero),
                    child: const Text('Login'),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
