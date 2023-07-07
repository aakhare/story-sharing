import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:obujulizi_managing/interviews/services/interview_functions.dart';
// import 'package:rxdart/rxdart.dart';
// import 'package:obujulizi_managing/utils/all.dart';
// import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';

class PositionData {
  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;

  const PositionData(
    this.position,
    this.bufferedPosition,
    this.duration,
  );
}

class AudioInterview extends StatefulWidget {
  final String surl;
  const AudioInterview({
    Key? key,
    required this.surl,
  }) : super(key: key);

  @override
  State<AudioInterview> createState() => AudioInterviewState();
}

class AudioInterviewState extends State<AudioInterview> {
  String? signatureFilePath;
  final _audioPlayer = AudioPlayer();

  File? audioFile;

  bool isRecorderReady = false;
  int sec = 0;
  int min = 0;
  int hours = 0;

  String digitSec = '00';
  String digitMin = '00';
  String digitHours = '00';

  Timer? timer;
  bool started = false;

  final InterviewCreation interviewCreation = InterviewCreation();

  void stopTimer() {
    timer!.cancel();
    setState(() {
      started = false;
    });
  }

  void resetTimer() {
    timer!.cancel();
    setState(() {
      sec = 0;
      min = 0;
      hours = 0;

      digitSec = '00';
      digitMin = '00';
      digitHours = '00';

      started = false;
    });
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      int localSec = sec + 1;
      int localMin = min;
      int localHours = hours;

      if (localSec > 59) {
        if (localMin > 59) {
          localHours++;
          localMin = 0;
        } else {
          localMin++;
          localSec = 0;
        }
      }

      setState(() {
        started = true;
        sec = localSec;
        min = localMin;
        hours = localHours;
        digitSec = (sec >= 10) ? '$sec' : '0$sec';
        digitMin = (min >= 10) ? '$min' : '0$min';
        digitHours = (hours >= 10) ? '$hours' : '0$hours';
      });
    });
  }

  // Stream<PositionData> get _positionDataStream =>
  //     Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
  //         _audioPlayer.positionStream,
  //         _audioPlayer.bufferedPositionStream,
  //         _audioPlayer.durationStream,
  //         (position, bufferedPosition, duration) => PositionData(
  //             position, bufferedPosition, duration ?? Duration.zero));

  Future<void> download() async {
    String path = await FileSaver.instance.saveFile(
        name: "audio_interview",
        link: LinkDetails(link: 'https://testbucket63419.s3.us-west-1.amazonaws.com/${widget.surl}'),
        ext: "mp3",
        mimeType: MimeType.mp3);
    log(path);
  }

  @override
  void initState() {
    // download();
    super.initState();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    isRecorderReady = false;
    super.dispose();
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
    //   extraLargeVertical,
    //   Text("$digitHours:$digitMin:$digitSec", style: display),
    //   StreamBuilder(
    //       stream: _positionDataStream,
    //       builder: ((context, snapshot) {
    //         final positionData = snapshot.data;
    //         return ProgressBar(
    //           barHeight: 8,
    //           baseBarColor: lightGrey,
    //           progressBarColor: pink,
    //           thumbColor: pink,
    //           timeLabelTextStyle: const TextStyle(color: black),
    //           progress: positionData?.position ?? Duration.zero,
    //           buffered: positionData?.bufferedPosition ?? Duration.zero,
    //           total: positionData?.duration ?? Duration.zero,
    //           onSeek: _audioPlayer.seek,
    //         );
    //       })),
    //   StreamBuilder<PlayerState>(
    //       stream: _audioPlayer.playerStateStream,
    //       builder: (context, snapshot) {
    //         final playerState = snapshot.data;
    //         final processingState = playerState?.processingState;
    //         final playing = playerState?.playing;
    //         if (!(playing ?? false)) {
    //           return IconButton(
    //               iconSize: 50,
    //               color: pink,
    //               onPressed: _audioPlayer.play,
    //               icon: const Icon(Icons.play_arrow_rounded));
    //         } else if (processingState != ProcessingState.completed) {
    //           return IconButton(
    //               iconSize: 50,
    //               color: pink,
    //               onPressed: _audioPlayer.pause,
    //               icon: const Icon(Icons.pause_rounded));
    //         }
    //         return IconButton(
    //             iconSize: 50,
    //             color: pink,
    //             onPressed: _audioPlayer.play,
    //             icon: const Icon(Icons.play_arrow_rounded));
    //       }),
    // ]);
  }
}
