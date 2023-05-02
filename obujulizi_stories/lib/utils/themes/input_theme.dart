import 'package:flutter/material.dart';
import 'package:obujulizi_stories/utils/all.dart';

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
        focusedBorder: buildBorder(pink),
        disabledBorder: buildBorder(lightGrey),

        //Text
        counterStyle: counter,
        floatingLabelStyle: floatingLabel,
        errorStyle: error,
        helperStyle: helper,
        hintStyle: hint,
      );
}

class MyTextSelectionTheme {
  TextSelectionThemeData theme() => const TextSelectionThemeData(
        cursorColor: pink,
        selectionColor: pink,
        selectionHandleColor: pink,
      );
}