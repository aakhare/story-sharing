import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:obujulizi_interview_final/services/all.dart';
import 'package:obujulizi_interview_final/utils/all.dart';
import 'dart:io';
import 'package:video_player/video_player.dart';

enum InterviewVideoOptions {
  live,
  upload,
}

class InterviewPlayer extends StatefulWidget {
  const InterviewPlayer({
    Key? key,
  }) : super(key: key);

  @override
  InterviewPlayerState createState() => InterviewPlayerState();
}

class InterviewPlayerState extends State<InterviewPlayer> {
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;
  XFile? finalFile;
  String? interviewFilePath;

  final InterviewCreation interviewCreation = InterviewCreation();

  @override
  void dispose() {
    super.dispose();
    _chewieController?.dispose();
  }

  void initialUpload() {
    interviewCreation.uploadInterviewFile(
        context: context, interviewFile: finalFile);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
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
        alignment: Alignment.bottomRight,
        child: PopupMenuButton<InterviewVideoOptions>(
            icon: const Icon(Icons.camera_alt_sharp),
            onSelected: (value) {
              if (value == InterviewVideoOptions.live) {
                takeInterview();
              } else if (value == InterviewVideoOptions.upload) {
                pickInterview();
              }
            },
            itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: InterviewVideoOptions.live,
                    child: Text("Live"),
                  ),
                  const PopupMenuItem(
                    value: InterviewVideoOptions.upload,
                    child: Text("From Device"),
                  )
                ]),
      ),
      ElevatedButton(
          onPressed: () {
            initialUpload();
          },
          child: const Text('Upload Media')),
    ]);
  }

  void pickInterview() async {
    XFile? file = await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (file != null) {
      setState(() {
        interviewFilePath = file.path;
        loadVideoPlayer(interviewFilePath);
        setFile(file);
      });
    }
  }

  void takeInterview() async {
    XFile? file = await ImagePicker().pickVideo(source: ImageSource.camera);
    if (file != null) {
      setState(() {
        interviewFilePath = file.path;
        loadVideoPlayer(interviewFilePath);
        setFile(file);
      });
    }
  }

  void setFile(XFile file) {
    setState(() {
      finalFile = file;
    });
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
}
