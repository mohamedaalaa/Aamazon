import 'package:amazon/constants/device_size.dart';
import 'package:amazon/constants/global_variables.dart';
import 'package:amazon/constants/routes.dart';
import 'package:amazon/constants/sizes.dart';

import 'package:amazon/models/user.dart';
import 'package:amazon/features/presentation/auth/auth_cubit.dart';
import 'package:amazon/features/widgets/button.dart';

import 'package:amazon/features/widgets/custom_text_field.dart';
import 'package:amazon/features/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final key = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  clearTextField() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (BuildContext context, state) {
        switch (state.runtimeType) {
          case SignedUser:
            clearTextField();
            goToNamed(loginR, context);
            break;
        }
      },
      builder: (BuildContext context, Object? state) {
        final bloc = BlocProvider.of<AuthCubit>(context);
        Future signupUser() async {
          bool isValid = key.currentState!.validate();
          if (isValid) {
            FocusScope.of(context).unfocus();
            UserModel user = UserModel(
                name: nameController.text,
                email: emailController.text,
                password: passwordController.text,
                address: '',
                type: '',
                id: '',
                v: '',
                token: '');
            bloc.signupUser(user, context);
          }
        }

        return Scaffold(
            backgroundColor: GlobalVariables.greyBackgroundCOlor,
            body: SafeArea(
                child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  gapH10,
                  if (bloc.isSignin)
                    Form(
                        key: key,
                        child: Container(
                          color: Colors.white,
                          child: Column(
                            children: [
                              gapH10,
                              CustomTextField(
                                controller: nameController,
                                text: 'Name',
                                validator: (value) {
                                  if (nameController.text.trim().isEmpty ||
                                      nameController.text.trim().length < 5) {
                                    return "name can't be less than 5 chars";
                                  }
                                  return null;
                                },
                              ),
                              gapH4,
                              CustomTextField(
                                controller: emailController,
                                text: 'Email',
                                validator: (value) {
                                  bool emailValid = bloc.regex
                                      .hasMatch(emailController.text.trim());
                                  if (!emailValid) {
                                    return "email is not valid";
                                  }
                                  return null;
                                },
                              ),
                              gapH4,
                              CustomTextField(
                                controller: passwordController,
                                text: 'password',
                                validator: (value) {
                                  if (passwordController.text.isEmpty ||
                                      passwordController.text.length < 5) {
                                    return "password can't be less than 5";
                                  }
                                  return null;
                                },
                              ),
                              gapH10,
                              if (state is SigningUser)
                                const Loading()
                              else
                                Button(
                                  onPressed: () => signupUser(),
                                  child: const Text("Sign-up"),
                                ),
                              gapH10,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text("Already have an account"),
                                  gapW4,
                                  InkWell(
                                    onTap: () => Navigator.of(context)
                                        .pushNamedAndRemoveUntil(
                                            loginR, (route) => false),
                                    child: const Text(
                                      "Log-in",
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        )),
                ],
              ),
            )));
      },
    );
  }
}
