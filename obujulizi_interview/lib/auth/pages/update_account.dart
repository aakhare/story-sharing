import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:obujulizi_interviews/auth/all.dart';
import 'package:obujulizi_interviews/utils/all.dart';
import 'package:obujulizi_interviews/widgets/all.dart';

class UpdateAccountPage extends StatefulWidget {
  const UpdateAccountPage({super.key});

  @override
  State<UpdateAccountPage> createState() => UpdateAccountPageState();
}

class UpdateAccountPageState extends State<UpdateAccountPage> {
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

  void updateUser() {
    userAuth.updateUser(
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

  void updateUserInfo() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      padding: pagePadding,
      child: SafeArea(
        child: Column(
          children: [
            extraLargeVertical,
            const Text("Update your account info below", style: headline1),
            extraLargeVertical,
            const Align(
              alignment: Alignment.centerLeft,
              child: Text("Update User Account", style: display),
            ),
            const Divider(color: black),
            mediumVertical,
            Form(
                key: formKey,
                child: Column(
                  children: [
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
                        updateUser();
                      }
                    },
                    label: const Text("Done"),
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
