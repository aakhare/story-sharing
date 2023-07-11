import 'package:flutter/material.dart';
import 'package:obujulizi_stories/stories/services/story_functions.dart';
import 'package:obujulizi_stories/stories/services/story_model.dart';
import 'package:obujulizi_stories/utils/all.dart';
import 'package:obujulizi_stories/widgets/all.dart';

class AllStories extends StatefulWidget {
  const AllStories({super.key});

  @override
  State<AllStories> createState() => AllStoriesState();
}

class AllStoriesState extends State<AllStories> {
  String pageTitle = 'Home Page';

  @override
  Widget build(BuildContext context) {
    Future<List<Story>> futureStories =
        StoryFunctions.getAllStories(context: context);
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: MyAppBar(title: pageTitle, button: false)),
      body: SingleChildScrollView(
          child: Center(
        child: Padding(
            padding: pagePadding,
            child: FutureBuilder<List<Story>>(
                future: futureStories,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final stories = snapshot.data!;
                    return BuildStories(stories: stories);
                  } else {
                    return const MyProgressIndicator();
                  }
                })),
      )),
    );
  }
}

class BuildStories extends StatefulWidget {
  final List<Story> stories;
  const BuildStories({super.key, required this.stories});

  @override
  State<BuildStories> createState() => BuildStoriesState();
}

class BuildStoriesState extends State<BuildStories> {
  final searchController = TextEditingController(text: 'e.g. "health"');
  late List<Story> allStories = widget.stories;
  var searchedStories = <Story>[];

   @override
  void initState() {
    searchedStories = allStories;
    super.initState();
  }

  void searchForStory(String query) {
    setState(() {
      searchedStories = allStories.where((story) {
        final storyTag = story.tags.toLowerCase();
        final input = query.toLowerCase();

        return storyTag.contains(input);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(children: [
        const Text("All Stories", style: headline1),
        smallHorizontal,
        Text("(${searchedStories.length} total)"),
      ]),
      smallVertical,
      const Align(
          alignment: Alignment.centerLeft,
          child:
              Text("* click on a story to view its details", style: bodyText1)),
      smallVertical,
      TextFormField(
          controller: searchController,
          decoration: InputDecoration(
            suffixIcon: const Icon(Icons.search, color: black),
            labelText: "Search",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(color: black)),
          ),
          onChanged: searchForStory),
          mediumVertical,
      ListView.builder(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemCount: searchedStories.length,
          itemBuilder: (context, index) {
            final story = searchedStories[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: white, boxShadow: kElevationToShadow[4]),
                child: ListTile(
                    horizontalTitleGap: 50,
                    title: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(story.title, style: headline3),
                    ),
                    subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(story.caption, style: bodyText1),
                          ),
                          largeVertical,
                          const Divider(color: lightGrey),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(story.tags),
                          )
                        ]),
                    onTap: () {
                      Navigator.pushNamed(context, RoutesName.storyDetails,
                              arguments: Story(
                                  caption: story.caption,
                                  content: story.content,
                                  status: story.status,
                                  storyId: story.storyId,
                                  tags: story.tags,
                                  title: story.title))
                          .then((_) {
                        setState(() {});
                      });
                    }),
              ),
            );
          }),
      mediumVertical
    ]);
  }
}
