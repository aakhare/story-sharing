import 'dart:developer';
import 'package:chewie/chewie.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:obujulizi_managing/interviews/services/interview_functions.dart';
import 'package:obujulizi_managing/utils/all.dart';
// ignore: depend_on_referenced_packages
import 'package:video_player/video_player.dart';

class VideoInterview extends StatefulWidget {
  final String surl;
  const VideoInterview({Key? key, required this.surl}) : super(key: key);

  @override
  State<VideoInterview> createState() => _VideoInterviewState();
}

class _VideoInterviewState extends State<VideoInterview> {
  // VideoPlayerController? _signaturePlayerController;
  // ChewieController? _signatureChewieController;

  VideoPlayerController? _contentPlayerController;
  // ignore: unused_field
  ChewieController? _contentChewieController;

  InterviewCreation interviewCreation = InterviewCreation();
  Future<void> download() async {
    String path = await FileSaver.instance.saveFile(
        name: "video_interview",
        link: LinkDetails(link: 'https://testbucket63419.s3.us-west-1.amazonaws.com/${widget.surl}'),
        ext: "mp4",
        mimeType: MimeType.mp4);
    log(path);
  }

  @override
  void initState() {
    // download();
    super.initState();
  }

  void loadVideoPlayer(String path) {
    if (_contentPlayerController != null) {
      _contentPlayerController!.dispose();
    }
    _contentPlayerController = VideoPlayerController.network(path);
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
    // Column(children: [
    //   const Align(
    //       alignment: Alignment.centerLeft,
    //       child: Text("Video Interview", style: headline2)),
    //   Padding(
    //     padding: videoPadding,
    //     child: (_contentChewieController != null)
    //         ? AspectRatio(
    //             aspectRatio: 16 / 9,
    //             child: Chewie(controller: _contentChewieController!))
    //         : Container(
    //             color: lightGrey,
    //             width: 600,
    //             height: 300,
    //           ),
    //   ),
    // ]);
  }
}
