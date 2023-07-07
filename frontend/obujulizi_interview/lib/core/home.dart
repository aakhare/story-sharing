import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:obujulizi_interview_final/utils/all.dart';
import 'package:obujulizi_interview_final/widgets/all.dart';

enum AccountOptions {
  logout,
  updateAccount,
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  String pageTitle = 'Home Page';
  final globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: MyAppBar(title: pageTitle)),
      drawer: const MyNavigationDrawer(),
      key: globalKey,
      body: SingleChildScrollView(
          child: Center(
            child: Padding(
                padding: pagePadding,
                child: Column(children: [
                  mediumVertical,
                  Image.asset("assets/icons/main_icon.png"),
                  largeVertical,
                  Text(
                      "Welcome to Obujulizi Share - Interview App. Go to the side navigation bar to veiw profile data, make a new profile, or create new interviews.",
                      style: GoogleFonts.playfairDisplay(textStyle: headline1)),
                  largeVertical,
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text("Rose Academies",
                        style: GoogleFonts.cinzel(textStyle: headline4)),
                  )
                ])),
          )),
    );
  }
}
