import 'dart:io';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:obujulizi_interview/utils/all.dart';
import 'package:video_player/video_player.dart';

enum VideoOptions {
  live,
  upload,
}

class ChewieListItem extends StatefulWidget {
  const ChewieListItem({
    Key? key,
  }) : super(key: key);

  @override
  ChewieListItemState createState() => ChewieListItemState();
}

class ChewieListItemState extends State<ChewieListItem> {
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;
  String? video;

  @override
  void dispose() {
    super.dispose();
    _chewieController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: videoPadding,
        child: (_chewieController != null)
            ? AspectRatio(
                aspectRatio: 16 / 9, child: Chewie(controller: _chewieController!))
            : Container(
                color: lightGrey,
                width: 600,
                height: 300,
              ),
      ),
      Align(
        alignment: Alignment.bottomRight,
        child: PopupMenuButton<VideoOptions>(
            icon: const Icon(Icons.camera_alt_sharp),
            onSelected: (value) {
              if (value == VideoOptions.live) {
                takeSignature();
              } else if (value == VideoOptions.upload) {
                getSignature();
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
      )
    ]);
  }

  void getSignature() async {
    XFile? file = await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (file != null) {
      setState(() {
        video = file.path;
        _videoPlayerController = VideoPlayerController.file(File(video!));
        loadVideoPlayer(video);
      });
    }
  }

  void takeSignature() async {
    XFile? file = await ImagePicker().pickVideo(source: ImageSource.camera);
    if (file != null) {
      setState(() {
        video = file.path;
        loadVideoPlayer(video);
      });
    }
  }

  loadVideoPlayer(String? file) {
    if (_videoPlayerController != null) {
      _videoPlayerController!.dispose();
    }

    _videoPlayerController = VideoPlayerController.file(File(video!));
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
