import 'package:HintMe/components/indirecta.dart';
import 'package:HintMe/components/title.dart';
import 'package:HintMe/model/indirecta.dart';
import 'package:HintMe/model/usuario.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';
import 'package:swipeable_card_stack/swipeable_card_stack.dart';
import 'package:timeago/timeago.dart' as timeago;

class DescubrirGente extends StatefulWidget {
  const DescubrirGente(
      {super.key, required this.usuario, required this.usuario_actual});
  final Usuario usuario;
  final Usuario usuario_actual;

  @override
  State<DescubrirGente> createState() => _DescubrirGenteState();
}

class _DescubrirGenteState extends State<DescubrirGente> {
  String avatar = "";
  bool isFull = true;
  final ScrollController _scrollController = ScrollController();
  final _cardController = SwipeableCardSectionController();
  int counter = 0;
  List<IndirectaModel>? _indirectasList;

  void initState() {
    super.initState();

    _initState();

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

  void _initState() async {
    await IndirectaModel.getIndirectasPublicadasPorUsuario(widget.usuario.id)
        .then((value) {
      setState(() {
        _indirectasList = value;
      });
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
      ),
    );
  }

  SwipeableCardsSection main() {
    return SwipeableCardsSection(
      cardController: _cardController,
      context: context,
      cardHeightTopMul: 90.h,
      cardHeightBottomMul: 90.h,
      cardHeightMiddleMul: 90.h,
      cardWidthBottomMul: 90.w,
      cardWidthMiddleMul: 90.w,
      cardWidthTopMul: 90.w,
      items: [
        personas(),
      ],

      enableSwipeUp: false,
      enableSwipeDown: false,
      //Get card swipe event callbacks
      onCardSwiped: (dir, index, widget) {
        //Add the next card
        if (counter <= 20) {
          _cardController.addItem(personas());
          counter++;
        }

        if (dir == Direction.left) {
          print('onDisliked $index');
        } else if (dir == Direction.right) {
          print('onLiked $index');
        }
      },
    );
  }

  Container personas() {
    return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(12))),
      child: SingleChildScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: 78.h,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        //borderRadius: BorderRadius.all(Radius.circular(12)),
                        image: DecorationImage(
                            image: NetworkImage(widget.usuario.avatar!),
                            fit: BoxFit.cover)),
                  ),
                  Container(
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
                  isFull
                      ? Positioned(
                          bottom: 3.h,
                          left: 5.w,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${widget.usuario.nombre.split(' ')[0]}, ${(DateTime.now().difference(widget.usuario.fechaNacimiento!).inDays / 365.25).floor()}",
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
                      "${widget.usuario.nombre.split(' ')[0]}, ${(DateTime.now().difference(widget.usuario.fechaNacimiento!).inDays / 365.25).floor()} - Villaverde",
                      style: TextStyle(
                          fontSize: 21.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    Gap(1.h),
                    textInfo(
                        texto:
                            "Miembro desde ${DateFormat('MMMM y', 'es_ES').format(widget.usuario.fechaRegistro).replaceFirst(' ', ' de ')}"),
                    textInfo(texto: "2º de Ingeniería Informática"),
                    textInfo(texto: "Universidad Europea de Madrid"),
                    Gap(2.h),
                    Text(
                      widget.usuario.biografia,
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
                    for (var i = 0; i < _indirectasList!.length; i++)
                      Column(
                        children: [
                          indirecta(
                            usuario_actual: widget.usuario_actual,
                            usuario: widget.usuario,
                            fecha: timeago.format(
                                DateTime.now().subtract(DateTime.now()
                                    .toUtc()
                                    .add(Duration(hours: 2))
                                    .difference(
                                        _indirectasList![i].fechaPublicacion)),
                                locale: 'es'),
                            mensaje: _indirectasList![i].mensaje,
                          ),
                          Gap(3.h),
                        ],
                      ),
                  ]),
            ),
          ],
        ),
      ),
    );
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
          IconButton(
            onPressed: () {
              _cardController.triggerSwipeLeft();
            },
            icon: Icon(Icons.close, color: Colors.white, size: 40.sp),
          ),
          IconButton(
              onPressed: () {
                _cardController.triggerSwipeRight();
              },
              icon: Icon(Icons.favorite, color: Colors.white, size: 40.sp)),
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
