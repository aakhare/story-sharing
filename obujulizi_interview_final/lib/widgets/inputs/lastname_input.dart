import 'package:flutter/material.dart';

class LastNameField extends StatelessWidget {
  final FormFieldValidator<String> validator;
  final FocusNode? nextFocusNode;
  final FocusNode? focusNode;
  final TextEditingController? controller;

  const LastNameField({
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
        labelText: "Lastname",
        helperText: "",
        hintText: "Lastname",
      ),
    );
  }
}
