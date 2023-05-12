import 'package:HintMe/components/avatar.dart';
import 'package:HintMe/model/seguidores.dart';
import 'package:HintMe/model/usuario.dart';
import 'package:HintMe/screens/perfil.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

class SolicitudesPage extends StatefulWidget {
  const SolicitudesPage(
      {super.key,
      required this.usuario,
      required this.solicitudes,
      required this.nombre});
  final Usuario usuario;
  final bool solicitudes;
  final String nombre;

  @override
  _SolicitudesPageState createState() => _SolicitudesPageState();
}

class _SolicitudesPageState extends State<SolicitudesPage> {
  Future<List<Usuario>>? futureUsuarios;
  Usuario? usuario_actual;

  void initState() {
    super.initState();
    usuario_actual = widget.usuario;
    if (widget.solicitudes) {
      futureUsuarios = Seguidores.getSolicitudesSeguidores(usuario_actual!.id);
    } else {
      if (widget.nombre == "Seguidores") {
        futureUsuarios = Seguidores.getSeguidores(usuario_actual!.id);
      } else {
        futureUsuarios = Seguidores.getSeguidos(usuario_actual!.id);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 39, 36, 36),
      appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 39, 36, 36),
          elevation: 0,
          title: (Text(
            widget.nombre,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
            ),
          )),
          toolbarHeight: 10.h,
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
                            image: NetworkImage(usuario_actual!.avatar!)),
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: FutureBuilder<List<Usuario>>(
          future: futureUsuarios,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final usuarios = snapshot.data!;
              if (usuarios.isNotEmpty) {
                return ListView.builder(
                  itemCount: usuarios.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final usuario = usuarios[index];
                    return ListTile(
                      leading: Avatar(
                        border: true,
                        image: usuario.avatar!,
                        size: 5.h,
                      ),
                      title: Text(
                        usuario.user,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        usuario.nombre,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.6),
                        ),
                      ),
                      trailing: widget.solicitudes
                          ? Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.check),
                                  color: Colors.white,
                                  onPressed: () {
                                    Seguidores.aceptarSolicitudSeguidor(
                                        usuario.id, usuario_actual!.id, true);
                                    setState(() {
                                      usuarios.removeAt(index);
                                    });
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.close),
                                  color: Colors.white,
                                  onPressed: () {
                                    Seguidores.aceptarSolicitudSeguidor(
                                        usuario.id, usuario_actual!.id, false);
                                    setState(() {
                                      usuarios.removeAt(index);
                                    });
                                  },
                                ),
                              ],
                            )
                          : null,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PerfilPage(
                              usuario: usuario,
                              usuario_actual: usuario_actual!,
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              } else {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.sentiment_satisfied,
                        color: Colors.white,
                        size: 70.sp,
                      ),
                      Gap(2.h),
                      Text(
                        "No tienes solicitudes pendientes",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                        ),
                      ),
                    ],
                  ),
                );
              }
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  "Ha ocurrido un error: ${snapshot.error}",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16.sp,
                  ),
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
