import 'package:flutter/material.dart';
import 'package:obujulizi_interview_final/auth/pages/login.dart';
import 'package:obujulizi_interview_final/utils/all.dart';

class MyAppBar extends StatelessWidget {
  final String title;
  const MyAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: pink,
      title: Align(
          alignment: Alignment.center, child: Text(title)),
      actions: [
        PopupMenuButton<AccountOptions>(
          icon: const Icon(Icons.account_box),
          onSelected: (value) {
            if (value == AccountOptions.logout) {
              Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) => const LoginPage()), (route) => false);
            } 
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: AccountOptions.logout,
              child: Text("Logout"),
            ),
          ],
        )
      ],
    );
  }
}
