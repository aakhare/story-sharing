import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:obujulizi_interview_final/utils/all.dart';

void showActionSnackBar(
    BuildContext context, String message, SnackBarAction action) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: pink,
    content: Text(message),
    padding: sharedPadding,
    behavior: SnackBarBehavior.floating,
    action: action,
  ));
}

void showMessageSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: pink,
    content: Text(jsonDecode(message)),
    padding: sharedPadding,
    behavior: SnackBarBehavior.floating,
    duration: const Duration(seconds: 5),
  ));
}
