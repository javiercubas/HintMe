import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Avatar extends StatelessWidget {
  const Avatar(
      {super.key,
      required this.action,
      required this.border,
      required this.image,
      required this.size});
  final Widget action;
  final bool border;
  final String image;
  final double size;

  @override
  Widget build(BuildContext context) {
    return avatar(action, size, image, border);
  }

  GestureDetector avatar(
      Widget action, double size, String image, bool border) {
    return GestureDetector(
        onTap: () {
          action;
        },
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            image:
                DecorationImage(fit: BoxFit.cover, image: NetworkImage(image)),
            color: const Color.fromRGBO(103, 58, 183, 1),
            boxShadow: const [
              BoxShadow(
                  color: Color.fromRGBO(103, 58, 183, 1),
                  offset: Offset(4, 4),
                  blurRadius: 20)
            ],
            borderRadius: BorderRadius.all(Radius.circular(100.w)),
            border: Border.all(
              color: Color.fromRGBO(103, 58, 183, 1),
              width: border ? 2 : 0,
            ),
          ),
        ));
  }
}
