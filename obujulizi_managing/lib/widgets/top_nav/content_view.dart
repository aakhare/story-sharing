import 'package:flutter/material.dart';
import 'package:obujulizi_managing/interviews/pages/dashboard_content.dart';
import 'package:obujulizi_managing/stories/pages/drafts_content.dart';
import 'package:obujulizi_managing/interviews/pages/home_content.dart';
import 'package:obujulizi_managing/widgets/top_nav/custom_tab.dart';

class ContentView {
  ContentView({required this.tab, required this.content});

  final MyTab tab;
  final Widget content;
}

List<ContentView> contentViews = [
  ContentView(tab: const MyTab(title: 'Home'), content: const HomeContent()),
  ContentView(
      tab: const MyTab(title: 'Dashboard'), content: const DashBoardContent()),
  ContentView(tab: const MyTab(title: 'Drafts'), content: const DraftsContent()),
];
