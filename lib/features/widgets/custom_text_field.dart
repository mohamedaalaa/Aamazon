import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String text;
  final int? lines;
  final TextInputType? inputType;
  final String? Function(String?)? validator;
  const CustomTextField({
    Key? key,
    required this.controller,
    required this.text,
    this.validator,
    this.lines,
    this.inputType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: inputType ?? TextInputType.text,
      controller: controller,
      maxLines: lines ?? 1,
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
