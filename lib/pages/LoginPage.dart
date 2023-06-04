import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_form_field.dart';
import 'registerpage.dart';

class LgoinPage extends StatefulWidget {
  const LgoinPage({super.key});

  @override
  State<LgoinPage> createState() => _LgoinPageState();
}

class _LgoinPageState extends State<LgoinPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
            statusBarColor: backgroundColor),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/logo.png",
                    width: 200,
                    height: 200,
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "Hello, Again",
                    style: GoogleFonts.aBeeZee(fontSize: 40),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "Welcome Back, You've been missed",
                    style: TextStyle(color: secondaryColor, fontSize: 20),
                  ),
                  const SizedBox(height: 20),
                  const Customtextformfield(hinttext: "E-Mail"),
                  const SizedBox(height: 20),
                  const Customtextformfield(hinttext: "Password"),
                  const SizedBox(height: 20),
                  Custombutton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      textbutton: "Submit"),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("If you don't have an account"),
                      const SizedBox(width: 15),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Registerpage(),
                                ));
                          },
                          child: Text(
                            "Register Now",
                            style: TextStyle(color: secondaryColor),
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
