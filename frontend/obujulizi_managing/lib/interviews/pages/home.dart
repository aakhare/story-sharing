import 'package:flutter/material.dart';
import 'package:obujulizi_managing/widgets/top_nav/content_view.dart';
import 'package:obujulizi_managing/widgets/top_nav/tab_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomeState();
}

class HomeState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  late double screenHeight;
  late double topPadding;
  late double bottomPadding;


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: contentViews.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    topPadding = screenHeight * 0.05;
    bottomPadding = screenHeight * 0.025;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TabBarLayout(
                tabController: _tabController,
                tabs: contentViews.map((e) => e.tab).toList()),
            SizedBox(
                height: screenHeight,
                child: TabBarView(
                    controller: _tabController,
                    children: contentViews.map((e) => e.content).toList())),
          ],
        ),
      ),
    );
  }
}
