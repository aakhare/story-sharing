import 'dart:io';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:obujulizi_interview_final/interview/services/interview_functions.dart';
import 'package:obujulizi_interview_final/utils/all.dart';
import 'package:video_player/video_player.dart';

class VideoInterview extends StatefulWidget {
  final String digitalSignatureUrl;
  final String contentUrl;
  const VideoInterview(
      {Key? key, required this.digitalSignatureUrl, required this.contentUrl})
      : super(key: key);

  @override
  State<VideoInterview> createState() => _VideoInterviewState();
}

class _VideoInterviewState extends State<VideoInterview> {
  VideoPlayerController? _signaturePlayerController;
  ChewieController? _signatureChewieController;
  XFile? signatureFile;
  String? signatureFilePath;

  VideoPlayerController? _contentPlayerController;
  ChewieController? _contentChewieController;
  XFile? videoFile;
  String? videoFilePath;

  final InterviewCreation interviewCreation = InterviewCreation();

  void initialUpload() {
    interviewCreation.uploadDigitalSignature(
        context: context,
        signatureFile: signatureFile,
        uploadUrl: widget.digitalSignatureUrl);
    interviewCreation.uploadVideoFile(
        context: context, videoFile: videoFile, uploadUrl: widget.contentUrl);
  }

  void pickSignature() async {
    XFile? file = await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (file != null) {
      setState(() {
        signatureFile = file;
        signatureFilePath = file.path;
        loadSignaturePlayer(signatureFilePath);
      });
    }
  }

  void takeSignature() async {
    XFile? file = await ImagePicker().pickVideo(source: ImageSource.camera);
    if (file != null) {
      setState(() {
        signatureFile = file;
        signatureFilePath = file.path;
        loadSignaturePlayer(signatureFilePath);
      });
    }
  }

  loadSignaturePlayer(String? path) {
    if (_signaturePlayerController != null) {
      _signaturePlayerController!.dispose();
    }

    _signaturePlayerController = VideoPlayerController.file(File(path!));
    _signaturePlayerController!.initialize().then((_) {
      setState(() {
        _signatureChewieController = ChewieController(
          videoPlayerController: _signaturePlayerController!,
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

  void pickContent() async {
    XFile? file = await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (file != null) {
      setState(() {
        videoFile = file;
        videoFilePath = file.path;
        loadVideoPlayer(videoFilePath);
      });
    }
  }

  void takeContent() async {
    XFile? file = await ImagePicker().pickVideo(source: ImageSource.camera);
    if (file != null) {
      setState(() {
        videoFile = file;
        videoFilePath = file.path;
        loadVideoPlayer(videoFilePath);
      });
    }
  }

  loadVideoPlayer(String? path) {
    if (_contentPlayerController != null) {
      _contentPlayerController!.dispose();
    }

    _contentPlayerController = VideoPlayerController.file(File(path!));
    _contentPlayerController!.initialize().then((_) {
      setState(() {
        _contentChewieController = ChewieController(
          videoPlayerController: _contentPlayerController!,
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

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(children: [
      const Align(
          alignment: Alignment.centerLeft,
          child: Text("Digital Signature", style: headline2)),
      Padding(
        padding: videoPadding,
        child: (_signatureChewieController != null)
            ? AspectRatio(
                aspectRatio: 16 / 9,
                child: Chewie(controller: _signatureChewieController!))
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
          child: Text("Video Interview", style: headline2)),
      Padding(
        padding: videoPadding,
        child: (_contentChewieController != null)
            ? AspectRatio(
                aspectRatio: 16 / 9,
                child: Chewie(controller: _contentChewieController!))
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
                takeContent();
              } else if (value == VideoOptions.upload) {
                pickContent();
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
      IconButton(
        iconSize: 75,
          onPressed: () {
            initialUpload();
          },
          icon: const Icon(Icons.upload_sharp),
          color: lightGrey),
    ]));
  }
}
