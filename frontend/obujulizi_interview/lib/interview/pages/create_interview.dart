import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:obujulizi_interview_final/interview/all.dart';
import 'package:obujulizi_interview_final/utils/all.dart';
import 'package:obujulizi_interview_final/widgets/all.dart';

class CreateInterviewPage extends StatefulWidget {
  final String profileId;
  final String format;
  final String extension;
  const CreateInterviewPage(
      {super.key,
      required this.profileId,
      required this.format,
      required this.extension});

  @override
  State<CreateInterviewPage> createState() => CreateInterviewPageState();
}

class CreateInterviewPageState extends State<CreateInterviewPage>
    with AfterLayoutMixin<CreateInterviewPage> {
  bool isChecked = false;
  final formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final titleFocus = FocusNode();
  final descriptionFocus = FocusNode();

  final InterviewCreation interviewCreation = InterviewCreation();

  String? contentKey;
  String? signatureKey;

  void finalUpload() {
    interviewCreation.createInterview(
        context: context,
        profileId: widget.profileId,
        format: widget.format,
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        signatureKey: signatureKey,
        contentKey: contentKey,
        isAnonymous: isChecked);
  }

  Future<UploadInfo> getUploadInfo() async {
    UploadInfo info = await interviewCreation.getUrlsAndKeys(
        context: context,
        profileId: widget.profileId,
        interviewContentType: widget.format,
        interviewFileFormat: widget.extension,
        digitalSignatureFileFormat: 'mp4');
    return info;
  }

  @override
  void afterFirstLayout(BuildContext context) {}

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    titleFocus.dispose();
    descriptionFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future<UploadInfo> uploadInfo = getUploadInfo();
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
                          nextFocusNode: null,
                          validator: (input) {
                            if (_descriptionController.text.isWhitespace()) {
                              return "A detailed description is required";
                            }
                            return null;
                          }),
                      smallVertical,
                      FutureBuilder<UploadInfo>(
                          future: uploadInfo,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              final info = snapshot.data!;
                              contentKey = info.interviewFileKey;
                              signatureKey = info.digitalSignatureFileKey;
                              return interviewCondition(
                                  widget.format,
                                  info.digitalSignatureSignedURL,
                                  info.interviewSignedURL);
                            } else {
                              return const MyProgressIndicator();
                            }
                          }),
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

  Widget interviewCondition(
      String format, String digitalSignatureUrl, String contentUrl) {
    Widget widget;

    switch (format) {
      case 'audio':
        widget = AudioInterview(
            digitalSignatureUrl: digitalSignatureUrl, contentUrl: contentUrl);
        break;
      case 'text':
        widget = TextInterview(
            digitalSignatureUrl: digitalSignatureUrl, contentUrl: contentUrl);
        break;
      case 'video':
        widget = VideoInterview(
            digitalSignatureUrl: digitalSignatureUrl, contentUrl: contentUrl);
        break;
      default:
        widget = Container();
    }
    return widget;
  }
}
