import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../screens/forgot_password.dart';
import 'avatar.dart';

class Header extends StatelessWidget {
  const Header({super.key, required this.lock});
  final bool lock;

  @override
  Widget build(BuildContext context) {
    return header(lock: lock);
  }

  SizedBox header({required bool lock}) {
    return SizedBox(
      height: 15.h,
      width: 100.w,
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        SizedBox(
            width: 90.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(lock ? "Bienvenido, Cubas 👋" : "@__.javi._01",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold)),
                Avatar(
                    action: const ForgotPassword(),
                    border: true,
                    image:
                        "https://pps.whatsapp.net/v/t61.24694-24/181714536_241960988059393_3937636634380900533_n.jpg?ccb=11-4&oh=01_AdQDiJaR4d5kP_SrlY8nj1Hz7zm8Wm5gtV2gt15mCtgcKw&oe=63998B10",
                    size: 5.h)
              ],
            )),
        Text(
          "HINTME",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              fontSize: 21.sp,
              color: Colors.white),
        ),
      ]),
    );
  }
}
