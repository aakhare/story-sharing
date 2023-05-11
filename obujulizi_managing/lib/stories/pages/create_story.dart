import 'package:flutter/material.dart';
import 'package:obujulizi_managing/stories/services/draft_functions.dart';
import 'package:obujulizi_managing/utils/all.dart';
import 'package:obujulizi_managing/widgets/all.dart';

class CreateStory extends StatefulWidget {
  final String interviewId;
  final String profileId;
  const CreateStory(
      {super.key, required this.interviewId, required this.profileId});

  @override
  State<CreateStory> createState() => CreateStoryState();
}

class CreateStoryState extends State<CreateStory> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _captionController = TextEditingController();
  final TextEditingController _tagController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

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

  void createDraft() {
    draftFunction.createStory(
        context: context,
        title: _titleController.text.trim(),
        caption: _captionController.text.trim(),
        tag: _tagController.text.trim(),
        content: _contentController.text.trim(),
        interviewId: widget.interviewId,
        profileId: widget.profileId,
        status: 'draft');
  }

  void createStory() {
    draftFunction.createStory(
        context: context,
        title: _titleController.text.trim(),
        caption: _captionController.text.trim(),
        tag: _tagController.text.trim(),
        content: _contentController.text.trim(),
        interviewId: widget.interviewId,
        profileId: widget.profileId,
        status: 'published');
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
                  createDraft();
                },
                label: const Text("Create New Draft"),
              ),
            ),
            Flexible(
              child: FloatingActionButton.extended(
                onPressed: () {
                  final isValid = formKey.currentState!.validate();
                  if (isValid == true) {
                    createStory();
                  }
                },
                label: const Text("Publish Story"),
              ),
            ),
          ],
        ),
      ]),
    ));
  }
}
