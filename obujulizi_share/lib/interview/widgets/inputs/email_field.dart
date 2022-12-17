//Packages
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class EmailField extends StatelessWidget {
  const EmailField({
    Key? key,
  }) : super(key: key);

  @override
	Widget build(BuildContext context) {
		return TextFormField(
			keyboardType: TextInputType.emailAddress,
			validator: (email) {
				if (email != null && EmailValidator.validate(email)) {
					return null;
				}
				return "Enter a valid email address";
			},
			decoration: const InputDecoration(
				labelText: "Email field",
				helperText: "",
				hintText: "name@adress.com",
			),
		);
	}
}
