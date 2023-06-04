import 'package:flutter/material.dart';

import '../constants.dart';

class Custombutton extends StatelessWidget {
  const Custombutton({this.onPressed, this.textbutton, super.key});

  final String? textbutton;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
              shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              backgroundColor: secondaryColor),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Text(textbutton!),
          )),
    );
  }
}
