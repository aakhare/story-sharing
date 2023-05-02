import 'package:flutter/material.dart';
import 'package:obujulizi_stories/utils/all.dart';

class MyProgressIndicator extends StatelessWidget {
  const MyProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: pink,
        backgroundColor: lightGrey,
    ));
  }
}
