import 'package:flutter/material.dart';

class TagField extends StatelessWidget {
  final FormFieldValidator<String> validator;
  final FocusNode? nextFocusNode;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final String? placeholder;
  const TagField({
    Key? key,
    required this.validator,
    this.nextFocusNode,
    this.focusNode,
    this.controller,
    this.placeholder
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
        hintText: "Add tag here",
        labelText: "Tag",
      ),
    );
  }
}