import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class InputForm extends StatelessWidget {
  const InputForm({super.key, required this.text, required this.textError});
  final String text;
  final String textError;
  @override
  Widget build(BuildContext context) {
    return inputForm(text: text, textError: textError);
  }

  Container inputForm({required String text, required String textError}) {
    return Container(
        width: 80.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: TextField(
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color.fromARGB(255, 105, 58, 183),
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide.none),
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
