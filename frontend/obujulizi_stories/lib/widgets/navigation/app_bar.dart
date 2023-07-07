import 'package:flutter/material.dart';
import 'package:obujulizi_stories/auth/pages/login.dart';
import 'package:obujulizi_stories/utils/all.dart';

class MyAppBar extends StatelessWidget {
  final String title;
  final bool button;
  const MyAppBar({super.key, required this.title, required this.button});

  @override
  Widget build(BuildContext context) {

    return AppBar(
      backgroundColor: pink,
      automaticallyImplyLeading: button,
      leading: (button) ? IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back_ios),
      ): SizedBox(width: 8, height: 8, child: Image.asset("assets/icons/small_icon.png")),
      title: Align(alignment: Alignment.center, child: Text(title)),
      actions: [
        PopupMenuButton<AccountOptions>(
          icon: const Icon(Icons.account_box),
          onSelected: (value) {
            if (value == AccountOptions.logout) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                  (route) => false);
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
