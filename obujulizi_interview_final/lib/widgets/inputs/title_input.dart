import 'package:flutter/material.dart';

class TitleField extends StatelessWidget {
  final FormFieldValidator<String> validator;
  final FocusNode? nextFocusNode;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  const TitleField({
    Key? key,
    required this.validator,
    this.nextFocusNode,
    this.focusNode,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      onFieldSubmitted: (_) => nextFocusNode?.requestFocus(),
      validator: validator,
      decoration: const InputDecoration(
        helperText: "",
        hintText: "Add title here",
        labelText: "Interview Title",
      ),
    );
  }
}
