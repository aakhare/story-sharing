import 'package:flutter/material.dart';
import 'dart:async';
import 'package:obujulizi_interview_final/utils/all.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<StatefulWidget> createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3),
        () => Navigator.pushNamed(context, RoutesName.login));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [purple, magenta, pink])),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/icons/white_icon.png"),
              mediumVertical,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child:  title,
                ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: caption,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
