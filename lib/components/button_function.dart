import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ButtonFunction extends StatelessWidget {
  const ButtonFunction(
      {super.key,
      required this.action,
      required this.backgroundColor,
      required this.color,
      required this.text,
      required this.width,
      required this.fontStyle});

  final Future<dynamic> action;
  final Color backgroundColor;
  final Color color;
  final String text;
  final double width;
  final FontStyle fontStyle;
  @override
  Widget build(BuildContext context) {
    return buttonAction(context,
        action: action,
        backgroundColor: backgroundColor,
        color: color,
        text: text,
        width: width,
        fontStyle: fontStyle);
  }

  Container buttonAction(BuildContext context,
      {required Future<dynamic> action,
      required Color backgroundColor,
      required Color color,
      required String text,
      required double width,
      required FontStyle fontStyle}) {
    return Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(color: Colors.black, offset: Offset(1, 1), blurRadius: 20)
          ],
        ),
        child: TextButton(
            style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(Size(width, 7.h)),
                backgroundColor:
                    MaterialStateProperty.all<Color>(backgroundColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ))),
            onPressed: () {
              action;
            },
            child: Text(
              text.toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12.sp,
                  color: color,
                  fontStyle: fontStyle),
            )));
  }
}
