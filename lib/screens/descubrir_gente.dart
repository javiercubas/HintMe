import 'package:HintMe/components/avatar.dart';
import 'package:HintMe/components/indirecta.dart';
import 'package:HintMe/components/title.dart';
import 'package:HintMe/model/usuario.dart';
import 'package:HintMe/screens/home.dart';
import 'package:HintMe/screens/perfil.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';
import 'package:swipeable_card_stack/swipe_controller.dart';

class DescubrirGente extends StatefulWidget {
  const DescubrirGente({super.key, required this.usuario});
  final Usuario usuario;

  @override
  State<DescubrirGente> createState() => _DescubrirGenteState();
}

class _DescubrirGenteState extends State<DescubrirGente> {
  String avatar = "";
  bool isFull = true;
  final ScrollController _scrollController = ScrollController();

  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels > 10.h) {
        setState(() {
          isFull = false;
        });
      } else {
        setState(() {
          isFull = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 39, 36, 36),
        appBar: appBar(usuario: widget.usuario),
        body: Center(
          child: SizedBox(
            width: 90.w,
            height: 90.h,
            child: Column(
              children: [
                main(),
                Gap(2.h),
                like_or_no(),
              ],
            ),
          ),
        ));
  }

  Container main() {
    return Container(
        height: 75.h,
        decoration:
            BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(12))),
        child: SingleChildScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: 75.h,
                child: Stack(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            //borderRadius: BorderRadius.all(Radius.circular(12)),
                            image: DecorationImage(
                                image: NetworkImage(
                                    "https://pps.whatsapp.net/v/t61.24694-24/291100678_286791683640238_1230206621727768820_n.jpg?ccb=11-4&oh=01_AdTDj8MIEI5swJV842kkwAQTPKpY8GOhrQJx0Xsal5y06A&oe=6450C6FE"),
                                fit: BoxFit.cover)),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          //borderRadius: BorderRadius.all(Radius.circular(12)),
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color.fromARGB(0, 0, 0, 0),
                                Color.fromARGB(255, 0, 0, 0)
                              ]),
                        ),
                      ),
                    ),
                    isFull
                        ? Positioned(
                            bottom: 3.h,
                            left: 5.w,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Sergio, 19",
                                    style: TextStyle(
                                        fontSize: 21.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    "Universidad Europea de Madrid",
                                    style: TextStyle(
                                        fontSize: 15.sp, color: Colors.white),
                                  ),
                                ]))
                        : Container()
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                width: 90.w,
                color: Color.fromARGB(255, 217, 217, 217),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Sergio, 19 - Villaverde",
                        style: TextStyle(
                            fontSize: 21.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      Gap(1.h),
                      textInfo(texto: "Miembro desde noviembre de 2022"),
                      textInfo(texto: "2º de Ingeniería Informática"),
                      textInfo(texto: "Universidad Europea de Madrid"),
                      Gap(2.h),
                      Text(
                        "Apasionado de la moda juvenil, experto en coches y cuñado del año 2022. Es broma niño yo te quiero.",
                        style: TextStyle(fontSize: 15.sp, color: Colors.black),
                      ),
                      Gap(2.h),
                      Text(
                        "Sus HintMe más populares",
                        style: TextStyle(
                            fontSize: 17.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      Gap(1.h),
                      indirecta(
                          usuario_actual: widget.usuario,
                          usuario: widget.usuario,
                          mensaje: "¿Te gusta el cine?",
                          fecha: "Hace 2 horas"),
                    ]),
              ),
            ],
          ),
        ));
  }

  Text textInfo({required String texto}) {
    return Text(
      texto,
      style: TextStyle(fontSize: 15.sp, color: Color.fromARGB(255, 81, 81, 81)),
    );
  }

  Container like_or_no() {
    return Container(
      height: 8.h,
      width: 90.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.close, color: Colors.white, size: 40.sp),
          Icon(Icons.favorite, color: Colors.white, size: 40.sp),
        ],
      ),
    );
  }

  AppBar appBar({required Usuario usuario}) {
    return AppBar(
        toolbarHeight: 10.h,
        elevation: 0,
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 39, 36, 36),
        title: TitleES(),
        actions: [
          Builder(builder: (context) {
            return Container(
              padding: EdgeInsets.only(top: 2.5.h, bottom: 2.5.h, right: 5.w),
              child: GestureDetector(
                  onTap: () => Scaffold.of(context).openEndDrawer(),
                  child: Container(
                    width: 5.h,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: usuario.avatar != ""
                              ? NetworkImage(usuario.avatar!)
                              : NetworkImage("")),
                      color: const Color.fromRGBO(103, 58, 183, 1),
                      boxShadow: const [
                        BoxShadow(
                            color: Color.fromRGBO(103, 58, 183, 1),
                            offset: Offset(0, 0),
                            blurRadius: 20)
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(100.w)),
                      border: Border.all(
                        color: const Color.fromRGBO(103, 58, 183, 1),
                        width: 2,
                      ),
                    ),
                  )),
            );
          })
        ]);
  }
}
