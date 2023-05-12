import 'package:HintMe/components/avatar.dart';
import 'package:HintMe/components/button_function.dart';
import 'package:HintMe/components/icon_button.dart';
import 'package:HintMe/model/bbdd.dart';
import 'package:HintMe/model/usuario.dart';
import 'package:HintMe/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:animate_do/animate_do.dart';

class SettingsPage extends StatefulWidget {
  final Usuario usuario;
  const SettingsPage({super.key, required this.usuario});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late Usuario _usuario;
  final nameController = TextEditingController();
  final userController = TextEditingController();
  final bioController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    userController.dispose();
    bioController.dispose();

    super.dispose();
  }

  void initState() {
    super.initState();
    _usuario = widget.usuario;
  }

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
      bottomNavigationBar: FadeInUp(child: bottomMenu(usuario: _usuario)),
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
                    GestureDetector(
                      onTap: () {},
                      child: Avatar(
                          border: true,
                          image: _usuario.avatar! != "" ? _usuario.avatar! : "",
                          size: 9.h),
                    ),
                    Text(
                      "Edit picture",
                      style: TextStyle(color: Colors.white, fontSize: 12.sp),
                    )
                  ],
                ),
              ),
              inputField(
                  text: "Nombre",
                  variable: _usuario.nombre,
                  controller: nameController),
              inputField(
                  text: "Usuario",
                  variable: _usuario.user,
                  controller: userController),
              inputField(
                  text: "Bio",
                  variable: _usuario.biografia,
                  controller: bioController),
              ButtonFunction(
                  action: () => Conexion.actualizarUsuario(_usuario)
                      .then((value) => Navigator.pop(context)),
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

  Container bottomMenu({required Usuario usuario}) {
    return Container(
      height: 10.h,
      decoration: const BoxDecoration(color: Color.fromARGB(255, 49, 45, 45)),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        IconButtonES(
            action: HomePage(usuario: usuario),
            icon: Icons.home_outlined,
            borderRadius: 0,
            color: Colors.white,
            backgroundColor: Color.fromARGB(0, 0, 0, 0)),
        IconButtonES(
            action: HomePage(usuario: usuario),
            icon: Icons.person_add_alt,
            borderRadius: 0,
            color: Colors.white,
            backgroundColor: Color.fromARGB(0, 0, 0, 0)),
        IconButtonES(
            action: HomePage(usuario: usuario),
            icon: Icons.message_outlined,
            borderRadius: 0,
            color: Colors.white,
            backgroundColor: Color.fromARGB(0, 0, 0, 0))
      ]),
    );
  }
}
