import 'package:flutter/material.dart';
import 'package:obujulizi_interviews/interviews/all.dart';
import 'package:obujulizi_interviews/utils/all.dart';
import 'package:obujulizi_interviews/widgets/all.dart';

class ViewInterviewsPage extends StatefulWidget {
  final String profileId;
  final String contactInfo;
  final String name;

  const ViewInterviewsPage({
    Key? key,
    required this.profileId,
    required this.contactInfo,
    required this.name,
  }) : super(key: key);

  @override
  State<ViewInterviewsPage> createState() => ViewInterviewsPageState();
}

class ViewInterviewsPageState extends State<ViewInterviewsPage> {
  final globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    String pageTitle = 'View Profile';
    String id = widget.profileId;
    String name = widget.name;
    String info = widget.contactInfo;

    Future<List<InfoRow>> futureInterviews =
        InterviewCreation.getAllInterviews(context: context, profileId: id);

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: MyAppBar(title: pageTitle)),
      drawer: const MyNavigationDrawer(),
      key: globalKey,
      body: SafeArea(
        child: SingleChildScrollView(
            padding: pagePadding,
            child: Column(
              children: [
                Column(
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      extraLargeVertical,
                      const Flexible(
                        child: Text("Name: ", style: headline1),
                      ),
                      Flexible(child: Text(name, style: bodyText4))
                    ]),
                    extraSmallVertical,
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      const Flexible(
                          child:
                              Text("Contact Information: ", style: headline2)),
                      Flexible(child: Text(info, style: bodyText3))
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
                          child: AddButton(
                            givenColor: black,
                            size: 50,
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, RoutesName.questionsGuide,
                                  arguments: widget.profileId);
                            },
                          ),
                        ),
                      ],
                    ),
                    SingleChildScrollView(
                        child: FutureBuilder<List<InfoRow>>(
                            future: futureInterviews,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                final interviews = snapshot.data!;
                                return buildInterviews(interviews);
                              } else {
                                return const Text('No User Data');
                              }
                            })),
                  ],
                ),
              ],
            )),
      ),
    );
  }

  Widget buildInterviews(List<InfoRow> interviews) {
    final columns = ['Title'];
    return DataTable(columns: getColumns(columns), rows: getRows(interviews));
  }

  List<DataColumn> getColumns(List<String> columns) =>
      columns.map((String column) => DataColumn(label: Text(column))).toList();

  List<DataRow> getRows(List<InfoRow> interviews) =>
      interviews.map((InfoRow interviews) {
        final cells = [interviews.title];
        return DataRow(cells: getCells(cells));
      }).toList();

  List<DataCell> getCells(List<dynamic> cells) =>
      cells.map((data) => DataCell(Text('$data'))).toList();
}
