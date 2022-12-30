import 'package:HintMe/components/icon_button.dart';
import 'package:HintMe/components/title.dart';
import 'package:HintMe/screens/home.dart';
import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:swipeable_card_stack/swipe_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DescubrirGente extends StatefulWidget {
  const DescubrirGente({super.key});

  @override
  State<DescubrirGente> createState() => _DescubrirGenteState();
}

class _DescubrirGenteState extends State<DescubrirGente> {
  String avatar = "";
  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 39, 36, 36),
        appBar: appBar(),
        body: Center(
          child: SizedBox(
            width: 90.w,
            height: 90.h,
            child: Column(
              children: [
                Container(
                    height: 75.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            height: 75.h,
                            child: Stack(
                              children: [
                                Column(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12)),
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    "https://pps.whatsapp.net/v/t61.24694-24/291100678_286791683640238_1230206621727768820_n.jpg?ccb=11-4&oh=01_AdRcXteDwqmT-Ef1wYTvdIVB-6ORMgY4v1FjXYpOelGS5w&oe=63B99AFE"),
                                                fit: BoxFit.cover)),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12)),
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
                                  ],
                                ),
                                Positioned(
                                    bottom: 3.h,
                                    left: 5.w,
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                                fontSize: 15.sp,
                                                color: Colors.white),
                                          ),
                                        ]))
                              ],
                            ),
                          ),
                          Container(
                            width: 90.w,
                            height: 40.h,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              color: Colors.white,
                            ),
                            child: Center(
                              child: SingleChildScrollView(
                                child: Container(
                                  width: 85.w,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Sergio, 19 - Villaverde",
                                        style: TextStyle(
                                            fontSize: 21.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                      Text(
                                        "",
                                        style: TextStyle(
                                            fontSize: 7.sp,
                                            color: Colors.black),
                                      ),
                                      Text(
                                        "miembro desde Noviermbre de 2022",
                                        style: TextStyle(
                                            fontSize: 11.sp,
                                            color: Colors.grey),
                                      ),
                                      Text(
                                        "2º Ingeniería informática",
                                        style: TextStyle(
                                            fontSize: 11.sp,
                                            color: Colors.grey),
                                      ),
                                      Text(
                                        "Universidad Europea de Madrid",
                                        style: TextStyle(
                                            fontSize: 11.sp,
                                            color: Colors.grey),
                                      ),
                                      Text(
                                        "",
                                        style: TextStyle(
                                            fontSize: 7.sp,
                                            color: Colors.black),
                                      ),
                                      Text(
                                        "Apasionado de la moda juvenil, experto en coches y cuñado del año 2022. Es broma niño yo te quiero.",
                                        style: TextStyle(
                                            fontSize: 11.sp,
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ),
        bottomNavigationBar: FadeInUp(child: bottomMenu()));
  }

  Container bottomMenu() {
    return Container(
      height: 10.h,
      decoration: const BoxDecoration(color: Color.fromARGB(255, 39, 36, 36)),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        IconButtonES(
            action: DescubrirGente(),
            icon: Icons.close_rounded,
            borderRadius: 0,
            color: Colors.white,
            backgroundColor: Color.fromARGB(255, 39, 36, 36)),
        IconButtonES(
            action: DescubrirGente(),
            icon: Icons.favorite,
            borderRadius: 0,
            color: Colors.white,
            backgroundColor: Color.fromARGB(255, 39, 36, 36))
      ]),
    );
  }

  AppBar appBar() {
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
                          image: avatar != ""
                              ? NetworkImage(avatar)
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

  Future getData() async {
    final docRef = users.doc(FirebaseAuth.instance.currentUser?.uid);
    docRef.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        setState(() {
          avatar = data['avatar'];
        });
      },
      onError: (e) => print("Error getting document: $e"),
    );
  }
}
