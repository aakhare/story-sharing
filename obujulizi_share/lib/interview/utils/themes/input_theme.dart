//Packages
import 'package:flutter/material.dart';

//Other
import '../all.dart';

class MyInputTheme {
	OutlineInputBorder buildBorder(Color color) {
		return OutlineInputBorder(
		borderRadius: const BorderRadius.all(Radius.circular((5))),
		borderSide: BorderSide(color: color, width: 2.0),
		);
  	}

  InputDecorationTheme theme() => InputDecorationTheme(
		//Padding
		contentPadding: const EdgeInsets.all(16),

		//Label
		floatingLabelBehavior: FloatingLabelBehavior.always,

		//Borders
		enabledBorder: buildBorder(darkGrey),
		errorBorder: buildBorder(red),
		focusedErrorBorder: buildBorder(red),
		border: buildBorder(pink),
		focusedBorder: buildBorder(blue),
		disabledBorder: buildBorder(lightGrey),

		//Text
		counterStyle: counter,
		floatingLabelStyle: floatingLabel,
		errorStyle: error,
		helperStyle: helper,
		hintStyle: hint,
    );
}
