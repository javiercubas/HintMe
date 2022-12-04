import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  const Search(
      {super.key,
      required this.text,
      required this.textError,
      required this.width});
  final String text;
  final String textError;
  final double width;
  @override
  Widget build(BuildContext context) {
    return search(text: text, textError: textError, width: width);
  }

  Container search(
      {required String text,
      required String textError,
      required double width}) {
    return Container(
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextField(
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color.fromRGBO(49, 45, 45, 1),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide.none,
            ),
            hintStyle: const TextStyle(
              color: Colors.white,
              fontStyle: FontStyle.italic,
            ),
            hintText: text,
          ),
          style: const TextStyle(
            color: Colors.white,
          ),
        ));
  }
}
