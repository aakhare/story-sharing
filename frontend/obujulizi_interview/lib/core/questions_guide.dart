import 'package:flutter/material.dart';
import 'package:obujulizi_interview_final/interview/all.dart';
import 'package:obujulizi_interview_final/utils/all.dart';

class QuestionsGuidePage extends StatefulWidget {
  final String profileId;
  const QuestionsGuidePage({super.key, required this.profileId});

  @override
  State<QuestionsGuidePage> createState() => QuestionsGuidePageState();
}

class QuestionsGuidePageState extends State<QuestionsGuidePage> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scrollbar(
          thickness: 10,
          thumbVisibility: true,
          child: SingleChildScrollView(
            padding: smallPagePadding,
            child: Column(
              children: [
                mediumVertical,
                Image.asset("assets/icons/gradient_icon.png"),
                smallVertical,
                const Text("Rose Academies Interview Guide", style: headline1),
                smallVertical,
                const Text("Obujulizi Share: Interview App", style: headline2),
                mediumVertical,
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Questionare for Adults", style: headline2),
                    mediumVertical,
                    Text("1. What is your name?", style: bodyText2),
                    smallVertical,
                    Text("2. How old are you?", style: bodyText2),
                    smallVertical,
                    Text("3. Are you married?", style: bodyText2),
                    smallVertical,
                    Text("   a. If yes, how old were you when you married?",
                        style: bodyText1),
                    smallVertical,
                    Text(
                        "   b. If yes, do you have regrets for marrying when you did?",
                        style: bodyText1),
                    smallVertical,
                    Text("4. Do you have children?", style: bodyText2),
                    smallVertical,
                    Text(
                        "   a. How old were you when you first got pregnant (if a woman)?",
                        style: bodyText1),
                    smallVertical,
                    Text(
                        "   b. How old were you when you first had a child (if a man)?",
                        style: bodyText1),
                    smallVertical,
                    Text("5. How many children do you have?", style: bodyText2),
                    smallVertical,
                    Text("6. Did you ever suffer the loss of a child?",
                        style: bodyText2),
                    smallVertical,
                    Text("   a. If yes, what happened?", style: bodyText1),
                    smallVertical,
                    Text(
                        "7. Would you say that life has been difficult for you and your family?  Why?",
                        style: bodyText2),
                    smallVertical,
                    Text(
                        "8. Have you ever suffered from violence? What happened? Do you have any lasting effects? What?",
                        style: bodyText2),
                    smallVertical,
                    Text(
                        "9. Do you feel that women deserve to be beaten if they don't please their husband? Why or why not?",
                        style: bodyText2),
                    smallVertical,
                    Text(
                        "10. Are you or anyone in your family disabled? If yes, what type of disability?",
                        style: bodyText2),
                    smallVertical,
                    Text(
                        "   a. If yes, what has been the most difficult thing about being disabled (for you or your family member)?",
                        style: bodyText1),
                    smallVertical,
                    Text(
                        "11.	What has been the hardest thing you have ever had to do in your life? Why was it hard?",
                        style: bodyText2),
                    smallVertical,
                    Text("Questionare for Youth", style: headline2),
                    mediumVertical,
                    Text("1. What is your name?", style: bodyText2),
                    smallVertical,
                    Text("2. How old are you?", style: bodyText2),
                    smallVertical,
                    Text("3. How many children are in your family?",
                        style: bodyText2),
                    smallVertical,
                    Text("4. Are you the oldest, youngest, or in between?",
                        style: bodyText2),
                    smallVertical,
                    Text(
                        "5. Would you say that life has been difficult for you and your family?  Why?",
                        style: bodyText2),
                    smallVertical,
                    Text(
                        "6. Have you ever suffered from violence? What happened? Do you have any lasting effects? What?",
                        style: bodyText2),
                    smallVertical,
                    Text(
                        "7. Are you or anyone in your family disabled? If yes, what type of disability?",
                        style: bodyText2),
                    smallVertical,
                    Text(
                        "   a. If yes, what has been the most difficult thing about being disabled (for you or your family member)?",
                        style: bodyText1),
                    smallVertical,
                    Text(
                        "8. What has been the hardest thing you have ever had to do in your life? Why was it hard?",
                        style: bodyText2),
                    smallVertical,
                    Text(
                        "9.	What would you like to do if you had the opportunity?",
                        style: bodyText2),
                    smallVertical,
                    Text("Questionare for the Disabled", style: headline2),
                    mediumVertical,
                    Text("1. What is your name?", style: bodyText2),
                    smallVertical,
                    Text("2. How old are you?", style: bodyText2),
                    smallVertical,
                    Text(
                        "3. What has been the most difficult thing about being disabled (for you or your family member)?",
                        style: bodyText2),
                    smallVertical,
                    Text("4. Are you married?", style: bodyText2),
                    smallVertical,
                    Text("   a. If yes, how old were you when you married?",
                        style: bodyText1),
                    smallVertical,
                    Text("5. Do you have children?", style: bodyText2),
                    smallVertical,
                    Text(
                        "   a. How old were you when you first got pregnant (if a woman)?",
                        style: bodyText1),
                    smallVertical,
                    Text(
                        "   b. How old were you when you first had a child (if a man)?",
                        style: bodyText1),
                    smallVertical,
                    Text("6. Did you ever suffer the loss of a child?",
                        style: bodyText2),
                    smallVertical,
                    Text("   a. If yes, what happened?", style: bodyText1),
                    smallVertical,
                    Text(
                        "7. Have you ever suffered from violence? What happened? Do you have any lasting effects? What are they",
                        style: bodyText2),
                    smallVertical,
                    Text(
                        "8. What has been the hardest thing you have ever had to do in your life? Why was it hard?",
                        style: bodyText2),
                    smallVertical,
                  ],
                ),
                Row(
                  children: [
                    Flexible(
                      child: Checkbox(
                        value: isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked = value!;
                          });
                        },
                      ),
                    ),
                    const Flexible(
                        child: Text(
                            "I have read and will follow the Interview Guide")),
                  ],
                ),
                ElevatedButton(
                    onPressed: isChecked == true
                        ? () async {
                            Navigator.pushNamed(
                                          context, RoutesName.interviewText,
                                          arguments: FormatData(
                                              profileId: widget.profileId,
                                              format: 'video',
                                              extension: 'mp4'));
                          }
                        : null,
                    child: const Text("Create Interview")),
              ],
            ),
          )),
    );
  }
}
