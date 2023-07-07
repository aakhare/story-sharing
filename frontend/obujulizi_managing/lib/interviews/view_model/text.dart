import 'dart:developer';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:obujulizi_managing/interviews/services/interview_functions.dart';
import 'package:obujulizi_managing/utils/all.dart';

class TextInterview extends StatefulWidget {
  final String text;
  const TextInterview({super.key, required this.text});

  @override
  State<TextInterview> createState() => _TextInterviewState();
}

class _TextInterviewState extends State<TextInterview> {
  final InterviewCreation interviewCreation = InterviewCreation();

  // Future<String> getTextFile() async {
  //   String text = await interviewCreation.getTextFile(key: widget.text, context: context);
  //   return text;
  // }

  Future<void> download() async {
    String path = await FileSaver.instance.saveFile(
        name: "text_interview",
        link: LinkDetails(link:'https://testbucket63419.s3.us-west-1.amazonaws.com/${widget.text}'),
        ext: "txt",
        mimeType: MimeType.text);
    log(path);
  }

  @override
  initState() {
    // download();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Future<String> text = getTextFile();
    return Row(
      children: [
        FloatingActionButton.extended(
            onPressed: () {
              download();
            },
            icon: const Icon(Icons.download_sharp, size: 42),
            label: const Text("Download content")),
      ],
    );
    // Scrollbar(
    //   child: SingleChildScrollView(
    //     child: Column(
    //       children: [
    //         FutureBuilder<String>(
    //             future: text,
    //             builder: (context, snapshot) {
    //               if (snapshot.hasData) {
    //                 // final contents = snapshot.data!;/
    //                 return Row(
    //                   children: [
    //                     FloatingActionButton.extended(
    //                       onPressed: () {
    //                         download();
    //                       },
    //                       icon: const Icon(Icons.download_sharp, size: 42),
    //                     label: const Text("Download content")
    //                     ),
    //                   ],
    //                 );
    //                 //textInput(contents);
    //               } else {
    //                 return const Text("No Data");
    //               }
    //             }),
    //       ],
    //     ),
    //   ),
    // );
  }

  Widget textInput(String text) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: screenWidth * 0.45,
      height: screenHeight * 0.35,
      decoration: BoxDecoration(color: white, boxShadow: kElevationToShadow[4]),
      child: TextFormField(enabled: true, initialValue: text, style: bodyText2),
    );
  }
}
