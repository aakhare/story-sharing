import 'package:flutter/material.dart';
import 'package:obujulizi_stories/utils/constants/colors.dart';

class PasswordConfirmationField extends StatefulWidget {
  final FormFieldValidator<String> validator;
  final FocusNode? nextFocusNode;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final String? labelText;

  const PasswordConfirmationField(
      {Key? key,
      required this.validator,
      this.nextFocusNode,
      this.focusNode,
      this.controller,
      this.labelText})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => PasswordConfirmationFieldState();
}

class PasswordConfirmationFieldState extends State<PasswordConfirmationField> {
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      onFieldSubmitted: (_) => widget.nextFocusNode?.requestFocus(),
      obscureText: obscurePassword,
      keyboardType: TextInputType.visiblePassword,
      validator: widget.validator,
      decoration: InputDecoration(
        labelText: "Password Confirmation",
        helperText: "",
        suffixIcon: IconButton(
          onPressed: () => setState(() => obscurePassword = !obscurePassword),
          icon: Icon(
            obscurePassword ? Icons.visibility : Icons.visibility_off,
            color: black,
          ),
        ),
      ),
    );
  }
}
