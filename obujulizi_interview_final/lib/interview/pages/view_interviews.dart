import 'package:flutter/material.dart';
import 'package:obujulizi_interview_final/interview/all.dart';
import 'package:obujulizi_interview_final/utils/all.dart';
import 'package:obujulizi_interview_final/widgets/all.dart';

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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
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
      body: Padding(
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
                Align(
                  alignment: Alignment.centerLeft,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                          context, RoutesName.questionsGuide,
                          arguments: widget.profileId);
                    }, child: const Text("Add Interview"),
                  ),
                ),
                SizedBox(
                  width: screenWidth,
                  height: screenHeight * 0.70,
                  child: FutureBuilder<List<InfoRow>>(
                      future: futureInterviews,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final interviews = snapshot.data!;
                          return buildInterviews(interviews);
                        } else {
                          return const MyProgressIndicator();
                        }
                      }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInterviews(List<InfoRow> interviews) {
    final columns = ['Title', 'Format', 'Date'];
    double screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
        width: screenWidth,
        child: SingleChildScrollView(
          child: DataTable(
            columns: getColumns(columns),
            rows: getRows(interviews),
          ),
        ));
  }

  List<DataColumn> getColumns(List<String> columns) =>
      columns.map((String column) => DataColumn(label: Text(column))).toList();

  List<DataRow> getRows(List<InfoRow> interviews) =>
      interviews.map((InfoRow interviews) {
        final cells = [interviews.title, interviews.format, interviews.date];
        return DataRow(cells: getCells(cells));
      }).toList();

  List<DataCell> getCells(List<dynamic> cells) =>
      cells.map((data) => DataCell(Text('$data'))).toList();
}
