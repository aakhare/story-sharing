import 'package:flutter/material.dart';
import 'package:obujulizi_stories/utils/constants/colors.dart';

class SearchBar extends StatefulWidget {
  final FocusNode? nextFocusNode;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final String? labelText;

  const SearchBar(
      {Key? key,
      this.nextFocusNode,
      this.focusNode,
      this.controller,
      this.labelText})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => SearchBarState();
}

class SearchBarState extends State<SearchBar> {
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: widget.controller,
        keyboardType: TextInputType.visiblePassword,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search, color: black),
          labelText: "Search",
          helperText: "",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: black)
          ),
        ));
  }
}
