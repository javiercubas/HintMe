import 'package:HintMe/components/avatar.dart';
import 'package:HintMe/components/indirecta.dart';
import 'package:HintMe/model/indirecta.dart';
import 'package:HintMe/model/seguidores.dart';
import 'package:HintMe/model/usuario.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';
import 'package:timeago/timeago.dart' as timeago;

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key, required this.usuario_actual, this.usuario});
  final Usuario usuario_actual;
  final Usuario? usuario;

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  Usuario? _usuario;
  Usuario? _usuario_actual;
  bool _isFollowing = false;

  void initState() {
    super.initState();
    _usuario = widget.usuario;
    _usuario_actual = widget.usuario_actual;
    Seguidores.comprobarSeguidor(_usuario_actual!.id, _usuario!.id)
        .then((value) {
      setState(() {
        _isFollowing = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            _usuario!.user,
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
                            image: NetworkImage(_usuario_actual!.avatar!)),
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
                          image: _usuario!.avatar!,
                          size: 70.sp,
                        ),
                        Gap(5.w),
                        FutureBuilder<List<int>>(
                          future: Future.wait([
                            IndirectaModel
                                .getNumeroIndirectasPublicadasPorUsuario(
                                    _usuario!.id),
                            Seguidores.getNumeroSeguidores(_usuario!.id),
                            Seguidores.getNumeroSeguidos(_usuario!.id),
                          ]),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              List<int> data = snapshot.data!;
                              return Row(
                                children: [
                                  userMetrics(
                                    dato: 'Indirectas',
                                    valor: data[0].toString(),
                                  ),
                                  Gap(2.w),
                                  userMetrics(
                                    dato: 'Seguidores',
                                    valor: data[1].toString(),
                                  ),
                                  Gap(2.w),
                                  userMetrics(
                                    dato: 'Seguidos',
                                    valor: data[2].toString(),
                                  ),
                                ],
                              );
                            } else {
                              return Center(
                                  child: const CircularProgressIndicator());
                            }
                          },
                        ),
                      ],
                    ),
                    Gap(3.h),
                    Text(
                      _usuario!.nombre,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15.sp,
                          color: Colors.white),
                    ),
                    Gap(1.h),
                    Text(
                      _usuario!.biografia,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 15.sp,
                          color: Colors.white),
                    ),
                    Gap(3.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        botonesPerfil(
                            nombre: _isFollowing ? "Siguiendo" : "Seguir",
                            action: _isFollowing
                                ? () => Seguidores.dejarSeguirUsuario(
                                    _usuario_actual!.id, _usuario!.id)
                                : () => Seguidores.seguirUsuario(
                                    _usuario_actual!.id, _usuario!.id)),
                        botonesPerfil(
                            nombre: "Enviar mensaje",
                            action: _isFollowing
                                ? () => Seguidores.dejarSeguirUsuario(
                                    _usuario_actual!.id, _usuario!.id)
                                : () => Seguidores.seguirUsuario(
                                    _usuario_actual!.id, _usuario!.id)),
                      ],
                    ),
                    Gap(3.h),
                    Container(
                      height: 55.h,
                      child: FutureBuilder<List<IndirectaModel>>(
                        future:
                            IndirectaModel.getIndirectasPublicadasPorUsuario(
                                _usuario!.id),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<IndirectaModel>> snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: snapshot.data!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  children: [
                                    indirecta(
                                      usuario_actual: _usuario_actual!,
                                      usuario: _usuario,
                                      fecha: timeago.format(
                                          DateTime.now().subtract(DateTime.now()
                                              .toUtc()
                                              .add(Duration(hours: 2))
                                              .difference(snapshot.data![index]
                                                  .fechaPublicacion)),
                                          locale: 'es'),
                                      mensaje: snapshot.data![index].mensaje,
                                    ),
                                    Gap(3.h),
                                  ],
                                );
                              },
                            );
                          } else {
                            return CircularProgressIndicator();
                          }
                        },
                      ),
                    ),
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
      {required String nombre, required Future<void> Function() action}) {
    return GestureDetector(
      onTap: () async {
        await action();
        setState(() {
          _isFollowing = !_isFollowing;
        });
      },
      child: Container(
        width: 42.w,
        padding: EdgeInsets.symmetric(vertical: 1.5.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            color: Color.fromARGB(255, 49, 45, 45)),
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

  Column userMetrics({required String dato, required String valor}) {
    return Column(
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
    );
  }
}
