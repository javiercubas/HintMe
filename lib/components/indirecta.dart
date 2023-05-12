import 'package:HintMe/components/avatar.dart';
import 'package:HintMe/model/usuario.dart';
import 'package:HintMe/screens/perfil.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

class indirecta extends StatelessWidget {
  const indirecta({
    super.key,
    required this.usuario,
    required this.mensaje,
    required this.fecha,
    required this.usuario_actual,
  });
  final Usuario usuario_actual;
  final Usuario usuario;
  final String mensaje;
  final String fecha;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          color: Color.fromARGB(255, 49, 45, 45)),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Avatar(
                      action: PerfilPage(
                        usuario: usuario,
                        usuario_actual: usuario_actual,
                      ),
                      border: true,
                      image: usuario.avatar!,
                      size: 5.h),
                  Gap(3.w),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PerfilPage(
                                  usuario: usuario,
                                  usuario_actual: usuario_actual,
                                ),
                              ),
                            );
                          },
                          child: Text(
                            usuario.user,
                            style: TextStyle(
                                fontSize: 15.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PerfilPage(
                                  usuario: usuario,
                                  usuario_actual: usuario_actual,
                                ),
                              ),
                            );
                          },
                          child: Text(
                            usuario.nombre,
                            style:
                                TextStyle(fontSize: 12.sp, color: Colors.white),
                          ),
                        ),
                        Gap(2.h),
                      ],
                    ),
                  ),
                ],
              ),
              Text(fecha,
                  style: TextStyle(fontSize: 12.sp, color: Colors.white))
            ],
          ),
          Container(
            padding: EdgeInsets.only(left: 13.w),
            width: 100.w,
            child: Text(mensaje,
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
