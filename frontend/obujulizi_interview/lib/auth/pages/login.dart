import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:obujulizi_interview_final/auth/services/user_functions.dart';
import 'package:obujulizi_interview_final/utils/all.dart';
import 'package:obujulizi_interview_final/widgets/all.dart';

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
    return Scaffold(
        body: SingleChildScrollView(
      padding: pagePadding,
      child: SafeArea(
        child: Column(
          children: [
            Image.asset("assets/icons/main_icon.png"),
            extraLargeVertical,
            const Text("Welcome to Obujulizi Share", style: headline1),
            smallVertical,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Flexible(
                  child: Text("Login below or", style: headline3),
                ),
                Flexible(
                  child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, RoutesName.signup);
                      },
                      child: const Text("Create an Account")),
                ),
              ],
            ),
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
                        if (EmailValidator.validate(_emailController.text) ==
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
                          if (_passwordController.text.isWhitespace()) {
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
                      final isValid = formKey.currentState!.validate();
                      if (isValid == true) {
                        signInUser();
                      }
                    },
                    label: const Text("Login"),
                  ),
                ),
                Flexible(
                  child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, RoutesName.forgotPassword);
                      },
                      child: const Text("Forgot Password")),
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}