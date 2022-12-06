import 'package:HintMe/screens/proximo_tema.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class IconButtonES extends StatelessWidget {
  const IconButtonES(
      {super.key,
      required this.action,
      required this.icon,
      required this.borderRadius,
      required this.backgroundColor,
      required this.color});
  final Widget action;
  final IconData icon;
  final double borderRadius;
  final Color color;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return iconButton(context,
        action: action,
        icon: icon,
        borderRadius: borderRadius,
        color: color,
        backgroundColor: backgroundColor);
  }

  Container iconButton(BuildContext context,
      {required Widget action,
      required IconData icon,
      required double borderRadius,
      required Color backgroundColor,
      required Color color}) {
    return Container(
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(borderRadius)),
        child: IconButton(
          iconSize: 5.h,
          color: color,
          icon: Icon(icon),
          onPressed: () {
            Get.to(() => const ProximoTemaPage());
          },
        ));
  }
}
