import 'package:flutter/material.dart';

class InterviewTextField extends StatelessWidget {
  final FormFieldValidator<String> validator;
  final FocusNode? nextFocusNode;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  const InterviewTextField({
    Key? key,
    required this.validator,
    this.nextFocusNode,
    this.focusNode,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 40,
      controller: controller,
      focusNode: focusNode,
      onFieldSubmitted: (_) => nextFocusNode?.requestFocus(),
      validator: validator,
      decoration: const InputDecoration(
        helperText: "",
        hintText: "Answers questions here",
        labelText: "Interview Content",
      ),
    );
  }
}
