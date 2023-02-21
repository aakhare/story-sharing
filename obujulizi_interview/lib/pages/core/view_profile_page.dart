// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:obujulizi_interview/services/all.dart';
import 'package:obujulizi_interview/utils/all.dart';
import 'package:obujulizi_interview/widgets/all.dart';

class ViewProfilePage extends StatefulWidget {
  const ViewProfilePage({
    Key? key,
  }) : super(key: key);

  @override
  State<ViewProfilePage> createState() => ViewProfilePageState();
}

class ViewProfilePageState extends State<ViewProfilePage> {
  final globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final profileData =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final profileId = profileData["id"];
    final profileName = profileData["name"];
    final profileContactInfo = profileData["contactInfo"];

    return Scaffold(
      key: globalKey,
      drawer: const NavigationDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
            padding: smallPagePadding,
            child: Column(
              children: [
                mediumVertical,
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Flexible(
                      child: IconButton(
                          icon: const Icon(Icons.menu),
                          onPressed: () {
                            globalKey.currentState?.openDrawer();
                          })),
                ]),
                Column(
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      const Flexible(
                        child: Text("Name: ", style: headline1),
                      ),
                      Flexible(child: Text(profileName!, style: bodyText4))
                    ]),
                    extraSmallVertical,
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      const Flexible(
                          child:
                              Text("Contact Information: ", style: headline2)),
                      Flexible(child: Text(profileContactInfo!, style: bodyText3))
                    ]),
                    smallVertical,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: ElevatedButton(
                              child: const Text("Update Profile"),
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, RoutesName.updateProfile);
                              }),
                        ),
                        Flexible(
                          child: ElevatedButton(
                              child: const Text("Add Interview"),
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, RoutesName.questionsGuide);
                              }),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
