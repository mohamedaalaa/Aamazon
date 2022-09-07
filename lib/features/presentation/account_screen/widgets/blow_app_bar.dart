import 'package:amazon/constants/device_size.dart';
import 'package:amazon/constants/global_variables.dart';
import 'package:amazon/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class BlowAppBar extends StatelessWidget {
  const BlowAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      decoration: const BoxDecoration(
        gradient: GlobalVariables.appBarGradient,
      ),
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Row(
        children: [
          RichText(
            text: TextSpan(
                text: 'Hello, ',
                style: const TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                ),
                children: [
                  TextSpan(
                    text: getUser.email,
                    style: const TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ]),
          )
        ],
      ),
    );
  }
}
