import 'package:flutter/material.dart';
import 'package:obujulizi_interview_final/utils/all.dart';
import 'package:obujulizi_interview_final/widgets/all.dart';

class InterviewText extends StatefulWidget {
  final String profileId;
  final String format;
  final String extension;
  const InterviewText(
      {super.key,
      required this.profileId,
      required this.format,
      required this.extension});

  @override
  State<InterviewText> createState() => _InterviewTextState();
}

class _InterviewTextState extends State<InterviewText> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scrollbar(
        thumbVisibility: true,
        thickness: 10,
        child: SingleChildScrollView(
            padding: smallPagePadding,
            child: Column(children: [
              mediumVertical,
              Image.asset("assets/icons/gradient_icon.png"),
              smallVertical,
              const Text("Rose Academies",
                  style: headline1),
                                const Text("Confidentiality Statement",
                  style: headline1),
              extraSmallVertical,
              const Text("Obujulizi Share: Interview App", style: headline2),
              const Text("Effective: December 2, 2022", style: subtitle1),
              mediumVertical,
               const Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      children: [
                        Text(
                            "* read out the statement below to the person you are interviewing", style: bodyText2),
                        smallVertical,
                      ],
                    ),
                  ),
                  mediumVertical,
              const Text(
                  "Hello, my name is _____ and I am a representative of Rose Academies. We are conducting interviews of people like you that have a story to tell about life in Uganda. All our interviews, your name and place where you live are kept confidential and will not be shared with any outside sources. Do I have your permission to videotape your interview? Or, if you do not wish to be photographed, do I have your permission to record your story?",
                  style: bodyText1),
              extraLargeVertical,
              const Text("Thank you for sharing your story with us!",
                  style: headline3),
              smallVertical,
              Row(
                children: [
                  Flexible(
                    child: Checkbox(
                      value: isChecked,
                      onChanged: (value) {
                        setState(() {
                          isChecked = value!;
                        });
                      },
                    ),
                  ),
                  const Flexible(
                      child: Text(
                          "I have completed the statement and will create the interview accordingly")),
                ],
              ),
              smallVertical,
              ElevatedButton(
                  onPressed: isChecked == true
                      ? () {
                          showMediaOptionsDialog(context, widget.profileId);
                        }
                      : null,
                  child: const Text("Continue"))
            ])),
      ),
    );
  }
}
