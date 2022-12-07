import 'package:HintMe/components/avatar.dart';
import 'package:HintMe/components/header.dart';
import 'package:HintMe/components/icon_button.dart';
import 'package:HintMe/components/indirectas_container.dart';
import 'package:HintMe/components/search.dart';
import 'package:HintMe/screens/proximo_tema.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:gap/gap.dart';
import 'package:animate_do/animate_do.dart';
import 'package:HintMe/components/button_function.dart';

CollectionReference users = FirebaseFirestore.instance.collection('users');

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    bool lock = true;
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
          leading: Builder(builder: (context) {
            return GestureDetector(
                onTap: () => Scaffold.of(context).openEndDrawer(),
                child: Container(
                  width: 1.h,
                  height: 1.h,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            "https://cdn.pixabay.com/photo/2015/08/05/04/25/people-875617_960_720.jpg")),
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
                ));
          })),
      endDrawer: const NavigationDrawer(),
      body: Center(
          child: SafeArea(
              child: Center(
                  child: SingleChildScrollView(
                      child: Column(children: [
        Gap(3.h),
        FadeInDown(
          child: Header(lock: lock),
        ),
        FadeInDown(
          child: menu(lock),
        ),
        content(lock),
      ]))))),
      backgroundColor: const Color.fromARGB(255, 39, 36, 36),
      bottomNavigationBar: FadeInUp(child: bottomMenu()),
    );
  }

  Container bottomMenu() {
    return Container(
      height: 10.h,
      decoration: const BoxDecoration(color: Color.fromARGB(255, 49, 45, 45)),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            IconButtonES(
                action: HomePage(),
                icon: Icons.home_outlined,
                borderRadius: 0,
                color: Colors.white,
                backgroundColor: Color.fromARGB(0, 0, 0, 0)),
            IconButtonES(
                action: HomePage(),
                icon: Icons.person_add_alt,
                borderRadius: 0,
                color: Colors.white,
                backgroundColor: Color.fromARGB(0, 0, 0, 0)),
            IconButtonES(
                action: HomePage(),
                icon: Icons.message_outlined,
                borderRadius: 0,
                color: Colors.white,
                backgroundColor: Color.fromARGB(0, 0, 0, 0))
          ]),
    );
  }

  Column content(bool lock) {
    return Column(
      children: [
        lock ? Gap(4.h) : Gap(0.h),
        ZoomIn(child: temaDiario(lock)),
        lock ? Gap(3.h) : Gap(0.h),
        FadeInLeft(child: circulos()),
        Gap(4.h),
        FadeInRight(
          child: IndirectasContainer(
            lock: lock,
          ),
        ),
      ],
    );
  }

  SizedBox circulos() {
    return SizedBox(
        width: 90.w,
        child: Column(
          children: [headerCirculos(), Gap(2.h), contentCirculos()],
        ));
  }

  Row contentCirculos() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        circulo(text: "All", image: ""),
        circulo(
            text: "Universidad",
            image:
                "https://1000marcas.net/wp-content/uploads/2019/12/UEM-simbolo.jpg"),
        circulo(
            text: "Fútbol",
            image:
                "https://upload.wikimedia.org/wikipedia/commons/0/07/%D0%A4%D0%9A_%22%D0%9A%D0%BE%D0%BB%D0%BE%D1%81%22_%28%D0%97%D0%B0%D1%87%D0%B5%D0%BF%D0%B8%D0%BB%D0%BE%D0%B2%D0%BA%D0%B0%2C_%D0%A5%D0%B0%D1%80%D1%8C%D0%BA%D0%BE%D0%B2%D1%81%D0%BA%D0%B0%D1%8F_%D0%BE%D0%B1%D0%BB%D0%B0%D1%81%D1%82%D1%8C%29_-_%D0%A4%D0%9A_%22%D0%91%D0%B0%D0%BB%D0%BA%D0%B0%D0%BD%D1%8B%22_%28%D0%97%D0%B0%D1%80%D1%8F%2C_%D0%9E%D0%B4%D0%B5%D1%81%D1%81%D0%BA%D0%B0%D1%8F_%D0%BE%D0%B1%D0%BB%D0%B0%D1%81%D1%82%D1%8C%29_%2818790931100%29.jpg"),
        circulo(
            text: "Fortnite",
            image:
                "https://cdn2.unrealengine.com/fortnite-creative-v22-30-update-1920x1080-c8168dd14bd2.png"),
        circulo(
            text: "Pueblo",
            image:
                "https://illescas.es/wp-content/uploads/2020/06/Ayuntamiento_fachada.jpeg")
      ],
    );
  }

  Column circulo({required String image, required String text}) {
    return Column(
      children: [
        Container(
          height: 7.h,
          width: 7.h,
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 49, 45, 45),
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              image: DecorationImage(
                  image: NetworkImage(image), fit: BoxFit.cover)),
        ),
        Gap(1.h),
        Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 11.sp),
        )
      ],
    );
  }

  Row headerCirculos() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Circulos",
          style: TextStyle(color: Colors.white, fontSize: 16.sp),
        ),
        TextButton(
            onPressed: () {},
            child: Text(
              "Ver todos >",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12.sp,
                  color: const Color.fromARGB(255, 103, 38, 183)),
            ))
      ],
    );
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
      children: [buscador(), lock ? upload() : const Center()],
    );
  }

  IconButtonES upload() {
    return const IconButtonES(
      action: ProximoTemaPage(),
      icon: Icons.upload_file,
      borderRadius: 10,
      backgroundColor: Colors.white,
      color: Colors.black,
    );
  }

  Search buscador() {
    return Search(text: "Buscar Usuario", textError: "", width: 70.w);
  }
}

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) => Drawer(
          child: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    "https://cdn.pixabay.com/photo/2015/08/05/04/25/people-875617_960_720.jpg"),
                fit: BoxFit.cover,
                opacity: 1000),
            color: Color.fromARGB(255, 39, 36, 36)),
        child: SafeArea(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(children: [
                  Text(
                    "HINTME",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        fontSize: 21.sp,
                        color: Colors.white),
                  ),
                  Gap(2.h),
                  Avatar(
                      action: const HomePage(),
                      border: true,
                      image:
                          "https://cdn.pixabay.com/photo/2015/08/05/04/25/people-875617_960_720.jpg",
                      size: 10.h),
                  Gap(2.h),
                  FutureBuilder<DocumentSnapshot>(
                    future:
                        users.doc(FirebaseAuth.instance.currentUser?.uid).get(),
                    builder: (BuildContext context,
                        AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text("Something went wrong");
                      }

                      if (snapshot.hasData && !snapshot.data!.exists) {
                        return Text("Document does not exist");
                      }

                      if (snapshot.connectionState == ConnectionState.done) {
                        Map<String, dynamic> data =
                            snapshot.data!.data() as Map<String, dynamic>;
                        return Text(
                          data['name'].toUpperCase(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                              color: Colors.white),
                        );
                      }

                      return Text("loading");
                    },
                  ),
                  FutureBuilder<DocumentSnapshot>(
                    future:
                        users.doc(FirebaseAuth.instance.currentUser?.uid).get(),
                    builder: (BuildContext context,
                        AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text("Something went wrong");
                      }

                      if (snapshot.hasData && !snapshot.data!.exists) {
                        return Text("Document does not exist");
                      }

                      if (snapshot.connectionState == ConnectionState.done) {
                        Map<String, dynamic> data =
                            snapshot.data!.data() as Map<String, dynamic>;
                        return Text(
                          "@${data['user']}".toUpperCase(),
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(fontSize: 12.sp, color: Colors.white),
                        );
                      }

                      return Text("loading");
                    },
                  ),
                ]),
                ButtonFunction(
                    action: () => FirebaseAuth.instance.signOut(),
                    backgroundColor: const Color.fromARGB(255, 49, 45, 45),
                    color: Colors.white,
                    text: "Cerrar Sesión",
                    width: 66.w,
                    fontStyle: FontStyle.normal)
              ]),
        ),
      ));
}
