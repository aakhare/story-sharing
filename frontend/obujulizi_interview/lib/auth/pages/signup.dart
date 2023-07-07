import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:obujulizi_interview_final/auth/services/user_functions.dart';
import 'package:obujulizi_interview_final/utils/all.dart';
import 'package:obujulizi_interview_final/widgets/all.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmationController = TextEditingController();

  final firstNameFocus = FocusNode();
  final lastNameFocus = FocusNode();
  final emailFocus = FocusNode();
  final passwordFocus = FocusNode();
  final confirmationFocus = FocusNode();

  final UserAuthentication userAuth = UserAuthentication();

  void signUpUser() {
    userAuth.signUpUser(
        context: context,
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim());
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmationController.dispose();
    firstNameFocus.dispose();
    lastNameFocus.dispose();
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
            const Text("Fill out the form below to join", style: headline1),
            smallVertical,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Flexible(
                  child: Text("Or, if you have an account", style: headline3),
                ),
                Flexible(
                  child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, RoutesName.login);
                      },
                      child: const Text("Login Here")),
                ),
              ],
            ),
            extraLargeVertical,
            const Align(
              alignment: Alignment.centerLeft,
              child: Text("Sign Up", style: display),
            ),
            const Divider(color: black),
            mediumVertical,
            Form(
                key: formKey,
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        children: [
                          Text(
                              "* make sure to capitalize the first letter of your first name and last name",
                              style: bodyText2),
                          smallVertical,
                          Text("Ex: John Smith", style: bodyText1),
                        ],
                      ),
                    ),
                    mediumVertical,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: FirstNameField(
                            controller: _firstNameController,
                            focusNode: firstNameFocus,
                            nextFocusNode: lastNameFocus,
                            validator: (input) {
                              if (_firstNameController.text.isWhitespace()) {
                                return "First name is required";
                              }
                              return null;
                            },
                          ),
                        ),
                        smallHorizontal,
                        Flexible(
                          child: LastNameField(
                              controller: _lastNameController,
                              focusNode: lastNameFocus,
                              nextFocusNode: emailFocus,
                              validator: (input) {
                                if (_lastNameController.text.isWhitespace()) {
                                  return "Last name is required";
                                }
                                return null;
                              }),
                        ),
                      ],
                    ),
                    smallVertical,
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
                        signUpUser();
                      }
                    },
                    label: const Text("Create Account"),
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
