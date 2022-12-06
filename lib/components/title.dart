import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class TitleES extends StatelessWidget {
  const TitleES({super.key});

  @override
  Widget build(BuildContext context) {
    return title();
  }

  Text title() {
    return Text(
      "HINTME",
      textAlign: TextAlign.center,
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
          fontSize: 21.sp,
          color: Colors.white),
    );
  }
}
