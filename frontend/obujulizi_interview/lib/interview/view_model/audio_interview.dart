import 'dart:async';
import 'dart:io';
import 'package:chewie/chewie.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:just_audio/just_audio.dart';
import 'package:obujulizi_interview_final/interview/services/interview_functions.dart';
import 'package:obujulizi_interview_final/utils/all.dart';
import 'package:video_player/video_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rxdart/rxdart.dart';

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
  final String digitalSignatureUrl;
  final String contentUrl;
  const AudioInterview({
    Key? key,
    required this.digitalSignatureUrl,
    required this.contentUrl,
  }) : super(key: key);

  @override
  State<AudioInterview> createState() => AudioInterviewState();
}

class AudioInterviewState extends State<AudioInterview> {
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;
  XFile? signatureFile;

  String? signatureFilePath;
  final _audioPlayer = AudioPlayer();
  final recorder = FlutterSoundRecorder();

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

  void initialUpload() {
    interviewCreation.uploadDigitalSignature(
        context: context,
        signatureFile: signatureFile,
        uploadUrl: widget.digitalSignatureUrl);
    interviewCreation.uploadAudioFile(
        context: context, audioFile: audioFile, uploadUrl: widget.contentUrl);
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

  Future initRecorder() async {
    final status = await Permission.microphone.request();

    if (status != PermissionStatus.granted) {
      throw "Microphone permission not granted";
    }

    await recorder.openRecorder();
    isRecorderReady = true;
  }

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

  Future record() async {
    if (!isRecorderReady) return;
    await recorder.startRecorder(
        toFile: 'audio', numChannels: 1, sampleRate: 44100);
    startTimer();
  }

  Future stop() async {
    if (!isRecorderReady) return;

    final file = await recorder.stopRecorder();
    final recordedFile = File(file!);
    saveAudio(recordedFile);
    final pathToFile = recordedFile.path;
    setState(() {
      audioFile = recordedFile;
      _audioPlayer.setUrl(pathToFile);
    });
    stopTimer();
    resetTimer();
  }

  Future setAudio() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.audio);

    if (result != null) {
      setState(() {
        final file = File(result.files.single.path!);
        saveAudio(file);
        _audioPlayer.setUrl(file.path);
      });
    }
  }

  void saveAudio(File file) {
    audioFile = file;
  }

  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          _audioPlayer.positionStream,
          _audioPlayer.bufferedPositionStream,
          _audioPlayer.durationStream,
          (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));

  @override
  void initState() {
    super.initState();
    initRecorder();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    recorder.closeRecorder();
    isRecorderReady = false;
    _chewieController?.dispose();
    super.dispose();
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
            icon: const Icon(Icons.camera_alt_sharp),
            iconSize: 25,
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
          child: Text("Audio Interview", style: headline2)),
      GestureDetector(
          onTap: () async {
            if (recorder.isRecording) {
              await stop();
            } else {
              await record();
            }
            setState(() {});
          },
          child: Icon(recorder.isRecording ? Icons.stop : Icons.mic,
              size: 150, color: pink)),
      extraLargeVertical,
      Text("$digitHours:$digitMin:$digitSec", style: display),
      StreamBuilder(
          stream: _positionDataStream,
          builder: ((context, snapshot) {
            final positionData = snapshot.data;
            return ProgressBar(
              barHeight: 8,
              baseBarColor: lightGrey,
              progressBarColor: pink,
              thumbColor: pink,
              timeLabelTextStyle: const TextStyle(color: black),
              progress: positionData?.position ?? Duration.zero,
              buffered: positionData?.bufferedPosition ?? Duration.zero,
              total: positionData?.duration ?? Duration.zero,
              onSeek: _audioPlayer.seek,
            );
          })),
      StreamBuilder<PlayerState>(
          stream: _audioPlayer.playerStateStream,
          builder: (context, snapshot) {
            final playerState = snapshot.data;
            final processingState = playerState?.processingState;
            final playing = playerState?.playing;
            if (!(playing ?? false)) {
              return IconButton(
                  iconSize: 50,
                  color: pink,
                  onPressed: _audioPlayer.play,
                  icon: const Icon(Icons.play_arrow_rounded));
            } else if (processingState != ProcessingState.completed) {
              return IconButton(
                  iconSize: 50,
                  color: pink,
                  onPressed: _audioPlayer.pause,
                  icon: const Icon(Icons.pause_rounded));
            }
            return IconButton(
                iconSize: 50,
                color: pink,
                onPressed: _audioPlayer.play,
                icon: const Icon(Icons.play_arrow_rounded));
          }),
      Align(
          alignment: Alignment.centerRight,
          child: IconButton(
              iconSize: 25,
              onPressed: setAudio,
              icon: const Icon(Icons.folder))),
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
