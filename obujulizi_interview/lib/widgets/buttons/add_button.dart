import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  final Color givenColor;
  final double size;
  final VoidCallback onPressed;

  const AddButton({
    Key? key,
    required this.givenColor,
    required this.size,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.add, color: givenColor),
      iconSize: size,
      onPressed: onPressed,
    );
  }
}
