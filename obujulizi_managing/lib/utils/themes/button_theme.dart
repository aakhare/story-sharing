import 'package:flutter/material.dart';
import 'package:obujulizi_managing/utils/all.dart';

class MyElevatedButtonTheme {
  ElevatedButtonThemeData theme() => ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(24.0),
          backgroundColor: pink,
          textStyle: elevated,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      );
}

class MyTextButtonTheme {
  TextButtonThemeData theme() => TextButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: textButtonPadding,
          textStyle: text,
          foregroundColor: pink,
        ),
      );
}

class MyFloatingActionButtonTheme {
  FloatingActionButtonThemeData theme() => FloatingActionButtonThemeData(
        foregroundColor: white,
        backgroundColor: pink,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
            side: const BorderSide(width: 2, color: pink)),
      );
}
