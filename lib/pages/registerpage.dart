import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_form_field.dart';
import 'LoginPage.dart';

class Registerpage extends StatefulWidget {
  const Registerpage({super.key});

  @override
  State<Registerpage> createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {
  TextEditingController? emailController;
  TextEditingController? passwordController;
  final formKey = GlobalKey<FormState>();

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
      body: Form(
        key: formKey,
        child: SizedBox(
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
                      "Register Now",
                      style: TextStyle(color: secondaryColor, fontSize: 20),
                    ),
                    const SizedBox(height: 20),
                    Customtextformfield(
                        customcontroller: emailController, hinttext: "E-Mail"),
                    const SizedBox(height: 20),
                    Customtextformfield(
                        customcontroller: passwordController,
                        hinttext: "Password"),
                    const SizedBox(height: 20),
                    const Customtextformfield(hinttext: "Confirm Password"),
                    const SizedBox(height: 20),
                    Custombutton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            Navigator.pop(context);
                          }
                        },
                        textbutton: "Register"),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("I'm a member"),
                        const SizedBox(width: 15),
                        GestureDetector(
                            onTap: () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LgoinPage(),
                                  ),
                                  (Route<dynamic> route) => false);
                            },
                            child: Text(
                              "Log in Now",
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
      ),
    );
  }
}
