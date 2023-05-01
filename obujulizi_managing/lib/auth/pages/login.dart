import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:obujulizi_managing/auth/services/user_functions.dart';
import 'package:obujulizi_managing/utils/all.dart';
import 'package:obujulizi_managing/widgets/all.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final emailFocus = FocusNode();
  final passwordFocus = FocusNode();

  final UserAuthentication userAuth = UserAuthentication();

  void signInUser() {
    userAuth.signInUser(
        context: context,
        email: _emailController.text.trim(),
        password: _passwordController.text.trim());
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [purple, magenta, pink])),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                largeVertical,
                Image.asset("assets/icons/white_icon.png"),
                mediumVertical,
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: titleLogin,
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: captionLogin,
                ),
                largeVertical,
                Container(
                  width: 750,
                  height: 450,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24.0),
                    color: white,
                  ),
                  child: Padding(
                    padding: pagePadding,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        largeVertical,
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Sign In", style: display),
                        ),
                        const Divider(color: black),
                        mediumVertical,
                        Form(
                            key: formKey,
                            child: Column(
                              children: [
                                EmailField(
                                  controller: _emailController,
                                  focusNode: emailFocus,
                                  nextFocusNode: passwordFocus,
                                  validator: (input) {
                                    if (_emailController.text.isWhitespace()) {
                                      return "Email is required";
                                    }
                                    if (EmailValidator.validate(
                                            _emailController.text) ==
                                        false) {
                                      return "Invalid email address";
                                    }
                                    return null;
                                  },
                                ),
                                smallVertical,
                                PasswordField(
                                    controller: _passwordController,
                                    focusNode: passwordFocus,
                                    nextFocusNode: null,
                                    validator: (input) {
                                      if (_passwordController.text
                                          .isWhitespace()) {
                                        return "Password is required";
                                      }
                                      return null;
                                    }),
                              ],
                            )),
                        mediumVertical,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: FloatingActionButton.extended(
                                onPressed: () {
                                  final isValid =
                                      formKey.currentState!.validate();
                                  if (isValid == true) {
                                    signInUser();
                                  }
                                },
                                label: const Text("Login"),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
