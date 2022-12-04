import 'package:HintMe/components/avatar.dart';
import 'package:HintMe/components/icon_button.dart';
import 'package:HintMe/components/indirectas_container.dart';
import 'package:HintMe/components/search.dart';
import 'package:HintMe/pages/forgot_password.dart';
import 'package:flutter/material.dart';
import 'package:HintMe/pages/SignUp/sign_up.dart';
import 'package:sizer/sizer.dart';
import 'package:gap/gap.dart';
import 'package:animate_do/animate_do.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    bool lock = true;
    return Scaffold(
        body: Center(
            child: Container(
                decoration:
                    const BoxDecoration(color: Color.fromARGB(255, 39, 36, 36)),
                child: SafeArea(
                    child: Center(
                        child: Column(children: [
                  Gap(3.h),
                  BounceInDown(
                    duration: const Duration(seconds: 1),
                    child: header(lock),
                  ),
                  BounceInDown(
                    duration: const Duration(seconds: 1),
                    child: menu(lock),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Gap(5.h),
                        FadeIn(
                            duration: const Duration(seconds: 1),
                            child: temaDiario(lock)),
                        Gap(5.h),
                        BounceInUp(
                          duration: const Duration(seconds: 1),
                          child: IndirectasContainer(
                            lock: lock,
                          ),
                        ),
                      ],
                    ),
                  ),
                ]))))));
  }

  Text temaDiario(lock) {
    return Text(
      lock ? "¿Quien es el mejor jugador de la historia?" : "",
      style: TextStyle(
        color: const Color.fromARGB(255, 103, 58, 183),
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,
      ),
      textAlign: TextAlign.center,
    );
  }

  Row menu(lock) {
    return Row(
      mainAxisAlignment:
          lock ? MainAxisAlignment.spaceAround : MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [buscador(), lock ? upload(lock) : const Center()],
    );
  }

  IconButtonES upload(lock) {
    return IconButtonES(
      action: lock,
      icon: Icons.upload_file,
      borderRadius: 10,
    );
  }

  Search buscador() {
    return Search(text: "Buscar Usuario", textError: "", width: 70.w);
  }

  SizedBox header(lock) {
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
                    style: TextStyle(color: Colors.white, fontSize: 14.sp)),
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
