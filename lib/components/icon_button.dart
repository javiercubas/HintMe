import 'package:flutter/material.dart';
import 'package:HintMe/pages/home.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class IconButtonES extends StatelessWidget {
  const IconButtonES(
      {super.key,
      required this.action,
      required this.icon,
      required this.borderRadius});
  final bool action;
  final IconData icon;
  final double borderRadius;
  @override
  Widget build(BuildContext context) {
    return iconButton(context,
        action: action, icon: icon, borderRadius: borderRadius);
  }

  Container iconButton(BuildContext context,
      {required bool action,
      required IconData icon,
      required double borderRadius}) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(borderRadius)),
        child: IconButton(
          iconSize: 5.h,
          icon: Icon(icon),
          onPressed: () {
            action = !action;
          },
        ));
  }
}
