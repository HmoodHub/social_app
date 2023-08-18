import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:social_app/bloc/bloc_login/login_cubit.dart';
import 'package:social_app/screens/auth/register_screen.dart';
import 'package:social_app/screens/home_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    LoginCubit bloc = LoginCubit.get(context);
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is LoginSuccess) {
          Get.off(HomeScreen());
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
                'LOGIN',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                'Welcome bake to Social Media App.',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Colors.grey),
              ),
              const SizedBox(
                height: 35,
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
                        bloc.isVisible ? Icons.visibility_off_sharp : Icons.visibility_sharp
                      ),),
                ),
                obscureText: bloc.obscureText,
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(alignment: Alignment.centerRight),
                child: const Text('Forget Password ?'),
              ),
              const SizedBox(
                height: 35,
              ),
              ElevatedButton(
                onPressed: () async => bloc.login(),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black54,
                  backgroundColor: Colors.grey.shade200,
                  elevation: 10,
                  minimumSize: const Size(double.infinity, 50),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
                child: const Text('SIGN IN'),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Don\'t have an account?'),
                  TextButton(
                    onPressed: () {
                      Get.to(()=>const RegisterScreen());
                    },
                    style: TextButton.styleFrom(padding: EdgeInsets.zero),
                    child: const Text('Sign up'),
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
