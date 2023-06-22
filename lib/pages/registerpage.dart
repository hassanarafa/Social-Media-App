import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../constants.dart';
import '../cubit/registr/register_cubit.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_form_field.dart';
import 'LoginPage.dart';
import 'homepage.dart';

class Registerpage extends StatelessWidget {
  const Registerpage({super.key});

  @override
  Widget build(BuildContext context) {
    String? email, password1, password2;
    GlobalKey<FormState> formKey = GlobalKey();
    bool a = true, b = true, load = false;
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterLoading) {
          load = true;
        } else if (state is RegisterChangePasswordStyle1) {
          a = !a;
        } else if (state is RegisterChangePasswordStyle2) {
          b = !b;
        } else if (state is RegisterSuccess) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute<void>(
                builder: (BuildContext context) => const Homepage()),
            (Route<dynamic> route) => false,
          );
          load = false;
        } else if (state is RegisterFailure) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.errorMessage)));
          load = false;
        }
      },
      builder: (context, state) {
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
                            style:
                                TextStyle(color: secondaryColor, fontSize: 20),
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
                            x: a,
                            suffixicon: IconButton(
                                onPressed: () {
                                  BlocProvider.of<RegisterCubit>(context)
                                      .passwordVisability();
                                },
                                icon: const Icon(
                                  Icons.visibility,
                                )),
                            hinttext: "Password",
                            onChanged: (data) {
                              password1 = data;
                              a = true;
                            },
                          ),
                          const SizedBox(height: 20),
                          Customtextformfield(
                              x: b,
                              suffixicon: IconButton(
                                  onPressed: () {
                                    BlocProvider.of<RegisterCubit>(context)
                                        .passwordVisability2();
                                  },
                                  icon: const Icon(
                                    Icons.visibility,
                                  )),
                              onChanged: (data) {
                                password2 = data;
                                a = true;
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
                                  BlocProvider.of<RegisterCubit>(context)
                                      .register(
                                          email: email!, password: password1!);
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
                                          builder: (context) =>
                                              const LgoinPage(),
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
          ),
        );
      },
    );
  }
}
