import 'package:flutter/material.dart';
import 'package:obujulizi_interview_final/profile/services/profile_functions.dart';
import 'package:obujulizi_interview_final/utils/all.dart';
import 'package:obujulizi_interview_final/widgets/all.dart';

class AddProfilePage extends StatefulWidget {
  const AddProfilePage({super.key});

  @override
  State<AddProfilePage> createState() => AddProfilePageState();
}

class AddProfilePageState extends State<AddProfilePage> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _contactInfoController = TextEditingController();

  final nameFocus = FocusNode();
  final contactInfoFocus = FocusNode();

  final ProfileSetUp profileSetUp = ProfileSetUp();

  void createProfile() {
    profileSetUp.createProfile(
        context: context,
        contactInfo: _contactInfoController.text.trim(),
        name: _nameController.text.trim());
  }

  @override
  void dispose() {
    _nameController.dispose();
    _contactInfoController.dispose();
    nameFocus.dispose();
    contactInfoFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      padding: pagePadding,
      child: Column(
        children: [
          const Text("Fill out the form below to add a new profile",
              style: headline1),
          extraLargeVertical,
          const Align(
            alignment: Alignment.centerLeft,
            child: Text("Add Profile", style: display),
          ),
          const Divider(color: black),
          mediumVertical,
          Form(
              key: formKey,
              child: Column(
                children: [
                  smallVertical,
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      children: [
                        Text(
                            "* make sure to capitalize the first name and last name and add a space in between", style: bodyText2),
                        smallVertical,
                        Text("Ex: John Smith", style: bodyText1),
                      ],
                    ),
                  ),
                  mediumVertical,
                  FullNameField(
                    controller: _nameController,
                    focusNode: nameFocus,
                    nextFocusNode: contactInfoFocus,
                    validator: (input) {
                      if (_nameController.text.isWhitespace()) {
                        return "Full name is required";
                      }
                      return null;
                    },
                  ),
                  smallVertical,
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      children: [
                        Text(
                            "* list gender, age,  and general address with a comma in between each item", style: bodyText2),
                        smallVertical,
                        Text("Ex: Male, 21, 100 Seventh St", style: bodyText1),
                      ],
                    ),
                  ),
                  mediumVertical,
                  MultiLineField(
                    controller: _contactInfoController,
                    focusNode: contactInfoFocus,
                    nextFocusNode: null,
                    validator: (input) {
                      if (_contactInfoController.text.isWhitespace()) {
                        return "Contact information is required";
                      }
                      return null;
                    },
                  ),
                  smallVertical,
                ],
              )),
          mediumVertical,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: FloatingActionButton.extended(
                  onPressed: () {
                    final isValid = formKey.currentState!.validate();
                    if (isValid == true) {
                      createProfile();
                    }
                  },
                  label: const Text("Create Profile"),
                ),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}
