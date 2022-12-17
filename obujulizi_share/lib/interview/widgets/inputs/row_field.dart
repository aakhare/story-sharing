//Packages
import 'package:flutter/material.dart';

class RowField extends StatelessWidget {
    const RowField({
        Key? key,
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
		return Row(
			mainAxisAlignment: MainAxisAlignment.spaceBetween,
			children: [
				Flexible(
				  child: TextFormField(
					decoration: const InputDecoration(
						helperText: "",
						hintText: "Enter first name",
						labelText: "First Name"),
				  ),
				),
				Flexible(
				    child: TextFormField(
						decoration: const InputDecoration(
							helperText: "",
							hintText: "Enter last name",
							labelText: "Last Name"),
				    ),
				),
			],
		);
  	}
}
