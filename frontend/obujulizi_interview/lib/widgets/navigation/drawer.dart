import 'package:flutter/material.dart';
import 'package:obujulizi_interview_final/utils/all.dart';
import 'package:obujulizi_interview_final/widgets/all.dart';

class MyNavigationDrawer extends StatelessWidget {
  const MyNavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: pink,
      child: Column(
        children: [
          const NavigationHeader(),
          const NavigationItems(),
          const Divider(),
          AddButton(
            givenColor: white,
            size: 25,
            onPressed: () {
              Navigator.pushNamed(context, RoutesName.addProfile);
            },
          ),
        ],
      ),
    );
  }
}
