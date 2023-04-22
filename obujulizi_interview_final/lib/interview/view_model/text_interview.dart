import 'dart:io';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:obujulizi_interview_final/interview/services/interview_functions.dart';
import 'package:obujulizi_interview_final/utils/all.dart';
import 'package:obujulizi_interview_final/widgets/all.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'dart:async';

class TextInterview extends StatefulWidget {
  final String digitalSignatureUrl;
  final String contentUrl;
  const TextInterview(
      {Key? key, required this.digitalSignatureUrl, required this.contentUrl})
      : super(key: key);

  @override
  State<TextInterview> createState() => _TextInterviewState();
}

class _TextInterviewState extends State<TextInterview> {
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;
  XFile? signatureFile;
  String? signatureFilePath;

  final formKey = GlobalKey<FormState>();
  final TextEditingController _textInterviewController =
      TextEditingController();
  File? textFile;

  final InterviewCreation interviewCreation = InterviewCreation();

  void initialUpload() {
    interviewCreation.uploadDigitalSignature(
        context: context,
        signatureFile: signatureFile,
        uploadUrl: widget.digitalSignatureUrl);
    interviewCreation.uploadTextFile(
        context: context, textFile: textFile, uploadUrl: widget.contentUrl);
  }

  void pickSignature() async {
    XFile? file = await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (file != null) {
      setState(() {
        signatureFile = file;
        signatureFilePath = file.path;
        loadVideoPlayer(signatureFilePath);
      });
    }
  }

  void takeSignature() async {
    XFile? file = await ImagePicker().pickVideo(source: ImageSource.camera);
    if (file != null) {
      setState(() {
        signatureFile = file;
        signatureFilePath = file.path;
        loadVideoPlayer(signatureFilePath);
      });
    }
  }

  loadVideoPlayer(String? path) {
    if (_videoPlayerController != null) {
      _videoPlayerController!.dispose();
    }

    _videoPlayerController = VideoPlayerController.file(File(path!));
    _videoPlayerController!.initialize().then((_) {
      setState(() {
        _chewieController = ChewieController(
          videoPlayerController: _videoPlayerController!,
          aspectRatio: 16 / 9,
          looping: false,
          fullScreenByDefault: false,
          errorBuilder: (context, errorMessage) {
            return const Center(
                child: Text("Error: video cannot be played",
                    style: TextStyle(color: white)));
          },
        );
      });
    });
  }

  Future<String> getDirPath() async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  Future<File> interviewFile() async {
    final path = await getDirPath();
    return File('$path/data.txt');
  }

  void writeData() async {
    final file = await interviewFile();
    file.writeAsString(_textInterviewController.text);
    setState(() {
      textFile = file;
    });
  }

  @override
  void dispose() {
    _textInterviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Align(
              alignment: Alignment.centerLeft,
              child: Text("Digital Signature", style: headline2)),
          Padding(
            padding: videoPadding,
            child: (_chewieController != null)
                ? AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Chewie(controller: _chewieController!))
                : Container(
                    color: lightGrey,
                    width: 600,
                    height: 300,
                  ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: PopupMenuButton<VideoOptions>(
                iconSize: 25,
                icon: const Icon(Icons.camera_alt_sharp),
                onSelected: (value) {
                  if (value == VideoOptions.live) {
                    takeSignature();
                  } else if (value == VideoOptions.upload) {
                    pickSignature();
                  }
                },
                itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: VideoOptions.live,
                        child: Text("Live"),
                      ),
                      const PopupMenuItem(
                        value: VideoOptions.upload,
                        child: Text("From Device"),
                      )
                    ]),
          ),
          const Align(
              alignment: Alignment.centerLeft,
              child: Text("Text Interview", style: headline2)),
          smallVertical,
          Form(
              key: formKey,
              child: Column(
                children: [
                  InterviewTextField(
                      controller: _textInterviewController,
                      focusNode: null,
                      nextFocusNode: null,
                      validator: (input) {
                        if (_textInterviewController.text.isWhitespace()) {
                          return "Answers to interview questions required";
                        }
                        return null;
                      }),
                ],
              )),
          Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                  onPressed: writeData, child: const Text("Save"))),
          IconButton(
              iconSize: 75,
              onPressed: () {
                final isValid = formKey.currentState!.validate();
                if (isValid == true) {
                  writeData();
                  initialUpload();
                }
              },
              icon: const Icon(Icons.upload_sharp),
              color: lightGrey),
        ],
      ),
    );
  }
}
