
import 'package:flutter/material.dart';

class MultiLineField extends StatelessWidget {
  final FormFieldValidator<String> validator;
  final FocusNode? nextFocusNode;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final String? placeholder;
  const MultiLineField({
    Key? key,
    required this.validator,
    this.nextFocusNode,
    this.focusNode,
    this.controller,
    this.placeholder
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: TextFormField(
            minLines: 10,
          maxLines: 500,
          controller: controller,
          focusNode: focusNode,
          onFieldSubmitted: (_) => nextFocusNode?.requestFocus(),
          validator: validator,
          decoration: const InputDecoration(
            helperText: "",
            hintText: "Add story here",
            labelText: "Story Content",
          ),
        ),
    
    );
  }
}