//Packages
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumberField extends StatelessWidget {
	const NumberField({
		Key? key,
	}) : super(key: key);

  	@override
	Widget build(BuildContext context) {
		return TextFormField(
			keyboardType: TextInputType.number,
			validator: (number) {
				if (number is int) {
					return "Enter a valid number";
				}
			},
			maxLength: 10,
			maxLengthEnforcement: MaxLengthEnforcement.enforced,
			decoration: const InputDecoration(
				labelText: "Number field",
				helperText: "",
				hintText: "21",
			),
		);
  	}
}
