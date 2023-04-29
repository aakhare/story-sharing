import 'package:flutter/material.dart';
import 'package:obujulizi_managing/utils/all.dart';

class TabBarLayout extends StatelessWidget {
  const TabBarLayout(
      {super.key, required this.tabController, required this.tabs});

  final TabController tabController;
  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text("Obujulizi Share", style: tabHeader),
      ),
      SizedBox(
          width: 500, child: TabBar(controller: tabController, tabs: tabs)),
      PopupMenuButton<AccountOptions>(
        icon: const Icon(Icons.account_box),
        onSelected: (value) {
          if (value == AccountOptions.logout) {
            Navigator.pushNamed(context, RoutesName.login);
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
