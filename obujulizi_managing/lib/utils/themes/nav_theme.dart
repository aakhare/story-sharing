import 'package:flutter/material.dart';
import 'package:obujulizi_managing/utils/all.dart';

class MyTabBarTheme {
  TabBarTheme theme() => const TabBarTheme(
        labelColor: pink,
        indicator: UnderlineTabIndicator( // color for indicator (underline)
          borderSide: BorderSide(color: black))
      );
}
