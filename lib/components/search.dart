import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

class Search extends StatelessWidget {
  const Search({
    super.key,
    required this.text,
    required this.action,
    required this.width,
  });
  final String text;
  final Widget action;
  final double width;
  @override
  Widget build(BuildContext context) {
    return search(context, text: text, action: action, width: width);
  }

  Container search(BuildContext context,
      {required String text, required Widget action, required double width}) {
    return Container(
        width: width,
        height: 7.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => action),
            );
          },
          style: ButtonStyle(
              backgroundColor: MaterialStateColor.resolveWith(
                  (states) => const Color.fromRGBO(49, 45, 45, 1))),
          child: Row(
            children: [
              Gap(2.w),
              Icon(
                Icons.search,
                color: Colors.white,
              ),
              Gap(3.w),
              Text(text,
                  style: TextStyle(color: Colors.white, fontSize: 12.sp)),
            ],
          ),
        ));
  }
}
