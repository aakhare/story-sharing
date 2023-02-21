import 'package:flutter/material.dart';
import 'package:obujulizi_interview/services/all.dart';
import 'package:obujulizi_interview/utils/all.dart';

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

    return Wrap(
        runSpacing: 14,
        crossAxisAlignment: WrapCrossAlignment.start,
        children: [
          ListTile(
              leading: const Icon(Icons.home_filled, color: white),
              title: const Text("Home Page", style: otherBody),
              onTap: () {
                Navigator.pushNamed(context, RoutesName.home);
              }),
          const Divider(),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: const [
            smallHorizontal,
            Flexible(child: Text("Already Interviewed", style: otherHeadline2))
          ]),
          SingleChildScrollView(
              child: FutureBuilder<List<Profile>>(
                  future: futureProfiles,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final profiles = snapshot.data!;
                      return buildProfiles(profiles);
                    } else {
                      return const Text('No User Data');
                    }
                  }))
        ]);
  }

  Widget buildProfiles(List<Profile> profiles) => ListView.builder(
      itemCount: profiles.length,
      itemBuilder: (context, index) {
        final profile = profiles[index];
        final Map<String, String> profileData = {'id': profile.profileId, 'name': profile.name, 'contactInfo': profile.contactInfo};
        return Card(
            child: ListTile(
                leading:
                    const Icon(Icons.account_circle_outlined, color: white),
                title: Text(profile.name, style: otherBody),
                onTap: () {
                  Navigator.pushNamed(context, RoutesName.viewProfile,
                      arguments: profileData);
                }));
      });
}
