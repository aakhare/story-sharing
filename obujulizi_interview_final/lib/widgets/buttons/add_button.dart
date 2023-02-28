import 'package:flutter/material.dart';
import 'package:obujulizi_interview_final/utils/constants/colors.dart';

class AddButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AddButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.add, color: white),
      onPressed: onPressed,
    );
  }
}
