import 'package:HintMe/screens/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key, required this.uid});
  final String uid;

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  String avatar = "";
  String name = "";
  String user = "";

  Future getData(String uid) async {
    final docRef = users.doc(uid);
    docRef.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        setState(() {
          avatar = data['avatar'];
          name = data['name'];
          user = data['user'];
        });
      },
      onError: (e) => print("Error getting document: $e"),
    );
  }

  @override
  Widget build(BuildContext context) {
    getData(widget.uid);
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "HINTME",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                fontSize: 21.sp,
                color: Colors.white),
          ),
          elevation: 0,
          toolbarHeight: 10.h,
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 39, 36, 36),
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
                            fit: BoxFit.cover, image: NetworkImage(avatar)),
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
          ]),
      backgroundColor: const Color.fromARGB(255, 39, 36, 36),
      body: SafeArea(
        child: Container(
            height: 50.h,
            width: 100.w,
            child: avatar != ""
                ? Image(
                    image: NetworkImage(avatar),
                    fit: BoxFit.cover,
                  )
                : Container()),
      ),
    );
  }
}
