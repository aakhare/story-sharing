import 'package:flutter/material.dart';

class DisabledField extends StatelessWidget {
  const DisabledField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        decoration: const InputDecoration(
      enabled: false,
      labelText: "",
      helperText: "",
      hintText: "Disabled",
    ));
  }
}
