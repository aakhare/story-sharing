import 'package:flutter/material.dart';
import 'package:obujulizi_managing/stories/services/draft_functions.dart';
import 'package:obujulizi_managing/utils/all.dart';
import 'package:obujulizi_managing/widgets/all.dart';


class ViewDraft extends StatefulWidget {
  final String storyId;
  final String interviewId;
  final String profileId;
  final String storyTitle;
  final String storyContent;
  final String storyCaption;
  final String storyStatus;
  final String tags;
  const ViewDraft({
    super.key,
    required this.storyId,
    required this.storyTitle,
    required this.storyContent,
    required this.storyCaption,
    required this.storyStatus,
    required this.tags,
    required this.interviewId,
    required this.profileId,
  });

  @override
  State<ViewDraft> createState() => ViewDraftState();
}

class ViewDraftState extends State<ViewDraft> {
  final formKey = GlobalKey<FormState>();

  late final TextEditingController _titleController =
      TextEditingController(text: widget.storyTitle);
  late final TextEditingController _captionController =
      TextEditingController(text: widget.storyCaption);
  late final TextEditingController _tagController =
      TextEditingController(text: widget.tags);
  late final TextEditingController _contentController =
      TextEditingController(text: widget.storyContent);

  final titleFocus = FocusNode();
  final captionFocus = FocusNode();
  final tagFocus = FocusNode();
  final contentFocus = FocusNode();

  @override
  void dispose() {
    _titleController.dispose();
    _captionController.dispose();
    _tagController.dispose();
    _contentController.dispose();
    titleFocus.dispose();
    captionFocus.dispose();
    tagFocus.dispose();
    contentFocus.dispose();
    super.dispose();
  }

  DraftFunction draftFunction = DraftFunction();

  void updateDraft() {
    draftFunction.updateDraft(
        context: context,
        draftId: widget.storyId,
        title: _titleController.text.trim(),
        caption: _captionController.text.trim(),
        tag: _tagController.text.trim(),
        content: _contentController.text.trim(),
        status: 'draft',
        interviewId: widget.interviewId,
        profileId: widget.profileId);
  }

  void createStory() {
    draftFunction.createStoryFromDraft(
        context: context,
        draftId: widget.storyId,
        title: _titleController.text.trim(),
        caption: _captionController.text.trim(),
        tag: _tagController.text.trim(),
        content: _contentController.text.trim(),
        status: 'published',
        interviewId: widget.interviewId,
        profileId: widget.profileId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: pagePadding,
      child: Column(children: [
        Row(
          children: const [
            smallHorizontal,
            Text("Create Story", style: headline1),
          ],
        ),
        mediumVertical,
        Form(
            key: formKey,
            child: Column(
              children: [
                TitleField(
                    controller: _titleController,
                    focusNode: titleFocus,
                    nextFocusNode: captionFocus,
                    validator: (input) {
                      if (_titleController.text.isWhitespace()) {
                        return "Title is required";
                      }
                      return null;
                    }),
                smallVertical,
                CaptionField(
                    controller: _captionController,
                    focusNode: captionFocus,
                    nextFocusNode: null,
                    validator: (input) {
                      if (_captionController.text.isWhitespace()) {
                        return "Caption is required";
                      }
                      return null;
                    }),
                TagField(
                    controller: _tagController,
                    focusNode: tagFocus,
                    nextFocusNode: contentFocus,
                    validator: (input) {
                      if (_tagController.text.isWhitespace()) {
                        return "Tag is required";
                      }
                      return null;
                    }),
                MultiLineField(
                    controller: _contentController,
                    focusNode: contentFocus,
                    nextFocusNode: null,
                    validator: (input) {
                      if (_contentController.text.isWhitespace()) {
                        return "Content is required";
                      }
                      return null;
                    }),
              ],
            )),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: FloatingActionButton.extended(
                backgroundColor: purple,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    side: const BorderSide(width: 2, color: purple)),
                onPressed: () {
                  updateDraft();
                },
                label: const Text("Save Draft"),
              ),
            ),
            Flexible(
              child: FloatingActionButton.extended(
                backgroundColor: pink,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    side: const BorderSide(width: 2, color: pink)),
                onPressed: () {
                  createStory();
                },
                label: const Text("Publish as Story"),
              ),
            ),
          ],
        ),
      ]),
    ));
  }
}
