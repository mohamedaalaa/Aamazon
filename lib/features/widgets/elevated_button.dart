import 'package:amazon/constants/device_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Ebutton extends StatelessWidget {
  final Color color;
  final String title;
  final double width;
  final void Function()? onPressed;
  const Ebutton(
      {super.key,
      required this.color,
      required this.onPressed,
      required this.title,
      required this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(color)),
        onPressed: onPressed,
        child: Center(
            child: Text(
          title,
          style:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        )),
      ),
    );
  }
}
