//Packages
import 'package:flutter/material.dart';
import 'dart:async';

//Pages
import 'login.dart';

//Other
import '../utils/all.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<StatefulWidget> createState() => SplashState();
}

class SplashState extends State<Splash> {
  @override
  // void initState() {
  //   super.initState();
  //   Timer(
  //       const Duration(seconds: 3),
  //       () => Navigator.pushReplacement(
  //           context,
  //           MaterialPageRoute(
  //               builder: (context) => const LoginPage(
  //                     title: "Interview App",
  //                   ))));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [purple, magenta, pink, orange])),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Image.asset("../../assets/icons/icon_main.png"),
              mediumVertical,
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Obujulizi Share", style: headline1),
              ),
              const Padding(
                padding: EdgeInsets.all(4.0),
                child: Text("Interview App", style: headline2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
