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
      child: const Center(
        child: Text(
          "HINTME",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              fontSize: 40,
              color: Colors.white),
        ),
      ),
    );
  }
}
