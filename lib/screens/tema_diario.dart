import 'package:HintMe/components/header.dart';
import 'package:HintMe/screens/home.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../components/button_action.dart';

class TemaDiarioPage extends StatelessWidget {
  const TemaDiarioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(0, 0, 0, 0),
        bottom: PreferredSize(
            preferredSize: Size(100.w, 17.h),
            child: Column(children: [
              const Header(lock: false),
              Gap(5.h),
              Text(
                "El tema diario es...",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold),
              ),
            ])),
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: tema(
          pregunta:
              "¿Quien es para ti el mejor jugador de la historia y por qué?",
          fondo:
              "https://assets-es.imgfoot.com/media/cache/1200x1200/cristiano-ronaldo-enerve.jpg",
          imagen:
              "https://www.elespectador.com/resizer/_5xsQmRFaEtfOCm4BGf5XBGIuDA=/525x350/filters:format(jpeg)/cloudfront-us-east-1.images.arcpublishing.com/elespectador/55PSQZ3RPABZTYG4UDKZJZQIOU.jpg",
        ),
      ),
    );
  }

  Container tema(
      {required String pregunta,
      required String fondo,
      required String imagen}) {
    return Container(
        width: 100.w,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(fondo), fit: BoxFit.cover, opacity: 1000),
            color: const Color.fromARGB(255, 39, 36, 36)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Gap(5.h),
            ZoomIn(
                duration: const Duration(seconds: 1),
                child: Spin(
                    duration: const Duration(seconds: 1),
                    child: fotoTema(imagen, pregunta))),
            Gap(5.h),
            SizedBox(
              width: 90.w,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BounceInLeft(
                        duration: const Duration(seconds: 1),
                        child: ButtonAction(
                          action: const HomePage(),
                          backgroundColor:
                              const Color.fromARGB(255, 103, 58, 183),
                          color: Colors.white,
                          text: 'Texto',
                          fontStyle: FontStyle.italic,
                          width: 40.w,
                        )),
                    BounceInRight(
                        duration: const Duration(seconds: 1),
                        child: ButtonAction(
                          action: const HomePage(),
                          backgroundColor:
                              const Color.fromARGB(255, 103, 58, 183),
                          color: Colors.white,
                          text: 'Multimedia',
                          fontStyle: FontStyle.italic,
                          width: 40.w,
                        )),
                  ]),
            ),
            FadeIn(
                duration: const Duration(seconds: 1),
                child: TextButton(
                    onPressed: () {
                      Get.to(() => const HomePage());
                    },
                    child: Text(
                      "Omitir",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12.sp,
                          color: const Color.fromARGB(255, 121, 121, 121),
                          decoration: TextDecoration.underline,
                          fontStyle: FontStyle.italic),
                    ))),
            Gap(2.h),
          ],
        ));
  }

  Container fotoTema(String imagen, String pregunta) {
    return Container(
        height: 50.h,
        width: 90.w,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(imagen), fit: BoxFit.cover, opacity: 150),
            color: const Color.fromARGB(255, 0, 0, 0),
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        child: Center(
            child: SizedBox(
                width: 80.w,
                child: FadeInUp(
                    delay: const Duration(seconds: 1),
                    duration: const Duration(seconds: 1),
                    child: Text(
                      pregunta,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    )))));
  }
}
