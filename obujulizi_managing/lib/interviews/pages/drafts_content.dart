import 'package:flutter/material.dart';
import 'package:obujulizi_managing/interviews/services/interview_functions.dart';
import 'package:obujulizi_managing/interviews/services/interview_model.dart';
import 'package:obujulizi_managing/utils/all.dart';

class DraftsContent extends StatefulWidget {
  const DraftsContent({super.key});

  @override
  State<DraftsContent> createState() => DraftsContentState();
}

class DraftsContentState extends State<DraftsContent> {

  @override
  Widget build(BuildContext context) {
        Future<List<Draft>> futureDrafts =
        InterviewCreation.getAllDrafts(context: context);
    return SingleChildScrollView(
      child: Column(children: [
        FutureBuilder<List<Draft>>(
                    future: futureDrafts,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final drafts = snapshot.data!;
                        return buildInterviews(drafts);
                      } else {
                        return const Text("No Data");
                      }
                    }),
      ]),
    );
  }

  Widget buildInterviews(List<Draft> drafts) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    var headerSpacing = SizedBox(width: screenWidth * 0.05);

    return SafeArea(
      child: Column(children: [
        Row(children: [
          headerSpacing,
          const Text("All Drafts", style: headline1)
        ]),
        smallVertical,
        Row(children: [
          headerSpacing,
          const Text("* click on a draft to create a story with it", style: bodyText1),
        ]),
        smallVertical,
        Container(
          width: screenWidth * 0.90,
          decoration: BoxDecoration(
            color: pink,
            boxShadow: kElevationToShadow[4],
          ),
          child: const ListTile(
              title: Text("Title"),),
        ),
        Container(
          width: screenWidth * 0.90,
          height: screenHeight * 0.75,
          decoration: BoxDecoration(
            color: white,
            boxShadow: kElevationToShadow[4],
          ),
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: drafts.length,
              itemBuilder: (context, index) {
                final draft = drafts[index];
                return Container(
                  decoration:
                      const BoxDecoration(border: Border(bottom: BorderSide())),
                  child: ListTile(
                      title: Text(draft.title),
                      onTap: () {
                        Navigator.pushNamed(
                            context, RoutesName.viewInterviewDetails,
                            //add arguments
                            );
                      }),
                );
              }),
        ),
        mediumVertical
      ]),
    );
  }
}