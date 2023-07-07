import 'package:flutter/material.dart';
import 'package:obujulizi_interview_final/profile/all.dart';
import 'package:obujulizi_interview_final/utils/all.dart';
import 'package:obujulizi_interview_final/widgets/progress/circular_indicator.dart';

class NavigationItems extends StatefulWidget {
  const NavigationItems({
    Key? key,
  }) : super(key: key);

  @override
  NavigationItemsState createState() => NavigationItemsState();
}

class NavigationItemsState extends State<NavigationItems> {
  @override
  Widget build(BuildContext context) {
    Future<List<Profile>> futureProfiles =
        ProfileSetUp.getAllProfiles(context: context);

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
              leading: const Icon(Icons.home_filled, color: white),
              title: const Text("Home Page", style: otherBody),
              onTap: () {
                Navigator.pushNamed(context, RoutesName.home);
              }),
          const Divider(),
          const Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            smallHorizontal,
            Flexible(child: Text("Already Interviewed", style: otherHeadline2)),
            Divider(),
          ]),
          FutureBuilder<List<Profile>>(
              future: futureProfiles,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final profiles = snapshot.data!;
                  return buildProfiles(profiles);
                } else {
                  return const Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: MyProgressIndicator(),
                  );
                }
              }),
        ],
      ),
    );
  }

  Widget buildProfiles(List<Profile> profiles) {
    return Expanded(
      child: ListView.builder(
          itemCount: profiles.length,
          itemBuilder: (context, index) {
            final profile = profiles[index];
            return ListTile(
                leading:
                    const Icon(Icons.account_circle_sharp, color: white),
                title: Text(profile.name, style: otherBody),
                onTap: () {
                  Navigator.pushNamed(context, RoutesName.viewProfile,
                      arguments: Profile(
                          contactInfo: profile.contactInfo,
                          name: profile.name,
                          profileId: profile.profileId));
                });
          }),
    );
  }
}
