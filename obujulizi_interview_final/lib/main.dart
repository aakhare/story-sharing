import 'package:flutter/material.dart';
import 'package:obujulizi_interview_final/interview/services/interview_provider.dart';
import 'package:obujulizi_interview_final/utils/all.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
            ChangeNotifierProvider<InterviewStateProvider>(
                create: (_) => InterviewStateProvider()),
          ], child: const MyApp()));
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