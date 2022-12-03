import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:gap/gap.dart';

class Separator extends StatelessWidget {
  const Separator({super.key});

  @override
  Widget build(BuildContext context) {
    return separator();
  }

  Row separator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Divider(
          color: Colors.black,
          thickness: 1.0,
          indent: 35.w,
          endIndent: 0,
          height: 10,
        ),
        Gap(2.w),
        Text(
          "o",
          style: TextStyle(color: Colors.white, fontSize: 20.sp),
        ),
        Gap(2.w),
        Divider(
          color: Colors.black,
          thickness: 1.0,
          indent: 35.w,
          endIndent: 0,
          height: 10,
        ),
      ],
    );
  }
}
