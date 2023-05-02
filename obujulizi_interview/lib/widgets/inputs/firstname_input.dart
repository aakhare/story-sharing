import 'package:flutter/material.dart';

class FirstNameField extends StatelessWidget {
  final FormFieldValidator<String> validator;
  final FocusNode? nextFocusNode;
  final FocusNode? focusNode;
  final TextEditingController? controller;

  const FirstNameField({
    Key? key,
    required this.validator,
    required this.nextFocusNode,
    required this.focusNode,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      onFieldSubmitted: (_) => nextFocusNode?.requestFocus(),
      validator: validator,
      decoration: const InputDecoration(
        labelText: "Firstname",
        helperText: "",
        hintText: "Firstname",
      ),
    );
  }
}
