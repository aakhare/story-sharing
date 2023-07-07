import 'package:flutter/material.dart';
import 'package:obujulizi_managing/utils/all.dart';

class MyTab extends StatelessWidget {
  const MyTab({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Tab(child: Text(title, style: tabText));
  }
}
