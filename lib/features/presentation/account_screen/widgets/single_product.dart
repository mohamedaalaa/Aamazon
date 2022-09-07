import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SingleProduct extends StatelessWidget {
  final String path;
  const SingleProduct({super.key, required this.path});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black12, width: 1.5),
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
        ),
        child: Image.asset(
          path,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
