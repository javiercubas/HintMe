import 'package:HintMe/components/avatar.dart';
import 'package:HintMe/components/indirecta.dart';
import 'package:HintMe/model/indirecta.dart';
import 'package:HintMe/model/seguidores.dart';
import 'package:HintMe/model/usuario.dart';
import 'package:HintMe/screens/conversacion.dart';
import 'package:HintMe/screens/settings.dart';
import 'package:HintMe/screens/solicitudes.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';
import 'package:timeago/timeago.dart' as timeago;

class PerfilPage extends StatefulWidget {
  const PerfilPage(
      {super.key, required this.usuario_actual, required this.usuario});
  final Usuario usuario_actual;
  final Usuario usuario;

  @override
  State<PerfilPage> createState() => _PerfilPageState(usuario, usuario_actual);
}

class _PerfilPageState extends State<PerfilPage> {
  _PerfilPageState(this._usuario, this._usuario_actual);
  Usuario _usuario;
  Usuario _usuario_actual;
  int _indirectas = 0;
  int _seguidores = 0;
  int _seguidos = 0;
  List<IndirectaModel>? _indirectasList;
  bool _isFollowing = false;

  void initState() {
    super.initState();
    _usuario = widget.usuario;
    _usuario_actual = widget.usuario_actual;
    _initState();
  }

  void _initState() async {
    await Seguidores.comprobarSeguidor(_usuario_actual.id, _usuario.id)
        .then((value) {
      setState(() {
        _isFollowing = value;
      });
    });
    await IndirectaModel.getNumeroIndirectasPublicadasPorUsuario(_usuario.id)
        .then((value) {
      setState(() {
        _indirectas = value;
      });
    });
    await Seguidores.getNumeroSeguidores(_usuario.id).then((value) {
      setState(() {
        _seguidores = value;
      });
    });
    await Seguidores.getNumeroSeguidos(_usuario.id).then((value) {
      setState(() {
        _seguidos = value;
      });
    });
    await IndirectaModel.getIndirectasPublicadasPorUsuario(_usuario.id)
        .then((value) {
      setState(() {
        _indirectasList = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            _usuario.user,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                fontSize: 21.sp,
                color: Colors.white),
          ),
          elevation: 0,
          toolbarHeight: 10.h,
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
                            fit: BoxFit.cover,
                            image: NetworkImage(_usuario_actual.avatar!)),
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
        child: RefreshIndicator(
          onRefresh: () async {
            setState(() {});
          },
          child: Center(
            child: Container(
              width: 90.w,
              height: 100.h,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gap(2.h),
                    Row(
                      children: [
                        Gap(2.w),
                        Avatar(
                          border: true,
                          image: _usuario.avatar!,
                          size: 70.sp,
                        ),
                        Gap(5.w),
                        Row(
                          children: [
                            userMetrics(
                              dato: 'Indirectas',
                              valor: _indirectas.toString(),
                            ),
                            Gap(2.w),
                            userMetrics(
                              dato: 'Seguidores',
                              valor: _seguidores.toString(),
                            ),
                            Gap(2.w),
                            userMetrics(
                              dato: 'Seguidos',
                              valor: _seguidos.toString(),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Gap(3.h),
                    Text(
                      _usuario.nombre,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15.sp,
                          color: Colors.white),
                    ),
                    Gap(1.h),
                    Text(
                      _usuario.biografia,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 15.sp,
                          color: Colors.white),
                    ),
                    Gap(3.h),
                    _usuario_actual.id == _usuario.id
                        ? botonesPerfil(
                            nombre: "Editar perfil",
                            color: const Color.fromRGBO(103, 58, 183, 1),
                            width: 100.w,
                            action: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SettingsPage(
                                            usuario: _usuario_actual,
                                          )),
                                ))
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              botonesPerfil(
                                  nombre: _isFollowing ? "Siguiendo" : "Seguir",
                                  color: _isFollowing
                                      ? const Color.fromARGB(255, 49, 45, 45)
                                      : const Color.fromRGBO(103, 58, 183, 1),
                                  action: _isFollowing
                                      ? () => Seguidores.dejarSeguirUsuario(
                                                  _usuario_actual.id,
                                                  _usuario.id)
                                              .then((value) {
                                            setState(() {
                                              _isFollowing = false;
                                              _seguidores--;
                                            });
                                          })
                                      : () => Seguidores.seguirUsuario(
                                              _usuario_actual.id, _usuario.id)
                                          .then((value) => {
                                                setState(() {
                                                  _isFollowing = true;
                                                  _seguidores++;
                                                })
                                              })),
                              botonesPerfil(
                                  nombre: "Enviar mensaje",
                                  action: () {
                                    return Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ConversacionPage(
                                                  usuario_actual:
                                                      _usuario_actual,
                                                  usuario: _usuario)),
                                    );
                                  })
                            ],
                          ),
                    Gap(3.h),
                    Container(
                        height: (_usuario.privado || _usuario.anonimo) &&
                                _usuario.id != _usuario_actual.id &&
                                !_isFollowing
                            ? 43.h
                            : null,
                        child: (_usuario.privado || _usuario.anonimo) &&
                                _usuario.id != _usuario_actual.id &&
                                !_isFollowing
                            ? Center(
                                child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 80.sp,
                                    height: 80.sp,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.transparent,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 4,
                                      ),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.lock_outline_rounded,
                                        size: 55.sp,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Gap(2.h),
                                  Text("Esta cuenta es privada.",
                                      style: TextStyle(
                                          fontSize: 15.sp,
                                          color: Colors.white)),
                                  Text("Siguela para ver sus indirectas.",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 15.sp,
                                          color: Colors.white)),
                                ],
                              ))
                            : Column(
                                children: [
                                  if (_indirectasList != null)
                                    for (var i = 0;
                                        i < _indirectasList!.length;
                                        i++)
                                      Column(
                                        children: [
                                          indirecta(
                                            usuario_actual: _usuario_actual,
                                            usuario: _usuario,
                                            fecha: timeago.format(
                                                DateTime.now().subtract(DateTime
                                                        .now()
                                                    .toUtc()
                                                    .add(Duration(hours: 2))
                                                    .difference(
                                                        _indirectasList![i]
                                                            .fechaPublicacion)),
                                                locale: 'es'),
                                            mensaje:
                                                _indirectasList![i].mensaje,
                                          ),
                                          Gap(3.h),
                                        ],
                                      ),
                                ],
                              )),
                    Gap(3.h),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  GestureDetector botonesPerfil(
      {required String nombre,
      required Future<void> Function() action,
      Color? color,
      double? width}) {
    return GestureDetector(
      onTap: () async {
        await action();
        bool isFollowing =
            await Seguidores.comprobarSeguidor(_usuario_actual.id, _usuario.id);
        setState(() {
          _isFollowing = isFollowing;
        });
      },
      child: Container(
        width: width ?? 42.w,
        padding: EdgeInsets.symmetric(vertical: 1.5.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            color: color ?? const Color.fromARGB(255, 49, 45, 45)),
        child: Text(
          nombre,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white,
              fontSize: 15.sp,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  GestureDetector userMetrics({required String dato, required String valor}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SolicitudesPage(
                    usuario: _usuario_actual,
                    nombre: dato,
                    solicitudes: false,
                  )),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            valor,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                fontSize: 18.sp,
                color: Colors.white),
          ),
          Gap(1.h),
          Text(
            dato,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12.sp,
                color: Colors.white),
          ),
        ],
      ),
    );
  }
}
