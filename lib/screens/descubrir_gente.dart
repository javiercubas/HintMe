import 'package:HintMe/components/title.dart';
import 'package:HintMe/screens/home.dart';
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
          child: Container(
            color: Color.fromARGB(255, 60, 52, 133),
            width: 95.w,
            height: 90.h,
            child: Column(
              children: [
                Container(
                    color: Color.fromARGB(255, 30, 99, 99),
                    height: 70.h,
                    child: Stack(
                      children: [
                        Positioned(
                          child: Image(
                            image: NetworkImage(
                                "https://pps.whatsapp.net/v/t61.24694-24/291100678_286791683640238_1230206621727768820_n.jpg?ccb=11-4&oh=01_AdRcXteDwqmT-Ef1wYTvdIVB-6ORMgY4v1FjXYpOelGS5w&oe=63B99AFE"),
                            fit: BoxFit.cover,
                          ),
                        )
                      ],
                    ))
              ],
            ),
          ),
        ));
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
