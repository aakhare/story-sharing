import 'package:flutter/material.dart';
import 'package:obujulizi_interview_final/utils/all.dart';

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
        inputDecorationTheme: MyInputTheme().theme(),
        elevatedButtonTheme: MyElevatedButtonTheme().theme(),
        floatingActionButtonTheme: MyFloatingActionButtonTheme().theme(),
        textButtonTheme: MyTextButtonTheme().theme(),
        textSelectionTheme: MyTextSelectionTheme().theme(),
      ),
      initialRoute: RoutesName.splash,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}