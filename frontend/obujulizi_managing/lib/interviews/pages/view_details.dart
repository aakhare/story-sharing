import 'package:flutter/material.dart';
import 'package:obujulizi_managing/interviews/all.dart';
import 'package:obujulizi_managing/utils/all.dart';
import 'package:obujulizi_managing/widgets/buttons/back_button.dart';

class ViewInterviewDetailsPage extends StatefulWidget {
  final String profileId;
  final String interviewId;
  const ViewInterviewDetailsPage(
      {super.key, required this.profileId, required this.interviewId});

  @override
  State<ViewInterviewDetailsPage> createState() =>
      ViewInterviewDetailsPageState();
}

class ViewInterviewDetailsPageState extends State<ViewInterviewDetailsPage> {
  final InterviewCreation interviewCreation = InterviewCreation();

  Future<Profile> getProfile() async {
    Profile profile = await interviewCreation.getProfileDetails(
        context: context,
        profileId: widget.profileId,
        interviewId: widget.interviewId);
    return profile;
  }

  Future<InterviewStuff> getInterview() async {
    InterviewStuff interviewStuff = await interviewCreation.getInterviewDetails(
        context: context,
        profileId: widget.profileId,
        interviewId: widget.interviewId);
    return interviewStuff;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    var headerSpacing = SizedBox(width: screenWidth * 0.05);
    var spacing = SizedBox(width: screenWidth * 0.0225);
    Future<Profile> profileDetails = getProfile();
    Future<InterviewStuff> interviewDetails = getInterview();
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(children: [
        largeVertical,
        Row(
          children: [
            spacing,
            const MyBackButton(),
          ],
        ),
        smallVertical,
        Row(
          children: [
            headerSpacing,
            const Text("Profile Details", style: headline2),
          ],
        ),
        smallVertical,
        FutureBuilder<Profile>(
            future: profileDetails,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final profile = snapshot.data!;
                return profileData(profile);
              } else {
                return const Text('No Data');
              }
            }),
        largeVertical,
        Row(
          children: [
            headerSpacing,
            const Text("Interview Details", style: headline2),
          ],
        ),
        smallVertical,
        FutureBuilder<InterviewStuff>(
            future: interviewDetails,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final interview = snapshot.data!;
                return interviewData(
                    interview, widget.interviewId, widget.profileId);
              } else {
                return const Text('No Data');
              }
            }),
        mediumVertical,
      ]),
    ));
  }

  Widget profileData(Profile profile) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth * 0.90,
      decoration: BoxDecoration(color: white, boxShadow: kElevationToShadow[4]),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Row(
            children: [
              const Text("Name: ", style: headline3),
              Text(profile.name, style: bodyText3),
            ],
          ),
          smallVertical,
          Row(
            children: [
              const Text("Contact Information: ", style: headline3),
              Text(profile.contactInfo, style: bodyText3),
            ],
          )
        ]),
      ),
    );
  }

  Widget interviewData(
      InterviewStuff interview, String interviewId, String profileId) {
    double screenWidth = MediaQuery.of(context).size.width;
    var headerSpacing = SizedBox(width: screenWidth * 0.05);
    double screenHeight = MediaQuery.of(context).size.height;
    String format = interview.format;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        children: [
          Row(
            children: [
              headerSpacing,
              Text(interview.title, style: headline1),
            ],
          ),
          (interview.isAnonymous == true) ? anonymousWidget() : Container(),
        ],
      ),
      smallVertical,
      Row(children: [
        headerSpacing,
        SizedBox(
          width: screenWidth * 0.45,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("Format: $format", style: headline3),
            smallVertical,
            interviewCondition(format, interview),
            mediumVertical,
            const Text("Description", style: headline3),
            smallVertical,
            Container(
              width: screenWidth * 0.45,
              height: screenHeight * 0.35,
              decoration:
                  BoxDecoration(color: white, boxShadow: kElevationToShadow[4]),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(interview.description, style: bodyText2),
                ),
              ),
            )
          ]),
        ),
        headerSpacing,
        headerSpacing,
        SizedBox(
          width: screenWidth * 0.45,
          child: Column(
            children: [
              largeVertical,
              const Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Choose Status", style: headline3)),
              smallVertical,
              RadioButtonWidget(
                  isFlagged: interview.flagged,
                  status: interview.status,
                  interviewId: interviewId,
                  profileId: profileId)
            ],
          ),
        )
      ])
    ]);
  }

  Widget anonymousWidget() {
    return Row(children: [
      mediumHorizontal,
      const Icon(Icons.warning_sharp, color: yellow, size: 50),
      smallHorizontal,
      Container(
          padding: const EdgeInsets.all(8.0),
          decoration: const BoxDecoration(
              color: yellow,
              borderRadius: BorderRadius.all(Radius.circular(2.50))),
          child: const Align(
              alignment: Alignment.center,
              child: Text("This interview is anonymous", style: otherBody)))
    ]);
  }

  Widget interviewCondition(String format, InterviewStuff interviewStuff) {
    Widget widget;

    switch (format) {
      case 'audio':
        widget = AudioInterview(surl: interviewStuff.content);
        break;
      case 'text':
        widget = TextInterview(text: interviewStuff.content);
        break;
      case 'video':
        widget = VideoInterview(surl: interviewStuff.content);
        break;
      default:
        widget = Container();
    }
    return widget;
  }
}

class RadioButtonWidget extends StatefulWidget {
  final bool isFlagged;
  final String status;
  final String interviewId;
  final String profileId;
  const RadioButtonWidget(
      {super.key,
      required this.isFlagged,
      required this.status,
      required this.interviewId,
      required this.profileId});

  @override
  State<RadioButtonWidget> createState() => _RadioButtonWidgetState();
}

class _RadioButtonWidgetState extends State<RadioButtonWidget> {
  int? radioValue = 0;
  bool? isChecked = false;
  String status = '';
  bool flagged = false;
  bool approved = false;
  InterviewCreation interviewCreation = InterviewCreation();

  void updateStatus(String status) async {
    interviewCreation.updateInterviewStatus(
        context: context, interviewId: widget.interviewId, status: status);
  }

  void updateFlag(bool? flag) async {
    interviewCreation.updateInterviewFlag(
        context: context, interviewId: widget.interviewId, flag: flag);
  }

  @override
  void initState() {
    if (widget.status == 'APPROVED') {
      setState(() {
        radioValue = 1;
        approved = true;
      });
    } else if (widget.status == 'LAID ASIDE') {
      setState(() {
        radioValue = 2;
      });
    } else if (widget.status == 'PENDING') {
      setState(() {
        radioValue = 3;
      });
    } else if (widget.status == 'DENIED') {
      setState(() {
        radioValue = 4;
      });
    }

    if (widget.isFlagged == true) {
      setState(() {
        isChecked = true;
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
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
        const Text("Approve"),
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
        const Text("Lay Aside"),
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
        const Text("Pending"),
      ]),
      Row(children: [
        Radio(
            value: 4,
            groupValue: radioValue,
            onChanged: (value) {
              setState(() {
                radioValue = value;
              });
            }),
        smallVertical,
        const Text("Deny"),
      ]),
      smallVertical,
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
          const Flexible(child: Text("Flag as important")),
        ],
      ),
      largeVertical,
      Align(
        alignment: Alignment.centerLeft,
        child: FloatingActionButton.extended(
          backgroundColor: purple,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
              side: const BorderSide(width: 2, color: purple)),
          onPressed: () {
            if (radioValue == 1) {
              status = 'APPROVED';
            } else if (radioValue == 2) {
              status = 'LAID ASIDE';
            } else if (radioValue == 3) {
              status = 'PENDING';
            } else if (radioValue == 4) {
              status = 'DENIED';
            }
            updateStatus(status);
            updateFlag(isChecked);
          },
          label: const Text("Save"),
        ),
      ),
      smallVertical,
      Row(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: ElevatedButton(
              onPressed: radioValue == 1 ? () {
                if (radioValue == 1) {
                  Navigator.pushNamed(context, RoutesName.createStory,
                      arguments: IdInfo(
                          profileId: widget.profileId,
                          interviewId: widget.interviewId));
                }
              } : null,
              child: const Text("Create a Story"),
            ),
          ),
        ],
      ),
    ]);
  }
}
