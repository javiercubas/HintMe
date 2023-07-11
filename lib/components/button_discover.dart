import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ButtonDiscover extends StatelessWidget {
  const ButtonDiscover(
      {Key? key, required this.text, required this.img, required this.action})
      : super(key: key);

  final String text;
  final String img;
  final Widget action;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => action),
        );
      },
      child: Container(
        width: 90.w,
        height: 25.h,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(img),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10.w)),
        ),
        child: Stack(
          children: [
            Positioned(
                child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Color.fromRGBO(0, 0, 0, 0),
                    Color.fromRGBO(0, 0, 0, 1)
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                  borderRadius: BorderRadius.all(Radius.circular(10.w))),
            )),
            Positioned(
              bottom: 3.h,
              left: 5.w,
              child: Text(
                text.toUpperCase(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 21.sp,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
