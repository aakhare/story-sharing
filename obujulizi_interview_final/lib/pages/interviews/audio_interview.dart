import 'package:flutter/material.dart';
import 'package:obujulizi_interview_final/services/all.dart';
import 'package:obujulizi_interview_final/utils/all.dart';
import 'package:obujulizi_interview_final/widgets/all.dart';

class CreateAudioInterviewPage extends StatefulWidget {
  final String profileId;
  const CreateAudioInterviewPage({super.key, required this.profileId});

  @override
  State<CreateAudioInterviewPage> createState() =>
      CreateAudioInterviewPageState();
}

class CreateAudioInterviewPageState extends State<CreateAudioInterviewPage> {
  bool isChecked = false;
  final formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _textController = TextEditingController();

  final titleFocus = FocusNode();
  final descriptionFocus = FocusNode();
  final textFocus = FocusNode();

  final InterviewCreation interviewCreation = InterviewCreation();

  void getUrls() {
    interviewCreation.getUrls(
        context: context,
        profileId: widget.profileId,
        interviewContentType: 'audio',
        interviewFileFormat: 'mp3',
        digitalSignatureFileFormat: 'mp4');
  }

  @override
  void initState() {
    getUrls();
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _textController.dispose();
    titleFocus.dispose();
    descriptionFocus.dispose();
    textFocus.dispose();
    super.dispose();
  }

  void finalUpload() {
    interviewCreation.createInterview(
        context: context,
        profileId: widget.profileId,
        format: 'audio',
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        isAnonymous: isChecked);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scrollbar(
        thumbVisibility: true,
        thickness: 10,
        child: SingleChildScrollView(
            padding: pagePadding,
            child: Column(children: [
              extraLargeVertical,
              const Text("Enter all Interview information below",
                  style: headline1),
              smallVertical,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Flexible(
                    child: Text("Follow the guide:", style: headline3),
                  ),
                  Flexible(
                    child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, RoutesName.questionsGuide);
                        },
                        child: const Text("View Guide")),
                  ),
                ],
              ),
              extraLargeVertical,
              const Align(
                alignment: Alignment.centerLeft,
                child: Text("New Interview", style: display),
              ),
              const Divider(color: black),
              mediumVertical,
              Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TitleField(
                        controller: _titleController,
                        focusNode: titleFocus,
                        nextFocusNode: descriptionFocus,
                        validator: (input) {
                          if (_titleController.text.isWhitespace()) {
                            return "Title is required";
                          }
                          return null;
                        },
                      ),
                      smallVertical,
                      MultiLineField(
                          controller: _descriptionController,
                          focusNode: descriptionFocus,
                          nextFocusNode: textFocus,
                          validator: (input) {
                            if (_descriptionController.text.isWhitespace()) {
                              return "A detailed description is required";
                            }
                            return null;
                          }),
                      smallVertical,
                      const Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Digital Signature", style: headline2)),
                      const SignaturePlayer(),
                      const Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Audio Interview", style: headline2)),
                      const AudioSlider(),
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
                                  "I want this interview to be anonymous")),
                        ],
                      ),
                    ],
                  )),
              mediumVertical,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: FloatingActionButton.extended(
                      onPressed: () {
                        final isValid = formKey.currentState!.validate();
                        if (isValid == true) {
                          finalUpload();
                        }
                      },
                      label: const Text("Done"),
                    ),
                  ),
                ],
              ),
            ])),
      ),
    );
  }
}
