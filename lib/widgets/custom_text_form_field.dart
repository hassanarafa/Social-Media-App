import 'package:flutter/material.dart';

import '../constants.dart';

class Customtextformfield extends StatelessWidget {
  const Customtextformfield(
      {required this.x,
      this.suffixicon,
      this.onChanged,
      this.hinttext,
      super.key});
  final bool? x;
  final String? hinttext;
  final void Function(String)? onChanged;
  final IconButton? suffixicon;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        obscureText: x!,
        obscuringCharacter: '*',
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'this field is required';
          }
          return null;
        },
        cursorColor: secondaryColor,
        onChanged: onChanged,
        decoration: InputDecoration(
          suffixIcon: suffixicon,
          suffixIconColor: Colors.black,
          contentPadding: const EdgeInsets.all(20),
          hintText: hinttext,
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(5)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: secondaryColor),
              borderRadius: BorderRadius.circular(5)),
          errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(5)),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(5)),
        ));
  }
}
