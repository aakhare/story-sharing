import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:obujulizi_interview_final/services/all.dart';
import 'package:obujulizi_interview_final/utils/all.dart';
import 'dart:io';
import 'package:video_player/video_player.dart';

enum SignatureVideoOptions {
  live,
  upload,
}

class SignaturePlayer extends StatefulWidget {
  const SignaturePlayer({
    Key? key,
  }) : super(key: key);

  @override
  SignaturePlayerState createState() => SignaturePlayerState();
}

class SignaturePlayerState extends State<SignaturePlayer> {
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;
  XFile? finalFile;
  String? signatureFilePath;

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
        child: PopupMenuButton<SignatureVideoOptions>(
            icon: const Icon(Icons.camera_alt_sharp),
            onSelected: (value) {
              if (value == SignatureVideoOptions.live) {
                takeSignature();
              } else if (value == SignatureVideoOptions.upload) {
                pickSignature();
              }
            },
            itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: SignatureVideoOptions.live,
                    child: Text("Live"),
                  ),
                  const PopupMenuItem(
                    value: SignatureVideoOptions.upload,
                    child: Text("From Device"),
                  )
                ]),
      )
    ]);
  }

  void pickSignature() async {
    XFile? file = await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (file != null) {
      setState(() {
        signatureFilePath = file.path;
        loadVideoPlayer(signatureFilePath);
        setFile(file);
      });
    }
  }

  void takeSignature() async {
    XFile? file = await ImagePicker().pickVideo(source: ImageSource.camera);
    if (file != null) {
      setState(() {
        signatureFilePath = file.path;
        loadVideoPlayer(signatureFilePath);
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
