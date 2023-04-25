import 'dart:io';

import 'package:HintMe/components/button_action.dart';
import 'package:HintMe/components/button_function.dart';
import 'package:HintMe/components/logo.dart';
import 'package:HintMe/screens/SignUp/avatar/camera_page.dart';
import 'package:HintMe/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class UploadAvatarPage extends StatefulWidget {
  const UploadAvatarPage({super.key});

  @override
  _UploadAvatarPageState createState() => _UploadAvatarPageState();
}

class _UploadAvatarPageState extends State<UploadAvatarPage> {
  bool height = false;

  double screenHeight = 0;
  double screenWidth = 0;
  Color primary = const Color(0xffeef444c);
  String profilePicLink = "";

  @override
  Widget build(BuildContext context, {XFile? path}) {
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
        height: height ? 20.h : 0.h,
        decoration: const BoxDecoration(
            color: Color.fromRGBO(103, 58, 183, 1),
            boxShadow: [
              BoxShadow(
                  color: Color.fromRGBO(103, 58, 183, 1),
                  offset: Offset(0, 0),
                  blurRadius: 100)
            ]),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CameraPage()),
            ),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              IconButton(
                  iconSize: 10.h,
                  icon: const Icon(Icons.camera_alt),
                  color: Colors.white,
                  onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CameraPage()),
                      )),
              Text(
                'Cámara',
                style: TextStyle(
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                    fontSize: 14.sp),
              ),
            ]),
          ),
          GestureDetector(
            onTap: () {},
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              IconButton(
                  iconSize: 10.h,
                  icon: const Icon(Icons.photo),
                  color: Colors.white,
                  onPressed: () {}),
              Text(
                'Galeria',
                style: TextStyle(
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                    fontSize: 14.sp),
              ),
            ]),
          ),
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
              height: 50.w,
              width: 50.w,
              padding: profilePicLink == ""
                  ? const EdgeInsets.all(10)
                  : const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(103, 58, 183, 1),
                  borderRadius: BorderRadius.circular(100.w),
                  boxShadow: const [
                    BoxShadow(
                        color: Color.fromRGBO(31, 3, 98, 1),
                        offset: Offset(0, 0),
                        blurRadius: 20)
                  ]),
              duration: const Duration(milliseconds: 1500),
              child: profilePicLink == ""
                  ? IconButton(
                      iconSize: 40.w,
                      icon: const Icon(Icons.person),
                      color: Colors.white,
                      onPressed: () {
                        setState(() {
                          height = !height;
                        });
                      },
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image(
                        image: NetworkImage(profilePicLink),
                        height: 100.h,
                        width: 100.w,
                        fit: BoxFit.cover,
                      ))),
          Gap(3.h),
          Text(
            'Añade una foto de perfil',
            style: TextStyle(
                color: Colors.white,
                fontStyle: FontStyle.italic,
                fontSize: 12.sp),
          ),
        ]),
        /*Center(
          child: ButtonFunction(
            text: "Siguiente",
            color: Colors.white,
            backgroundColor: Colors.black,
            action: () {},
            width: 80.w,
            fontStyle: FontStyle.normal,
          ),
        ),*/
      ]),
    );
  }
}
