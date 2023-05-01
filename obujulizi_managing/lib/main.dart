import 'package:flutter/material.dart';
import 'package:obujulizi_managing/utils/all.dart';
import 'utils/themes/nav_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Obujulizi Share',
      theme: ThemeData(
        primaryColor: white,
        fontFamily: "Lato",
        inputDecorationTheme: MyInputTheme().theme(),
        elevatedButtonTheme: MyElevatedButtonTheme().theme(),
        floatingActionButtonTheme: MyFloatingActionButtonTheme().theme(),
        textButtonTheme: MyTextButtonTheme().theme(),
        textSelectionTheme: MyTextSelectionTheme().theme(),
        tabBarTheme: MyTabBarTheme().theme(),
      ),
      initialRoute: RoutesName.login,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
