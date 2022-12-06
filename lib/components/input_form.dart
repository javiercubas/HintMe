import 'package:flutter/material.dart';

class InputForm extends StatelessWidget {
  const InputForm(
      {super.key,
      required this.text,
      required this.width,
      required this.controller,
      required this.validator,
      required this.password});
  final String text;
  final double width;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool password;
  @override
  Widget build(BuildContext context) {
    return inputForm(
        text: text,
        width: width,
        controller: controller,
        validator: validator,
        password: password);
  }

  Container inputForm(
      {required String text,
      required double width,
      required TextEditingController controller,
      required String? Function(String?)? validator,
      required bool password}) {
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
        child: TextFormField(
          controller: controller,
          obscureText: password ? true : false,
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
            hintText: text,
          ),
          textInputAction: TextInputAction.done,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: validator,
          style: const TextStyle(
            color: Colors.white,
          ),
        ));
  }
}
