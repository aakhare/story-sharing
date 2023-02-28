import 'package:flutter/material.dart';
import 'package:obujulizi_interview_final/services/all.dart';
import 'package:obujulizi_interview_final/utils/all.dart';
import 'package:obujulizi_interview_final/widgets/all.dart';

class ViewProfilePage extends StatefulWidget {
  const ViewProfilePage({
    Key? key,
  }) : super(key: key);

  @override
  State<ViewProfilePage> createState() => ViewProfilePageState();
}

class ViewProfilePageState extends State<ViewProfilePage> {
  final globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final profileData =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final profileId = profileData["id"];
    final profileName = profileData["name"];
    final profileContactInfo = profileData["contactInfo"];

    Future<List<InterviewData>> futureInterviews =
        InterviewCreation.getAllInterviews(
            context: context, profileId: profileId);

    return Scaffold(
      key: globalKey,
      drawer: const NavigationDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
            padding: smallPagePadding,
            child: Column(
              children: [
                mediumVertical,
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Flexible(
                      child: IconButton(
                          icon: const Icon(Icons.menu),
                          onPressed: () {
                            globalKey.currentState?.openDrawer();
                          })),
                ]),
                Column(
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      const Flexible(
                        child: Text("Name: ", style: headline1),
                      ),
                      Flexible(child: Text(profileName!, style: bodyText4))
                    ]),
                    extraSmallVertical,
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      const Flexible(
                          child:
                              Text("Contact Information: ", style: headline2)),
                      Flexible(
                          child: Text(profileContactInfo!, style: bodyText3))
                    ]),
                    smallVertical,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: ElevatedButton(
                              child: const Text("Update Profile"),
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, RoutesName.updateProfile);
                              }),
                        ),
                        Flexible(
                          child: ElevatedButton(
                              child: const Text("Add Interview"),
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, RoutesName.questionsGuide,
                                    arguments: profileId);
                              }),
                        ),
                      ],
                    ),
                    SingleChildScrollView(
                        child: FutureBuilder<List<InterviewData>>(
                            future: futureInterviews,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                final interviews = snapshot.data!;
                                return buildInterviews(interviews);
                              } else {
                                return const Text('No User Data');
                              }
                            }))
                  ],
                ),
              ],
            )),
      ),
    );
  }

  Widget buildInterviews(List<InterviewData> interviews) {
    final columns = ['Title', 'Format', 'Date'];
    return DataTable(
        columns: getColumns(columns), rows: getRows(interviews));
  }

  List<DataColumn> getColumns(List<String> columns) =>
      columns.map((String column) => DataColumn(label: Text(column))).toList();

  List<DataRow> getRows(List<InterviewData> interviews) =>
      interviews.map((InterviewData interviews) {
        final cells = [
          interviews.title,
          interviews.format,
          interviews.date
        ];
        return DataRow(cells: getCells(cells));
      }).toList();

  List<DataCell> getCells(List<dynamic> cells) => cells.map((data) => DataCell(Text('$data'))).toList();
}
