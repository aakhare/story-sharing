import 'dart:io';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'dart:async';
import 'package:just_audio/just_audio.dart';
import 'package:obujulizi_interview_final/services/all.dart';
import 'package:obujulizi_interview_final/utils/all.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rxdart/rxdart.dart';

class AudioSlider extends StatefulWidget {
  const AudioSlider({
    Key? key,
  }) : super(key: key);

  @override
  AudioSliderState createState() => AudioSliderState();
}

class AudioSliderState extends State<AudioSlider> {
  final InterviewCreation interviewCreation = InterviewCreation();

  final _audioPlayer = AudioPlayer();
  final recorder = FlutterSoundRecorder();

  File? finalFile;

  bool isRecorderReady = false;
  int sec = 0;
  int min = 0;
  int hours = 0;

  String digitSec = '00';
  String digitMin = '00';
  String digitHours = '00';

  Timer? timer;
  bool started = false;

  @override
  void initState() {
    super.initState();
    initRecorder();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    recorder.stopRecorder();
    isRecorderReady = false;
    super.dispose();
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

  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          _audioPlayer.positionStream,
          _audioPlayer.bufferedPositionStream,
          _audioPlayer.durationStream,
          (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));

  Future initRecorder() async {
    final status = await Permission.microphone.request();

    if (status != PermissionStatus.granted) {
      throw "Microphone permission not granted";
    }

    await recorder.openRecorder();
    isRecorderReady = true;
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
    setFile(recordedFile);
    final pathToFile = recordedFile.path;
    setState(() {
      _audioPlayer.setUrl(pathToFile);
    });
    stopTimer();
    resetTimer();
  }

  void setFile(File file) {
    setState(() {
      finalFile = file;
    });
  }

  void initialUpload() {
    interviewCreation.uploadAudioFile(context: context, audioFile: finalFile);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          extraLargeVertical,
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
                      color: pink,
                      onPressed: _audioPlayer.play,
                      icon: const Icon(Icons.play_arrow_rounded));
                } else if (processingState != ProcessingState.completed) {
                  return IconButton(
                      color: pink,
                      onPressed: _audioPlayer.pause,
                      icon: const Icon(Icons.pause_rounded));
                }
                return IconButton(
                    color: pink,
                    onPressed: _audioPlayer.play,
                    icon: const Icon(Icons.play_arrow_rounded));
              }),
          Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                  onPressed: setAudio, icon: const Icon(Icons.folder))),
          ElevatedButton(
              onPressed: () {
                initialUpload();
              },
              child: const Text('Upload Media')),
        ],
      ),
    );
  }

  Future setAudio() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.audio);

    if (result != null) {
      setState(() {
        final file = File(result.files.single.path!);
        _audioPlayer.setUrl(file.path);
      });
    }
  }
}

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
