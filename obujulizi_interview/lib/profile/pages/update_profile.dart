import 'package:flutter/material.dart';
import 'package:obujulizi_interviews/profile/all.dart';
import 'package:obujulizi_interviews/utils/all.dart';
import 'package:obujulizi_interviews/widgets/all.dart';

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({super.key});

  @override
  State<UpdateProfilePage> createState() => UpdateProfilePageState();
}

class UpdateProfilePageState extends State<UpdateProfilePage> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _contactInfoController = TextEditingController();

  final nameFocus = FocusNode();
  final contactInfoFocus = FocusNode();

  final ProfileSetUp profileSetUp = ProfileSetUp();

  void updateProfile() {
    profileSetUp.updateProfile(
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
          const Text("Fill out the form below to update the profile",
              style: headline1),
          extraLargeVertical,
          const Align(
            alignment: Alignment.centerLeft,
            child: Text("Update Profile", style: display),
          ),
          const Divider(color: black),
          mediumVertical,
          Form(
              key: formKey,
              child: Column(
                children: [
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
                      updateProfile();
                    }
                  },
                  label: const Text("Update Profile"),
                ),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}
