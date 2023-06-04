import 'package:flutter/material.dart';

import '../constants.dart';

class Customtextformfield extends StatelessWidget {
  const Customtextformfield({this.customcontroller, this.hinttext, super.key});

  final String? hinttext;
  final TextEditingController? customcontroller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: customcontroller,
        decoration: InputDecoration(
            hintText: hinttext,
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: secondaryColor),
                borderRadius: BorderRadius.circular(15)),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.blue),
                borderRadius: BorderRadius.circular(15))));
  }
}
