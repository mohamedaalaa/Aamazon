import 'package:amazon/constants/device_size.dart';
import 'package:amazon/constants/routes.dart';
import 'package:amazon/features/presentation/auth/auth_cubit.dart';
import 'package:amazon/features/widgets/button.dart';
import 'package:amazon/features/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/global_variables.dart';
import '../../../../constants/sizes.dart';
import '../../../../models/user.dart';
import '../../../widgets/custom_text_field.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

  final sKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          switch (state.runtimeType) {
            case LogedUser:
              goToNamed(navR, context);
              break;
            case AuthError:
              print("an error occured");
              break;
          }
        },
        builder: (context, state) {
          final bloc = BlocProvider.of<AuthCubit>(context);

          Future loginUser() async {
            bloc.loginUser(emailController.text.trim(),
                passwordController.text.trim(), context);
          }

          return Form(
              key: sKey,
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                            image:
                                DecorationImage(image: AssetImage(amazonLogo))),
                      ),
                      gapH10,
                      CustomTextField(
                        controller: emailController,
                        text: 'Email',
                        validator: (value) {
                          bool emailValid =
                              bloc.regex.hasMatch(emailController.text.trim());
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
                        },
                      ),
                      gapH4,
                      if (state is LogingUser)
                        const Loading()
                      else
                        Button(
                          onPressed: () => loginUser(),
                          child: const Text("Log-in"),
                        ),
                      gapH10,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("don't have an account"),
                          gapW4,
                          InkWell(
                            onTap: () => goToNamed(signupR, context),
                            child: const Text(
                              "Sign-up",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ));
        },
      ),
    );
  }
}
