import 'package:flutter/material.dart';

class BackButton extends StatelessWidget {

  const BackButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios_sharp),
      onPressed: (){
        Navigator.pop(context);
      },
    );
  }
}