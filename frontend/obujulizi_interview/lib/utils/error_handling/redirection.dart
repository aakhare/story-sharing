import 'dart:async';
import 'package:flutter/material.dart';
import 'package:obujulizi_interview_final/utils/all.dart';

class ErrorPage extends StatefulWidget {
  const ErrorPage({super.key});

  @override
  State<ErrorPage> createState() => ErrorPageState();
}

class ErrorPageState extends State<ErrorPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5),
        () => Navigator.pushNamed(context, RoutesName.home));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Oops, there has been an error", style: headline1, selectionColor: pink))
    );
  }
}