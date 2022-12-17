//Packages
import 'package:flutter/material.dart';

//Other
import '../../utils/all.dart';

class PasswordField extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PasswordFieldState();
}

class PasswordFieldState extends State<PasswordField> {
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
		validator: (password) {
				if (password == null || password.isEmpty) {
					return "Empty password";
				}
				return null;
		},
		obscureText: obscurePassword,
		keyboardType: TextInputType.visiblePassword,
		decoration: InputDecoration(
			labelText: "Password field",
			helperText: "",
			hintText: "Password",
			suffixIcon: IconButton(
			onPressed: () => setState(() {
				obscurePassword != obscurePassword;
			}),
			icon: Icon(
				obscurePassword ? Icons.visibility : Icons.visibility_off,
				color: black,
			),
			),
		),
    );
  }
}
