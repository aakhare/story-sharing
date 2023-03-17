import 'package:flutter/material.dart';
import 'package:obujulizi_interviews/utils/all.dart';

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
              Navigator.pushNamed(context, RoutesName.login);
            } else if (value == AccountOptions.updateAccount) {
              Navigator.pushNamed(context, RoutesName.updateAccount);
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: AccountOptions.logout,
              child: Text("Logout"),
            ),
            const PopupMenuItem(
              value: AccountOptions.updateAccount,
              child: Text("Update Account"),
            ),
          ],
        )
      ],
    );
  }
}
