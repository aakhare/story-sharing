import 'package:flutter/material.dart';
import 'package:obujulizi_interview_final/utils/all.dart';

class NavigationHeader extends StatelessWidget {
  const NavigationHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: sharedPadding,
      child: Column(children: [
        largeVertical,
        mediumVertical,
        header,
        extraSmallVertical,
        caption,
        mediumVertical,
      ]),
    );
  }
}
