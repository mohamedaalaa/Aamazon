import 'package:amazon/constants/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator(
      color: GlobalVariables.secondaryColor,
    );
  }
}
