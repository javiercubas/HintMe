import 'package:HintMe/components/indirecta.dart';
import 'package:HintMe/model/bbdd.dart';
import 'package:HintMe/model/indirecta.dart';
import 'package:HintMe/model/usuario.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

class IndirectasContainer extends StatelessWidget {
  const IndirectasContainer(
      {super.key,
      required this.lock,
      required this.indirectas,
      required this.usuario_actual});
  final bool lock;
  final List<IndirectaModel> indirectas;
  final Usuario usuario_actual;

  @override
  Widget build(BuildContext context) {
    return indirectasDiv(lock: lock);
  }

  Column indirectasDiv({required bool lock}) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Indirectas de hoy',
          textAlign: TextAlign.left,
          style: TextStyle(
              color: const Color.fromRGBO(255, 255, 255, 1),
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 16.sp)),
      Gap(3.h),
      lock ? indirectasError() : indirectasStories()
    ]);
  }

  Container indirectasError() {
    return Container(
      width: 90.w,
      height: 18.h,
      padding: const EdgeInsets.all(20.0),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        color: Color.fromRGBO(49, 45, 45, 1),
      ),
      child: const Center(
          child: Text(
        'Para poder ver las indirectas de tus amigos es necesario que subas tu indirecta diaria.',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Color.fromRGBO(255, 255, 255, 1),
          fontFamily: 'Plus Jakarta Sans',
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
      )),
    );
  }

  Container indirectasStories() {
    return Container(
      height: 30.h,
      width: 100.w,
      child: indirectas.length > 0
          ? ListView.builder(
              itemCount: indirectas.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                Usuario? usuario = null;
                void initState() async {
                  usuario = await Conexion.consultarUsuario(
                      indirectas[index].idUsuario);
                }

                initState();

                return indirecta(
                  fecha: indirectas[index].fechaPublicacion.toIso8601String(),
                  mensaje: indirectas[index].mensaje,
                  usuario: usuario!,
                  usuario_actual: usuario_actual,
                );
              },
            )
          : Center(
              child: Text(
                "No hay indirectas",
                style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
              ),
            ),
    );
  }
}
