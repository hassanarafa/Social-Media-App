import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_form_field.dart';
import 'homepage.dart';
import 'registerpage.dart';

class LgoinPage extends StatefulWidget {
  const LgoinPage({super.key});

  @override
  State<LgoinPage> createState() => _LgoinPageState();
}

class _LgoinPageState extends State<LgoinPage> {
  GlobalKey<FormState> formKey = GlobalKey();
  String? email, password;
  bool x = true;
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
                      "Hello, Again",
                      style: GoogleFonts.aBeeZee(fontSize: 40),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      "Welcome Back, You've been missed",
                      style: TextStyle(color: secondaryColor, fontSize: 20),
                    ),
                    const SizedBox(height: 20),
                    Customtextformfield(
                      x: false,
                      hinttext: "E-Mail",
                      onChanged: (data) {
                        email = data;
                      },
                    ),
                    const SizedBox(height: 20),
                    Customtextformfield(
                      x: x,
                      suffixicon: IconButton(
                          onPressed: () {
                            setState(() {
                              x = !x;
                            });
                          },
                          icon: const Icon(
                            Icons.visibility,
                          )),
                      hinttext: "Password",
                      onChanged: (data) {
                        password = data;
                      },
                    ),
                    const SizedBox(height: 20),
                    Custombutton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            try {
                              await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                      email: email!, password: password!);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Homepage(),
                                  ));
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'user-not-found') {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'No user found for that email.')));
                                print('No user found for that email.');
                              } else if (e.code == 'wrong-password') {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Wrong password provided for that user.')));
                                print('Wrong password provided for that user.');
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Error')));
                                print(e);
                              }
                            }
                          }
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
      ),
    );
  }
}
