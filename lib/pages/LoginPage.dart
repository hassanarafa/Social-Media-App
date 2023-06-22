import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../constants.dart';
import '../cubit/login/login_cubit.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_form_field.dart';
import 'homepage.dart';
import 'registerpage.dart';

class LgoinPage extends StatelessWidget {
  const LgoinPage({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey();
    String? email, password;
    bool x = true, load = false;
    return BlocConsumer<LoginCubit, LoginState>(listener: (context, state) {
      if (state is LoginLoading) {
        load = true;
      } else if (state is LoginChangePasswordStyle) {
        x = !x;
      } else if (state is LoginSuccess) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute<void>(
              builder: (BuildContext context) => const Homepage()),
          (Route<dynamic> route) => false,
        );
        load = false;
      } else if (state is LoginFailure) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(state.errorMessage)));
        load = false;
      }
    }, builder: (context, state) {
      return ModalProgressHUD(
        inAsyncCall: load,
        child: Scaffold(
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
                                BlocProvider.of<LoginCubit>(context)
                                    .passwordVisability();
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
                                BlocProvider.of<LoginCubit>(context)
                                    .login(email: email!, password: password!);
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
                                        builder: (context) =>
                                            const Registerpage(),
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
        ),
      );
    });
  }
}
