import 'package:flutter/material.dart';
import 'package:obujulizi_interview_final/utils/all.dart';
import 'package:obujulizi_interview_final/widgets/all.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: pink,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const NavigationHeader(),
            const NavigationItems(),
            const Divider(),
            AddButton(
              onPressed: () {
                Navigator.pushNamed(context, RoutesName.addProfile);
              },
            ),
          ],
        ),
      ),
    );
  }
}
