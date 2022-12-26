import 'package:HintMe/components/avatar.dart';
import 'package:HintMe/components/button_function.dart';
import 'package:HintMe/components/icon_button.dart';
import 'package:HintMe/screens/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:animate_do/animate_do.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String avatar = "";
  String name = "";
  String user = "";
  String bio = "";
  String link = "";
  String location = "";
  final nameController = TextEditingController();
  final userController = TextEditingController();
  final bioController = TextEditingController();
  final linkController = TextEditingController();
  final locationController = TextEditingController();

  Future getData() async {
    final docRef = users.doc(FirebaseAuth.instance.currentUser?.uid);
    docRef.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        setState(() {
          avatar = data['avatar'];
          name = data['name'];
          user = data['user'];
          bio = data['bio'];
          link = data['link'];
          location = data['location'];
        });
      },
      onError: (e) => print("Error getting document: $e"),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    userController.dispose();
    bioController.dispose();
    linkController.dispose();
    locationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    getData();
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
      height: 65.h,
      decoration: const BoxDecoration(
          // color: Color.fromARGB(255, 49, 45, 45),
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: Form(
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
                        image: avatar != "" ? avatar : "",
                        size: 9.h),
                    Text(
                      "Edit picture",
                      style: TextStyle(color: Colors.white, fontSize: 12.sp),
                    )
                  ],
                ),
              ),
              inputField(
                  text: "Nombre", variable: name, controller: nameController),
              inputField(
                  text: "Usuario", variable: user, controller: userController),
              inputField(text: "Bio", variable: bio, controller: bioController),
              inputField(
                  text: "Url", variable: link, controller: linkController),
              inputField(
                  text: "Localización",
                  variable: location,
                  controller: locationController),
              ButtonFunction(
                  action: () => updateUser(),
                  backgroundColor: Colors.white,
                  color: Colors.black,
                  text: "Guardar Cambios",
                  width: 80.w,
                  fontStyle: FontStyle.normal)
            ]),
      ),
    );
  }

  Row inputField(
      {required String text,
      required String variable,
      required TextEditingController controller}) {
    controller.text = variable;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 14.sp),
        ),
        Container(
          width: 50.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color.fromARGB(255, 49, 45, 45),
          ),
          child: TextFormField(
            controller: controller,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              filled: true,
              contentPadding: EdgeInsets.only(left: 20, right: 20),
              hintMaxLines: 1,
              fillColor: const Color.fromARGB(255, 49, 45, 45),
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide.none),
              hintStyle: const TextStyle(
                color: Colors.white54,
                fontStyle: FontStyle.italic,
              ),
              hintText: variable != ""
                  ? variable
                  : "Introduce un ${text.toLowerCase()}",
            ),
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
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

  Future updateUser() async {
    final docUser = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid);

    final json = {
      'name': nameController.text.trim(),
      'user': userController.text.trim(),
      'bio': bioController.text.trim(),
      'link': linkController.text.trim(),
      'location': locationController.text.trim(),
    };

    await docUser
        .set(json, SetOptions(merge: true))
        .then((value) => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            ));
  }
}
