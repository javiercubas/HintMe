import 'package:HintMe/components/button_discover.dart';
import 'package:HintMe/screens/grupo_page.dart';
import 'package:HintMe/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';
import 'package:HintMe/screens/descubrir_gente.dart';

class DiscoverMenu extends StatelessWidget {
  const DiscoverMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(39, 36, 36, 1),
        body: SafeArea(
          child: Center(
            child: Container(
              width: 90.w,
              height: 100.h,
              child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Gap(3.h),
                      Text(
                        "CONOCE GENTE NUEVA",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Color.fromARGB(255, 103, 58, 183),
                            fontSize: 21.sp,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold),
                      ),
                      Gap(3.h),
                      ButtonDiscover(
                          text: "Clásico",
                          img: "./assets/clasico.jpg",
                          action: const DescubrirGente()),
                      Gap(3.h),
                      ButtonDiscover(
                          text: "Grupal",
                          img: "./assets/grupal.jpg",
                          action: const GrupoPage()),
                      Gap(3.h),
                      ButtonDiscover(
                          text: "Test de Compatibilidad",
                          img: "./assets/compatibilidad.jpg",
                          action: const HomePage()),
                      Gap(3.h),
                      ButtonDiscover(
                          text: "Eventos",
                          img: "./assets/eventos.jpg",
                          action: const HomePage()),
                      Gap(3.h),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: TextStyle(fontSize: 14.sp),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'HintMe',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 103, 58, 183)),
                            ),
                            TextSpan(
                              text: ' te ayuda a conocer a ',
                            ),
                            TextSpan(
                              text: 'gente nueva',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 103, 58, 183)),
                            ),
                            TextSpan(
                              text: ' con la que hacer ',
                            ),
                            TextSpan(
                              text:
                                  'planes maravillosos a diario y sin limites',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 103, 58, 183)),
                            ),
                          ],
                        ),
                      ),
                      Gap(3.h),
                    ],
                  )),
            ),
          ),
        ));
  }
}
