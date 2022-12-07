import 'package:HintMe/components/avatar.dart';
import 'package:HintMe/components/icon_button.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:gap/gap.dart';
import 'package:animate_do/animate_do.dart';
import 'home.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Center(
          child: SafeArea(
              child: Center(
                  child: SingleChildScrollView(
                      child: Column(children: [
        accountSettings(),
      ]))))),
      backgroundColor: const Color.fromARGB(255, 39, 36, 36),
      bottomNavigationBar: FadeInUp(child: bottomMenu()),
    );
  }

  Container accountSettings() {
    return Container(
      width: 80.w,
      height: 50.h,
      decoration: const BoxDecoration(
          color: Color.fromARGB(255, 49, 45, 45),
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 13.h,
              width: 100.w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Avatar(
                      action: const HomePage(),
                      border: true,
                      image:
                          "https://pps.whatsapp.net/v/t61.24694-24/181714536_241960988059393_3937636634380900533_n.jpg?ccb=11-4&oh=01_AdSorvbCtgNjaKjF3CsjNUSrf7iwBt-eV8OCAyJ85GT-qQ&oe=639B4D10",
                      size: 9.h),
                  Text(
                    "Edit picture",
                    style: TextStyle(color: Colors.white, fontSize: 12.sp),
                  )
                ],
              ),
            ),
            Row(
              children: [
                Text(
                  "Name",
                  style: TextStyle(color: Colors.white, fontSize: 14.sp),
                ),
              ],
            )
          ]),
    );
  }

  AppBar appBar() {
    return AppBar(
      title: Text(
        "HINTME",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            fontSize: 21.sp,
            color: Colors.white),
      ),
      backgroundColor: const Color.fromARGB(255, 39, 36, 36),
      centerTitle: true,
      toolbarHeight: 10.h,
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
}
