import 'package:flutter/material.dart';
import 'package:obujulizi_interview_final/interview/services/interview_models.dart';
import 'package:obujulizi_interview_final/utils/all.dart';

Future showMediaOptionsDialog(BuildContext context, String profileId) async {
  return await showDialog(
      context: context,
      builder: (context) {
        int? radioValue = 0;
        return StatefulBuilder(
            builder: ((context, setState) => AlertDialog(
                title: const Text('Pick a format'),
                insetPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                content: SizedBox(
                  width: 400,
                  height: 200,
                  child: Column(
                    children: [
                      Row(children: [
                        Radio(
                            value: 1,
                            groupValue: radioValue,
                            onChanged: (value) {
                              setState(() {
                                radioValue = value;
                              });
                            }),
                        smallVertical,
                        const Text("Text"),
                      ]),
                      Row(children: [
                        Radio(
                            value: 2,
                            groupValue: radioValue,
                            onChanged: (value) {
                              setState(() {
                                radioValue = value;
                              });
                            }),
                        smallVertical,
                        const Text("Audio"),
                      ]),
                      Row(children: [
                        Radio(
                            value: 3,
                            groupValue: radioValue,
                            onChanged: (value) {
                              setState(() {
                                radioValue = value;
                              });
                            }),
                        smallVertical,
                        const Text("Video"),
                      ]),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: ElevatedButton(
                            onPressed: radioValue != 0
                                ? () {
                                    if (radioValue == 1) {
                                      Navigator.pushNamed(
                                          context, RoutesName.createInterview,
                                          arguments: FormatData(
                                              profileId: profileId,
                                              format: 'text',
                                              extension: 'txt'));
                                    } else if (radioValue == 2) {
                                      Navigator.pushNamed(
                                          context, RoutesName.createInterview,
                                          arguments: FormatData(
                                              profileId: profileId,
                                              format: 'audio',
                                              extension: 'm4a'));
                                    } else {
                                      Navigator.pushNamed(
                                          context, RoutesName.createInterview,
                                          arguments: FormatData(
                                              profileId: profileId,
                                              format: 'video',
                                              extension: 'mp4'));
                                    }
                                  }
                                : null,
                            child: const Text('Continue')),
                      )
                    ],
                  ),
                ))));
      });
}
