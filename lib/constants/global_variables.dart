import 'package:amazon/constants/device_size.dart';
import 'package:amazon/constants/sizes.dart';
import 'package:amazon/features/models/user.dart';
import 'package:flutter/material.dart';

String baseUrl = "https://6c1e-197-63-57-21.eu.ngrok.io";

class GlobalVariables {
  static const appBarGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 29, 201, 192),
      Color.fromARGB(255, 125, 221, 216),
    ],
    stops: [0.5, 1.0],
  );

  static const secondaryColor = Color.fromRGBO(255, 153, 0, 1);
  static const backgroundColor = Colors.white;
  static const Color greyBackgroundCOlor = Color(0xffebecee);
  static var selectedNavBarColor = Colors.cyan[800];
  static const unselectedNavBarColor = Colors.black87;
}

InputDecoration inputDecoration(String hint) {
  return InputDecoration(
    hintText: hint,
  );
}

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> scaffoldMessenger(
    BuildContext context, String text) {
  return ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text(text)));
}

class LoadingMainScreen extends StatelessWidget {
  const LoadingMainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      height: context.height,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: const Center(
        child: CircularProgressIndicator(
          color: Colors.black,
        ),
      ),
    );
  }
}

void goToNamed(String route, BuildContext context) =>
    Navigator.of(context).pushNamedAndRemoveUntil(route, (route) => false);
