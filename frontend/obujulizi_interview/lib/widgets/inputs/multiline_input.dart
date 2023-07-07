import 'package:flutter/material.dart';

class MultiLineField extends StatelessWidget {
  final FormFieldValidator<String> validator;
  final FocusNode? nextFocusNode;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  const MultiLineField({
    Key? key,
    required this.validator,
    this.nextFocusNode,
    this.focusNode,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 10,
      controller: controller,
      focusNode: focusNode,
      onFieldSubmitted: (_) => nextFocusNode?.requestFocus(),
      validator: validator,
      decoration: const InputDecoration(
        helperText: "",
        hintText: "Add details here",
        labelText: "Details",
      ),
    );
  }
}
