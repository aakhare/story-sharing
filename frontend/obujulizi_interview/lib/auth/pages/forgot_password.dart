import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:obujulizi_interview_final/auth/services/user_functions.dart';
import 'package:obujulizi_interview_final/utils/all.dart';
import 'package:obujulizi_interview_final/widgets/all.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => ForgotPasswordPageState();
}

class ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmationController = TextEditingController();

  final emailFocus = FocusNode();
  final passwordFocus = FocusNode();
  final confirmationFocus = FocusNode();

  final UserAuthentication userAuth = UserAuthentication();

  void updateUserPassword() {
    userAuth.updateUserPassword(
        context: context,
        email: _emailController.text.trim(),
        password: _passwordController.text.trim());
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmationController.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    confirmationFocus.dispose();
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
            extraLargeVertical,
            const Text("Change your password below", style: headline1),
            smallVertical,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Flexible(
                  child: Text("If you're new", style: headline3),
                ),
                Flexible(
                  child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, RoutesName.signup);
                      },
                      child: const Text("Join Us Here")),
                ),
              ],
            ),
            extraLargeVertical,
            const Align(
              alignment: Alignment.centerLeft,
              child: Text("Forgot Password", style: display),
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
                      validator: (emailController) {
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
                      nextFocusNode: confirmationFocus,
                      validator: (input) {
                        if (_passwordController.text.isWhitespace()) {
                          return "Password is required";
                        }
                        if (!_passwordController.text.isValidPassword()) {
                          return "Your password isn't long enough";
                        }
                        return null;
                      },
                    ),
                    smallVertical,
                    PasswordConfirmationField(
                      controller: _confirmationController,
                      focusNode: confirmationFocus,
                      nextFocusNode: null,
                      validator: (input) {
                        if (_passwordController.text.isWhitespace()) {
                          return "Password confirmation is required";
                        }
                        if (_confirmationController.text !=
                            _passwordController.text) {
                          return "Password and confirmation must match";
                        }
                        return null;
                      },
                    ),
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
                        updateUserPassword();
                      }
                    },
                    label: const Text("Update Password"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
