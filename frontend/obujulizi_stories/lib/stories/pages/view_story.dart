import 'package:flutter/material.dart';
import 'package:obujulizi_stories/utils/all.dart';
import 'package:obujulizi_stories/widgets/all.dart';

class ViewStory extends StatefulWidget {
  final String storyId;
  final String title;
  final String content;
  final String caption;
  final String status;
  final String tags;
  const ViewStory(
      {super.key,
      required this.storyId,
      required this.title,
      required this.content,
      required this.caption,
      required this.status,
      required this.tags});

  @override
  State<ViewStory> createState() => ViewStoryState();
}

class ViewStoryState extends State<ViewStory> {
  String pageTitle = 'View Story';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: MyAppBar(title: pageTitle, button: true)),
      body: SingleChildScrollView(
          child: Padding(
              padding: pagePadding,
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(widget.title, style: display),
                smallVertical,
                Text(widget.caption, style: bodyText1),
                extraLargeVertical,
                Text(widget.content, style: bodyText2)
              ]))),
    );
  }
}
