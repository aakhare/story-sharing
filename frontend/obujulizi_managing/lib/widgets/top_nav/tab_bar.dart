import 'package:flutter/material.dart';
import 'package:obujulizi_managing/auth/pages/login.dart';
import 'package:obujulizi_managing/utils/all.dart';

class TabBarLayout extends StatelessWidget {
  const TabBarLayout(
      {super.key, required this.tabController, required this.tabs});

  final TabController tabController;
  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            SizedBox(
                width: 42,
                height: 42,
                child: Image.asset("assets/icons/main_icon.png")),
                smallHorizontal,
            Column(
              children: [
                title,
                caption
              ],
            ),
          ],
        ),
      ),
      SizedBox(
          width: 500, child: TabBar(controller: tabController, tabs: tabs)),
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
          )
        ],
      ),
    ]);
  }
}
