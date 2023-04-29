import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:obujulizi_managing/interviews/services/interview_functions.dart';
import 'package:obujulizi_managing/utils/all.dart';
import 'package:path_provider/path_provider.dart';

class TextInterview extends StatefulWidget {
  final String text;
  const TextInterview({super.key, required this.text});

  @override
  State<TextInterview> createState() => _TextInterviewState();
}

class _TextInterviewState extends State<TextInterview> {
  final InterviewCreation interviewCreation = InterviewCreation();

  Future<String> getTextFile() async {
    String text = await interviewCreation.getTextFile(key: widget.text);
    return text;
  }

  Future<void> download() async {
    String path = await FileSaver.instance.saveFile(
        name: "text_interview",
        link:
            "https://testbucket63419.s3.us-west-1.amazonaws.com/${widget.text}",
        ext: "txt",
        mimeType: MimeType.text);
    log(path);
  }

  @override
  initState() {
    download();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<String> text = getTextFile();
    return Scrollbar(
      child: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<String>(
                future: text,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final contents = snapshot.data!;
                    return textInput(contents);
                  } else {
                    return const Text("No Data");
                  }
                }),
          ],
        ),
      ),
    );
  }

  Widget textInput(String text) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    print(text);
    return Container(
      width: screenWidth * 0.45,
      height: screenHeight * 0.35,
      decoration: BoxDecoration(color: white, boxShadow: kElevationToShadow[4]),
      child: TextFormField(enabled: true, initialValue: text, style: bodyText2),
    );
  }
}
