import 'package:flutter/material.dart';
import 'package:obujulizi_managing/interviews/services/interview_functions.dart';
import 'package:obujulizi_managing/interviews/services/interview_model.dart';
import 'package:obujulizi_managing/utils/all.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DashBoardContent extends StatefulWidget {
  const DashBoardContent({super.key});

  @override
  State<DashBoardContent> createState() => DashBoardContentState();
}

class DashBoardContentState extends State<DashBoardContent> {
  @override
  Widget build(BuildContext context) {
    Future<List<Interview>> futureInterviews =
        InterviewCreation.getAllInterviews(context: context);
    Future<List<Story>> futureStories =
        InterviewCreation.getAllStories(context: context);
    Future<List<Draft>> futureDrafts =
        InterviewCreation.getAllDrafts(context: context);

    double screenWidth = MediaQuery.of(context).size.width;
    var headerSpacing = SizedBox(width: screenWidth * 0.05);

    return SingleChildScrollView(
      child: Column(children: [
        Row(children: [
          headerSpacing,
          const Text("Current Statistics", style: headline1),
        ]),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: 450,
              height: 450,
              child: FutureBuilder<List<Interview>>(
                  future: futureInterviews,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final interviews = snapshot.data!;
                      return getInterviewsData(interviews);
                    } else {
                      return const Text("Data Loading");
                    }
                  }),
            ),
            Column(
              children: [
                FutureBuilder<List<Draft>>(
                    future: futureDrafts,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final drafts = snapshot.data!;
                        return buildDraftData(drafts);
                      } else {
                        return const Text("No Data");
                      }
                    }),
                largeVertical,
                FutureBuilder<List<Story>>(
                    future: futureStories,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final stories = snapshot.data!;
                        return buildStoryData(stories);
                      } else {
                        return const Text("No Data");
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
          const Text("* click on an interview to view its details", style: bodyText1),
        ]),
        smallVertical,
        Container(
          width: screenWidth * 0.90,
          decoration: BoxDecoration(
            color: pink,
            boxShadow: kElevationToShadow[4],
          ),
          child: const ListTile(
              leading: Text("Status"),
              title: Text("Title"),
              subtitle: Text("format"),
              trailing: Text("Date")),
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
                      leading: status,
                      title: Text(interview.title),
                      subtitle: Text(interview.format),
                      trailing: Text(interview.date),
                      onTap: () {
                        Navigator.pushNamed(
                            context, RoutesName.viewInterviewDetails,
                            arguments: IdInfo(
                                profileId: interview.profileId,
                                interviewId: interview.interviewId));
                      }),
                );
              }),
        ),
        mediumVertical
      ]),
    );
  }

  Widget getInterviewsData(List<Interview> interviews) {
    double greenNum = 0;
    double blueNum = 0;
    double yellowNum = 0;
    double redNum = 0;

    for (var interview in interviews) {
      if (interview.status == "APPROVED") {
        greenNum++;
      } else if (interview.status == "PENDING") {
        blueNum++;
      } else if (interview.status == "LAID ASIDE") {
        yellowNum++;
      } else if (interview.status == "DENIED") {
        redNum++;
      }
    }
    final List<ChartData> chartData = [
      ChartData('Approved', greenNum, green),
      ChartData('Pending', blueNum, blue),
      ChartData('Laid Aside', yellowNum, yellow),
      ChartData('Denied', redNum, red)
    ];
    return SfCircularChart(
        legend: Legend(isVisible: true),
        series: <CircularSeries>[
          PieSeries<ChartData, String>(
              dataSource: chartData,
              legendIconType: LegendIconType.horizontalLine,
              pointColorMapper: (ChartData data, _) => data.color,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.y)
        ]);
  }

  Widget buildDraftData(List<Draft> drafts) {
    int numDrafts = drafts.length;
    return Container(
        width: 400,
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
        width: 400,
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

class ChartData {
  ChartData(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color color;
}
