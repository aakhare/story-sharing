//Packages
import 'package:flutter/material.dart';

//Other
import 'interview/utils/all.dart';
import 'interview/auth/all.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
		title: 'Obujulizi Share',
		theme: ThemeData(
			primaryColor: white,
			fontFamily: "Lato",
		),
		home: const Splash(),
    );
  }
}
