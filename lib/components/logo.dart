import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return logo();
  }

  SizedBox logo() {
    return SizedBox(
        height: 30.h,
        width: 100.w,
        child: Center(
          child: Image(
            image: AssetImage("assets/HintMeLogoWhite.png"),
            fit: BoxFit.contain,
            height: 25.h,
            width: 25.h,
          ),
        ));
  }
}
