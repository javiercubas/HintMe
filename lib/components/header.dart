import 'package:HintMe/components/title.dart';
import 'package:HintMe/model/usuario.dart';
import 'package:HintMe/screens/settings.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'avatar.dart';

class Header extends StatelessWidget {
  const Header({super.key, required this.lock, required this.usuario});
  final bool lock;
  final Usuario usuario;

  @override
  Widget build(BuildContext context) {
    return header(lock: lock, usuario: usuario);
  }

  SizedBox header({required bool lock, required Usuario usuario}) {
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
                SizedBox(
                  height: 5.h,
                  child: Stack(children: [
                    FadeOut(
                        delay: const Duration(seconds: 9),
                        duration: const Duration(milliseconds: 500),
                        child: Center(
                          child: Text(
                              lock ? "Bienvenido, Cubas 👋" : "@__.javi._01",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold)),
                        )),
                    Positioned(
                        left: 0,
                        top: 0,
                        child: FadeIn(
                            delay: const Duration(milliseconds: 9500),
                            duration: const Duration(milliseconds: 500),
                            child: Icon(
                              Icons.people,
                              color: const Color.fromARGB(255, 103, 58, 183),
                              size: 5.h,
                            )))
                  ]),
                ),
                Avatar(
                    action: SettingsPage(usuario: usuario),
                    border: true,
                    image:
                        "https://pps.whatsapp.net/v/t61.24694-24/181714536_241960988059393_3937636634380900533_n.jpg?ccb=11-4&oh=01_AdQDiJaR4d5kP_SrlY8nj1Hz7zm8Wm5gtV2gt15mCtgcKw&oe=63998B10",
                    size: 5.h)
              ],
            )),
        const TitleES(),
      ]),
    );
  }
}
