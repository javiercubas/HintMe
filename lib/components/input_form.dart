import 'package:flutter/material.dart';

class InputForm extends StatelessWidget {
  const InputForm(
      {super.key,
      required this.text,
      required this.textError,
      required this.width});
  final String text;
  final String textError;
  final double width;
  @override
  Widget build(BuildContext context) {
    return inputForm(text: text, textError: textError, width: width);
  }

  Container inputForm(
      {required String text,
      required String textError,
      required double width}) {
    return Container(
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
                color: Color.fromRGBO(31, 3, 98, 1),
                offset: Offset(4, 4),
                blurRadius: 20)
          ],
        ),
        child: TextField(
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color.fromARGB(255, 105, 58, 183),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            hintStyle: const TextStyle(
              color: Colors.white,
              fontStyle: FontStyle.italic,
            ),
            errorText: textError,
            hintText: text,
          ),
          style: const TextStyle(
            color: Colors.white,
          ),
        ));
  }
}
