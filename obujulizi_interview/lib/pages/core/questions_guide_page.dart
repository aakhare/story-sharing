import 'package:flutter/material.dart';
import 'package:obujulizi_interview/utils/all.dart';
import 'package:obujulizi_interview/widgets/all.dart';

class QuestionsGuidePage extends StatefulWidget {
  const QuestionsGuidePage({super.key});

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
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Flexible(
                      child: IconButton(
                          icon: const Icon(Icons.arrow_back_ios),
                          onPressed: () {
                            Navigator.pop(context);
                          })),
                ]),
                mediumVertical,
                Image.asset("assets/icons/gradient_icon.png"),
                smallVertical,
                const Text("Rose Academies Interview Guide", style: headline1),
                extraSmallVertical,
                const Text("Obujulizi Share: Interview App", style: headline2),
                mediumVertical,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Questionare for Adults", style: headline2), smallVertical,
                    Text("1. What is your name?", style: bodyText2), extraSmallVertical,
                    Text("2. How old are you?", style: bodyText2), extraSmallVertical,
                    Text("3. Are you married?", style: bodyText2), extraSmallVertical,
                    Text("   a. If yes, how old were you when you married?",
                        style: bodyText2), extraSmallVertical,
                    Text(
                        "   b. If yes, do you have regrets for marrying when you did?",
                        style: bodyText2), extraSmallVertical,
                    Text("4. Do you have children?", style: bodyText2), extraSmallVertical,
                    Text(
                        "   a. How old were you when you first got pregnant (if a woman)?",
                        style: bodyText2), extraSmallVertical,
                    Text(
                        "   b. How old were you when you first had a child (if a man)?",
                        style: bodyText2), extraSmallVertical,
                    Text("5. How many children do you have?",
                        style: bodyText2), extraSmallVertical,
                    Text("6. Did you ever suffer the loss of a child?",
                        style: bodyText2), extraSmallVertical,
                    Text("   a. If yes, what happened?", style: bodyText2), extraSmallVertical,
                    Text(
                        "7. Would you say that life has been difficult for you and your family?  Why?",
                        style: bodyText2), extraSmallVertical,
                    Text(
                        "8. Have you ever suffered from violence? What happened? Do you have any lasting effects? What?",
                        style: bodyText2), extraSmallVertical,
                    Text(
                        "9. Do you feel that women deserve to be beaten if they don't please their husband? Why or why not?",
                        style: bodyText2), extraSmallVertical,
                    Text(
                        "10. Are you or anyone in your family disabled? If yes, what type of disability?",
                        style: bodyText2), extraSmallVertical,
                    Text(
                        "   a. If yes, what has been the most difficult thing about being disabled (for you or your family member)?",
                        style: bodyText2), extraSmallVertical,
                    Text(
                        "11.	What has been the hardest thing you have ever had to do in your life? Why was it hard?",
                        style: bodyText2), extraSmallVertical,
                    Text("Questionare for Youth", style: headline2), smallVertical,
                    Text("1. What is your name?", style: bodyText2), extraSmallVertical,
                    Text("2. How old are you?", style: bodyText2), extraSmallVertical,
                    Text("3. How many children are in your family?",
                        style: bodyText2), extraSmallVertical,
                    Text("4. Are you the oldest, youngest, or in between?",
                        style: bodyText2), extraSmallVertical,
                    Text(
                        "5. Would you say that life has been difficult for you and your family?  Why?",
                        style: bodyText2), extraSmallVertical,
                    Text(
                        "6. Have you ever suffered from violence? What happened? Do you have any lasting effects? What?",
                        style: bodyText2), extraSmallVertical,
                    Text(
                        "7. Are you or anyone in your family disabled? If yes, what type of disability?",
                        style: bodyText2), extraSmallVertical,
                    Text(
                        "   a. If yes, what has been the most difficult thing about being disabled (for you or your family member)?",
                        style: bodyText2), extraSmallVertical,
                    Text(
                        "8. What has been the hardest thing you have ever had to do in your life? Why was it hard?",
                        style: bodyText2), extraSmallVertical,
                    Text(
                        "9.	What would you like to do if you had the opportunity?",
                        style: bodyText2),extraSmallVertical,
                    Text("Questionare for the Disabled", style: headline2), smallVertical,
                    Text("1. What is your name?", style: bodyText2), extraSmallVertical,
                    Text("2. How old are you?", style: bodyText2), extraSmallVertical,
                    Text(
                        "3. What has been the most difficult thing about being disabled (for you or your family member)?",
                        style: bodyText2) ,extraSmallVertical,
                    Text("4. Are you married?", style: bodyText2), extraSmallVertical,
                    Text("   a. If yes, how old were you when you married?",
                        style: bodyText2), extraSmallVertical,
                    Text("5. Do you have children?", style: bodyText2), extraSmallVertical,
                    Text(
                        "   a. How old were you when you first got pregnant (if a woman)?",
                        style: bodyText2), extraSmallVertical,
                    Text(
                        "   b. How old were you when you first had a child (if a man)?",
                        style: bodyText2), extraSmallVertical,
                    Text("6. Did you ever suffer the loss of a child?",
                        style: bodyText2),extraSmallVertical,
                    Text("   a. If yes, what happened?", style: bodyText2), extraSmallVertical,
                    Text(
                        "7. Have you ever suffered from violence? What happened? Do you have any lasting effects? What are they",
                        style: bodyText2), extraSmallVertical,
                    Text(
                        "8. What has been the hardest thing you have ever had to do in your life? Why was it hard?",
                        style: bodyText2), extraSmallVertical,
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
                            await showMediaOptionsDialog(context);
                          }
                        : null,
                    child: const Text("Create Interview")),
              ],
            ),
          )),
    );
  }
}