import 'package:HintMe/components/header.dart';
import 'package:HintMe/screens/home.dart';
import 'package:HintMe/screens/tema_diario.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';
import '../components/button_action.dart';

class ProximoTemaPage extends StatelessWidget {
  const ProximoTemaPage({super.key});

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
                "Elige la temática para mañana",
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
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            tema(
              pregunta:
                  "¿Quien es para ti el mejor jugador de la historia y por qué?",
              fondo:
                  "https://assets-es.imgfoot.com/media/cache/1200x1200/cristiano-ronaldo-enerve.jpg",
              imagen:
                  "https://www.elespectador.com/resizer/_5xsQmRFaEtfOCm4BGf5XBGIuDA=/525x350/filters:format(jpeg)/cloudfront-us-east-1.images.arcpublishing.com/elespectador/55PSQZ3RPABZTYG4UDKZJZQIOU.jpg",
            ),
            tema(
              pregunta: "¿Playa mejor que montaña o al revés?",
              fondo:
                  "https://fotografias.lasexta.com/clipping/cmsimages02/2018/07/18/AF4115B9-4C62-46CA-A874-258917F1FB4F/98.jpg?crop=1200,675,x0,y78&width=1900&height=1069&optimize=high&format=webply",
              imagen:
                  "https://www.inoutviajes.com/galerias-noticias/galerias/10241/SugarBeach_AViceroyResort_1_.jpg",
            ),
          ],
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
            ButtonAction(
              action: const TemaDiarioPage(),
              backgroundColor: const Color.fromARGB(255, 103, 58, 183),
              color: Colors.white,
              text: 'Seleccionar',
              fontStyle: FontStyle.italic,
              width: 50.w,
            ),
            Gap(5.h),
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
