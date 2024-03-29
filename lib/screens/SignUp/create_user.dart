import 'package:HintMe/components/avatar.dart';
import 'package:HintMe/components/button_function.dart';
import 'package:HintMe/components/input_form.dart';
import 'package:HintMe/components/logo.dart';
import 'package:HintMe/screens/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

class CreateUserPage extends StatefulWidget {
  const CreateUserPage({super.key});

  @override
  _CreateUserPageState createState() => _CreateUserPageState();
}

class _CreateUserPageState extends State<CreateUserPage> {
  final userController = TextEditingController();
  String avatar = "";

  @override
  void dispose() {
    userController.dispose();

    super.dispose();
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

  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold(
        body: Center(
            child: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      Color.fromARGB(255, 103, 58, 183),
                      Color.fromARGB(255, 31, 3, 98)
                    ])),
                child: SafeArea(
                  child: Center(
                      child: SingleChildScrollView(
                    child: Column(
                      children: [const Logo(), signUp(context)],
                    ),
                  )),
                ))));
  }

  SizedBox signUp(BuildContext context) {
    return SizedBox(
      // Login
      width: 80.w,
      height: 60.h,
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Text(
          'Por último, escribe un nombre de usuario. Este se utilizará para identificarte dentro de la aplicación.',
          style: TextStyle(
              color: Colors.white,
              fontStyle: FontStyle.italic,
              fontSize: 12.sp),
        ),
        Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Avatar(
                  action: const Text(""),
                  size: 7.5.h,
                  image: avatar,
                  border: true),
              InputForm(
                  controller: userController,
                  password: false,
                  text: "Nombre de usuario",
                  width: 60.w,
                  validator: ((user) =>
                      user != null ? null : "Nombre de usuario no disponible")),
            ]),
        Column(children: [
          Text(
            'Al crear una cuenta confirmo que soy mayor de edad y acepto los términos y condiciones de la aplicación',
            style: TextStyle(
                color: Colors.white,
                fontStyle: FontStyle.italic,
                fontSize: 12.sp),
          ),
          Gap(3.h),
          ButtonFunction(
            text: "Crear Cuenta",
            color: Colors.white,
            backgroundColor: Colors.black,
            action: () => updateUser(),
            width: 80.w,
            fontStyle: FontStyle.normal,
          ),
        ]),
      ]),
    );
  }

  Future updateUser() async {
    final docUser = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid);

    final json = {
      'user': userController.text.trim(),
    };

    await docUser
        .set(json, SetOptions(merge: true))
        .then((value) => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            ));
  }
}
