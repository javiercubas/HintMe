import 'package:HintMe/components/button_action.dart';
import 'package:HintMe/components/logo.dart';
import 'package:HintMe/pages/SignUp/create_user.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

class UploadAvatarPage extends StatefulWidget {
  const UploadAvatarPage({super.key});

  @override
  _UploadAvatarPageState createState() => _UploadAvatarPageState();
}

class _UploadAvatarPageState extends State<UploadAvatarPage> {
  bool height = false;

  @override
  Widget build(BuildContext context) {
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
              ))),
      bottomNavigationBar: Container(
        width: 100.w,
        height: height ? 20.h : 20.h,
        decoration: const BoxDecoration(
            color: Color.fromRGBO(103, 58, 183, 1),
            boxShadow: [
              BoxShadow(
                  color: Color.fromRGBO(103, 58, 183, 1),
                  offset: Offset(4, 4),
                  blurRadius: 100)
            ]),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            IconButton(
                iconSize: 10.h,
                icon: const Icon(Icons.camera_alt),
                color: Colors.white,
                onPressed: () {
                  height = !height;
                }),
            Text(
              'Cámara',
              style: TextStyle(
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                  fontSize: 14.sp),
            ),
          ]),
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            IconButton(
                iconSize: 10.h,
                icon: const Icon(Icons.photo),
                color: Colors.white,
                onPressed: () {
                  setState(() {
                    height = !height;
                  });
                }),
            Text(
              'Galeria',
              style: TextStyle(
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                  fontSize: 14.sp),
            ),
          ]),
        ]),
      ),
    );
  }

  SizedBox signUp(BuildContext context) {
    return SizedBox(
      // Login
      width: 80.w,
      height: 60.h,
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Column(children: [
          AnimatedContainer(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(103, 58, 183, 1),
                  borderRadius: BorderRadius.circular(100.w),
                  boxShadow: const [
                    BoxShadow(
                        color: Color.fromRGBO(31, 3, 98, 1),
                        offset: Offset(4, 4),
                        blurRadius: 20)
                  ]),
              duration: const Duration(milliseconds: 1500),
              child: IconButton(
                iconSize: 40.w,
                icon: const Icon(Icons.person),
                color: Colors.white,
                onPressed: () {
                  height = !height;
                },
              )),
          Gap(3.h),
          Text(
            'Añade una foto de perfil',
            style: TextStyle(
                color: Colors.white,
                fontStyle: FontStyle.italic,
                fontSize: 12.sp),
          ),
        ]),
        Center(
          child: ButtonAction(
            text: "Siguiente",
            color: Colors.white,
            backgroundColor: Colors.black,
            action: const CreateUserPage(),
            width: 80.w,
          ),
        ),
      ]),
    );
  }
}
