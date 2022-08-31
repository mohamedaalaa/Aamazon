import 'package:amazon/constants/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Button extends StatelessWidget {
  void Function()? onPressed;
  final Widget child;
  Button({Key? key, required this.onPressed, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(GlobalVariables.secondaryColor),
            elevation: MaterialStateProperty.all(0)),
        onPressed: onPressed,
        child: child);
  }
}
