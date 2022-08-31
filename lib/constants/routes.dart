import 'package:amazon/features/presentation/auth/login/login.dart';
import 'package:amazon/features/presentation/home/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../features/presentation/auth/signup/signup.dart';

const String loginR = 'login';
const String signupR = 'signup';
const String homeR = 'home';

Route<dynamic> generateRout(RouteSettings settings) {
  switch (settings.name) {
    case loginR:
      return MaterialPageRoute(builder: (_) => Login());
    case signupR:
      return MaterialPageRoute(builder: (_) => const Signup());
    case homeR:
      return MaterialPageRoute(builder: (_) => const HomeScreen());
    default:
      return MaterialPageRoute(builder: (_) => const ErrorWidget());
  }
}

class ErrorWidget extends StatelessWidget {
  const ErrorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Error Widget"),
    );
  }
}
