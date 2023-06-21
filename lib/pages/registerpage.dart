import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_form_field.dart';
import 'LoginPage.dart';
import 'homepage.dart';

class Registerpage extends StatefulWidget {
  const Registerpage({super.key});

  @override
  State<Registerpage> createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {
  String? email, password1, password2;
  GlobalKey<FormState> formKey = GlobalKey();
  bool x = true, y = true;
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
              child: Form(
                key: formKey,
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
                        password1 = data;
                      },
                    ),
                    const SizedBox(height: 20),
                    Customtextformfield(
                        x: y,
                        suffixicon: IconButton(
                            onPressed: () {
                              setState(() {
                                y = !y;
                              });
                            },
                            icon: const Icon(
                              Icons.visibility,
                            )),
                        onChanged: (data) {
                          password2 = data;
                        },
                        hinttext: "Confirm Password"),
                    const SizedBox(height: 20),
                    Custombutton(
                        onPressed: () async {
                          if (password1 != password2) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'passwords in two fields are not equal')));
                          } else if (formKey.currentState!.validate()) {
                            try {
                              await FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                email: email!,
                                password: password1!,
                              );
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
