import 'package:flutter/material.dart';
import 'package:obujulizi_interview/utils/constants/colors.dart';

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
