import 'package:flutter/material.dart';

class MyBackButton extends StatelessWidget {

  const MyBackButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios_sharp),
      iconSize: 36,
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}
