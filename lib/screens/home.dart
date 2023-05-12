import 'package:HintMe/components/avatar.dart';
import 'package:HintMe/components/icon_button.dart';
import 'package:HintMe/components/indirectas_container.dart';
import 'package:HintMe/components/search.dart';
import 'package:HintMe/model/circulos.dart';
import 'package:HintMe/model/indirecta.dart';
import 'package:HintMe/model/usuario.dart';
import 'package:HintMe/screens/Login/login.dart';
import 'package:HintMe/screens/Solicitudes.dart';
import 'package:HintMe/screens/circulo_page.dart';
import 'package:HintMe/screens/conversacion.dart';
import 'package:HintMe/screens/descubrir_gente.dart';
import 'package:HintMe/screens/perfil.dart';
import 'package:HintMe/screens/proximo_tema.dart';
import 'package:HintMe/screens/search_page.dart';
import 'package:HintMe/screens/settings.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:gap/gap.dart';
import 'package:animate_do/animate_do.dart';
import 'package:HintMe/components/button_function.dart';

class HomePage extends StatefulWidget {
  final Usuario usuario;
  const HomePage({super.key, required this.usuario});

  @override
  State<HomePage> createState() => _HomePageState(usuario);
}

class _HomePageState extends State<HomePage> {
  _HomePageState(this._usuario);
  final Usuario _usuario;
  bool lock = false;
  List<Circulo> _circulos = [];
  List<IndirectaModel> indirectasList = [];

  void initState() {
    super.initState();
    _initState();
  }

  void _initState() async {
    int indirectas =
        await IndirectaModel.getNumeroIndirectasPublicadasPorUsuarioHoy(
            _usuario.id);
    lock = indirectas == 0;
    _circulos = await Circulo.getCirculosUsuario(_usuario.id, 10);

    indirectasList = await IndirectaModel.getIndirectasSeguidos(_usuario.id);
  }

  @override
  Widget build(BuildContext context) {
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
          leading: _usuario.privado
              ? Row(
                  children: [
                    Gap(0.5.w),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SolicitudesPage(
                                      usuario: _usuario,
                                      solicitudes: true,
                                      nombre: "Solicitudes",
                                    )));
                      },
                      child: Icon(
                        Icons.people,
                        color: const Color.fromARGB(255, 103, 58, 183),
                        size: 4.h,
                      ),
                    ),
                  ],
                )
              : null,
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
                            image: NetworkImage(_usuario.avatar ?? "")),
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
      endDrawer: NavigationDrawer(usuario: _usuario),
      body: Center(
          child: SafeArea(
              child: Center(
                  child: SingleChildScrollView(
                      child: Column(children: [
        FadeInDown(
          child: menu(lock, usuario: _usuario),
        ),
        content(lock, usuario: _usuario),
      ]))))),
      backgroundColor: const Color.fromARGB(255, 39, 36, 36),
      bottomNavigationBar: FadeInUp(child: bottomMenu()),
    );
  }

  Container bottomMenu() {
    return Container(
      height: 10.h,
      decoration: const BoxDecoration(color: Color.fromARGB(255, 49, 45, 45)),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        IconButtonES(
            action: DescubrirGente(usuario: _usuario, usuario_actual: _usuario),
            icon: Icons.home_outlined,
            borderRadius: 0,
            color: Colors.white,
            backgroundColor: Color.fromARGB(0, 0, 0, 0)),
        IconButtonES(
            action: DescubrirGente(usuario: _usuario, usuario_actual: _usuario),
            icon: Icons.person_add_alt,
            borderRadius: 0,
            color: Colors.white,
            backgroundColor: Color.fromARGB(0, 0, 0, 0)),
        IconButtonES(
            action:
                ConversacionPage(usuario_actual: _usuario, usuario: _usuario),
            icon: Icons.message_outlined,
            borderRadius: 0,
            color: Colors.white,
            backgroundColor: Color.fromARGB(0, 0, 0, 0)),
        IconButtonES(
            action: PerfilPage(
              usuario: _usuario,
              usuario_actual: _usuario,
            ),
            icon: Icons.person,
            borderRadius: 0,
            color: Colors.white,
            backgroundColor: Color.fromARGB(0, 0, 0, 0))
      ]),
    );
  }

  Column content(bool lock, {required Usuario usuario}) {
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
            indirectas: indirectasList,
            usuario_actual: usuario,
          ),
        ),
      ],
    );
  }

  SizedBox circulos() {
    return SizedBox(
        width: 91.w,
        child: Column(
          children: [
            headerCirculos(),
            Gap(2.h),
            SizedBox(width: 100.w, height: 11.5.h, child: contentCirculos())
          ],
        ));
  }

  ListView contentCirculos() {
    return ListView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      children: _circulos
          .map((circulo_) => Column(
                children: [
                  circulo(
                    id: circulo_.id,
                    text: circulo_.nombre,
                    image: circulo_.foto,
                  ),
                  Gap(3.w),
                ],
              ))
          .toList(),
    );
  }

  GestureDetector circulo(
      {required String image, required String text, required int id}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CirculoPage(
                      usuario: _usuario,
                      id: id,
                    )));
      },
      child: Column(
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
            style: TextStyle(color: Colors.white, fontSize: 10.sp),
          )
        ],
      ),
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

  Row menu(lock, {required Usuario usuario}) {
    return Row(
      mainAxisAlignment:
          lock ? MainAxisAlignment.spaceAround : MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [buscador(), lock ? upload(usuario: usuario) : Container()],
    );
  }

  IconButtonES upload({required usuario}) {
    return IconButtonES(
      action: ProximoTemaPage(usuario: usuario),
      icon: Icons.upload_file,
      borderRadius: 10,
      backgroundColor: Colors.white,
      color: Colors.black,
    );
  }

  Search buscador() {
    return Search(
        text: "Buscar usuario",
        action: SearchPage(
          usuario_actual: _usuario,
        ),
        width: 70.w);
  }
}

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({super.key, required this.usuario});
  final Usuario usuario;

  @override
  Widget build(BuildContext context) => Drawer(
          child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(usuario.avatar!),
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
                      action: SettingsPage(usuario: usuario),
                      border: true,
                      image: usuario.avatar!,
                      size: 10.h),
                  Gap(2.h),
                  Text(
                    usuario.nombre != "" ? usuario.nombre.toUpperCase() : "",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                        color: Colors.white),
                  ),
                  Text(
                    usuario.user != "" ? "@${usuario.user}".toUpperCase() : "",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12.sp, color: Colors.white),
                  ),
                ]),
                ButtonFunction(
                    action: () async {
                      final prefs = await SharedPreferences.getInstance();
                      prefs.setInt('currentUser', 0);
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                        (Route<dynamic> route) => false,
                      );
                    },
                    backgroundColor: const Color.fromARGB(255, 49, 45, 45),
                    color: Colors.white,
                    text: "Cerrar Sesión",
                    width: 66.w,
                    fontStyle: FontStyle.normal)
              ]),
        ),
      ));
}
