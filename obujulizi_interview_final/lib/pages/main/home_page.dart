import 'package:flutter/material.dart';
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
  final globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      drawer: const NavigationDrawer(),
      body: SafeArea(
        child: Column(children: [
          mediumVertical,
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Flexible(
                child: IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () {
                      globalKey.currentState?.openDrawer();
                    })),
            const Flexible(child: Text("Home Page", style: headline2)),
            Flexible(
                child: PopupMenuButton<AccountOptions>(
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
            )),
          ]),
          extraLargeVertical,
          Padding(
              padding: pagePadding,
              child: Column(children: [
                Image.asset("assets/icons/gradient_icon_large.png"),
                mediumVertical,
                const Text(
                    "Welcome to Obujulizi Share - Interview App. Go to the side navigation bar to veiw profile data, make a new profile, or create new interviews.",
                    style: headline1),
                mediumVertical,
                const Align(
                  alignment: Alignment.centerRight,
                  child: Text("- Rose Academies", style: headline4),
                )
              ]))
        ]),
      ),
    );
  }
}
