import 'package:flutter/material.dart';
import 'package:obujulizi_managing/interviews/all.dart';
import 'package:obujulizi_managing/stories/all.dart';
import 'package:obujulizi_managing/utils/all.dart';
import 'package:fl_chart/fl_chart.dart';

class DashBoardContent extends StatefulWidget {
  const DashBoardContent({super.key});

  @override
  State<DashBoardContent> createState() => DashBoardContentState();
}

class DashBoardContentState extends State<DashBoardContent> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<List<Interview>> futureInterviews =
        InterviewCreation.getAllInterviews(context: context);
    Future<List<Story>> futureStories =
        DraftFunction.getAllStories(context: context);
    Future<List<Draft>> futureDrafts =
        DraftFunction.getAllDrafts(context: context);

    double screenWidth = MediaQuery.of(context).size.width;
    var headerSpacing = SizedBox(width: screenWidth * 0.05);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          extraLargeVertical,
          Row(children: [
            headerSpacing,
            const Text("Current Statistics", style: headline1),
          ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FutureBuilder<List<Interview>>(
                  future: futureInterviews,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final interviews = snapshot.data!;
                      return getInterviewsData(interviews);
                    } else {
                      return const Text("No Data");
                    }
                  }),
              Column(
                children: [
                  FutureBuilder<List<Draft>>(
                      future: futureDrafts,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final drafts = snapshot.data!;
                          return buildDraftData(drafts);
                        } else {
                          return const Text("No Drafts");
                        }
                      }),
                  extraLargeVertical,
                  FutureBuilder<List<Story>>(
                      future: futureStories,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final stories = snapshot.data!;
                          return buildStoryData(stories);
                        } else {
                          return const Text("No Stories");
                        }
                      }),
                ],
              ),
            ],
          ),
          FutureBuilder<List<Interview>>(
              future: futureInterviews,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final interviews = snapshot.data!;
                  return buildInterviews(interviews);
                } else {
                  return const Text("No Data");
                }
              }),
        ]),
      ),
    );
  }

  Widget buildInterviews(List<Interview> interviews) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    int length = interviews.length;
    var headerSpacing = SizedBox(width: screenWidth * 0.05);

    return SafeArea(
      child: Column(children: [
        Row(children: [
          headerSpacing,
          const Text("All Interviews", style: headline1),
          smallHorizontal,
          Text("($length total)"),
        ]),
        smallVertical,
        Row(children: [
          headerSpacing,
          const Text("* click on an interview to view its details",
              style: bodyText1),
        ]),
        smallVertical,
        Container(
          width: screenWidth * 0.90,
          decoration: BoxDecoration(
            color: pink,
            boxShadow: kElevationToShadow[4],
          ),
          child: const ListTile(
              horizontalTitleGap: 50,
              leading: Text("Status"),
              title: Text("Title", style: headline3),
              subtitle: Text("format", style: bodyText1),
              trailing: Text("Date", style: bodyText2)),
        ),
        Container(
          width: screenWidth * 0.90,
          height: screenHeight / 2,
          decoration: BoxDecoration(
            color: white,
            boxShadow: kElevationToShadow[4],
          ),
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: interviews.length,
              itemBuilder: (context, index) {
                final interview = interviews[index];
                Icon status = const Icon(Icons.done, color: green);
                if (interview.status == "PENDING") {
                  status = const Icon(Icons.schedule, color: blue);
                } else if (interview.status == "LAID ASIDE") {
                  status = const Icon(Icons.bookmark, color: yellow);
                } else if (interview.status == "DENIED") {
                  status = const Icon(Icons.close, color: red);
                }
                return Container(
                  decoration:
                      const BoxDecoration(border: Border(bottom: BorderSide())),
                  child: ListTile(
                      horizontalTitleGap: 50,
                      leading: status,
                      title: Row(
                        children: [
                          Text(interview.title, style: headline3),
                        ],
                      ),
                      subtitle: Text(interview.format, style: bodyText1),
                      trailing: Text(interview.date, style: bodyText2),
                      onTap: () {
                        Navigator.pushNamed(
                                context, RoutesName.viewInterviewDetails,
                                arguments: IdInfo(
                                    profileId: interview.profileId,
                                    interviewId: interview.interviewId))
                            .then((_) {
                          setState(() {});
                        });
                      }),
                );
              }),
        ),
        mediumVertical
      ]),
    );
  }

  SizedBox getInterviewsData(List<Interview> interviews) {
    double greenNum = 0;
    double blueNum = 0;
    double yellowNum = 0;
    double redNum = 0;
    double total = 0;

    for (var interview in interviews) {
      if (interview.status == "APPROVED") {
        greenNum++;
        total++;
      } else if (interview.status == "PENDING") {
        blueNum++;
        total++;
      } else if (interview.status == "LAID ASIDE") {
        yellowNum++;
        total++;
      } else if (interview.status == "DENIED") {
        redNum++;
        total++;
      }
    }

    final List<Data> data = [
      Data(
          name: 'Approved',
          percent: ((greenNum / total) * 100).round(),
          color: green,
          radius: 175),
      Data(
          name: 'Pending',
          percent: ((blueNum / total) * 100).round(),
          color: blue,
          radius: 175),
      Data(
          name: 'Laid Aside',
          percent: ((yellowNum / total) * 100).round(),
          color: yellow,
          radius: 175),
      Data(
          name: 'Denied',
          percent: ((redNum / total) * 100).round(),
          color: red,
          radius: 175)
    ];
    return SizedBox(
      width: 450,
      height: 450,
      child: Row(
        children: [
          Flexible(
            child: PieChart(
              PieChartData(
                  sections: getSection(data),
                  sectionsSpace: 2,
                  centerSpaceRadius: 0),
            ),
          ),
          Flexible(
            child: Column(
              children: [
                extraLargeVertical,
                extraLargeVertical,
                extraLargeVertical,
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  largeHorizontal,
                  largeHorizontal,
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: data
                              .map((data) => Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: buildLegend(
                                      color: data.color, labels: data.name)))
                              .toList()))
                ]),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildLegend({required Color color, required String labels}) {
    return Row(children: <Widget>[
      Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
      smallHorizontal,
      Text(labels, style: bodyText2)
    ]);
  }

  List<PieChartSectionData> getSection(List<Data> data) => data
      .asMap()
      .map<int, PieChartSectionData>((index, data) {
        final value = PieChartSectionData(
            title: "${data.percent}%",
            titleStyle: otherBody,
            value: data.percent as double,
            color: data.color,
            radius: data.radius);
        return MapEntry(index, value);
      })
      .values
      .toList();

  Widget buildDraftData(List<Draft> drafts) {
    int numDrafts = drafts.length;
    return Container(
        width: 450,
        height: 100,
        decoration: BoxDecoration(
            gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [purple, pink]),
            boxShadow: kElevationToShadow[4]),
        child: Row(children: [
          mediumHorizontal,
          Text("$numDrafts", style: otherHeadline1),
          largeHorizontal,
          const Text("Saved Drafts", style: otherBody)
        ]));
  }

  Widget buildStoryData(List<Story> stories) {
    int numStories = stories.length;
    return Container(
        width: 450,
        height: 100,
        decoration: BoxDecoration(
            gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [purple, pink]),
            boxShadow: kElevationToShadow[4]),
        child: Row(children: [
          mediumHorizontal,
          Text("$numStories", style: otherHeadline1),
          largeHorizontal,
          const Text("Stories Posted", style: otherBody)
        ]));
  }
}

class Data {
  final String name;
  final int percent;
  final Color color;
  final double radius;

  Data(
      {required this.name,
      required this.percent,
      required this.color,
      required this.radius});
}
