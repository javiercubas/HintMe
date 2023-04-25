import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Avatar extends StatelessWidget {
  const Avatar({
    Key? key,
    this.action,
    required this.border,
    required this.image,
    required this.size,
  }) : super(key: key);

  final Widget? action;
  final bool border;
  final String image;
  final double size;

  @override
  Widget build(BuildContext context) {
    return avatar(context, action, size, image, border);
  }

  Widget avatar(
    BuildContext context,
    Widget? action,
    double size,
    String image,
    bool border,
  ) {
    final Widget avatarContainer = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(image),
        ),
        color: const Color.fromRGBO(103, 58, 183, 1),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(103, 58, 183, 1),
            offset: Offset(0, 0),
            blurRadius: 10,
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(100.w)),
        border: Border.all(
          color: const Color.fromRGBO(103, 58, 183, 1),
          width: border ? 2 : 0,
        ),
      ),
    );

    if (action != null) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => action),
          );
        },
        child: avatarContainer,
      );
    } else {
      return avatarContainer;
    }
  }
}
