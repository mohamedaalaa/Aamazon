import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String text;
  final String? Function(String?)? validator;
  const CustomTextField(
      {Key? key, required this.controller, required this.text, this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: text,
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black)),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black)),
      ),
      validator: validator,
    );
  }
}
