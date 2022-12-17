//Packages
import 'dart:html';

import 'package:flutter/material.dart';

class MultiLineField extends StatelessWidget {
  const MultiLineField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 8,
      decoration: const InputDecoration(
        helperText: "",
        hintText: "Description",
        labelText: "Multiline field",
      ),
    );
  }
}
