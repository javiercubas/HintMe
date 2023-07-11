import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

class GrupoPage extends StatefulWidget {
  const GrupoPage({Key? key}) : super(key: key);

  @override
  _GrupoPageState createState() => _GrupoPageState();
}

class _GrupoPageState extends State<GrupoPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ubicacionController = TextEditingController();
  TextEditingController descripcionController = TextEditingController();
  TextEditingController etiquetasController = TextEditingController();

  int maxNameLength = 20;
  int maxUbicacionLength = 30;
  int maxDescripcionLength = 200;
  int maxEtiquetasLength = 10;

  List<Map<String, dynamic>> members = [
    {
      'img':
          'https://pps.whatsapp.net/v/t61.24694-24/349097925_485471047078699_1026749108030812927_n.jpg?ccb=11-4&oh=01_AdSmmFffGP2FRMpqs_iSNKsBI-AcKlGr5TVb1SukWNP7Dw&oe=64BAB22E',
      'name': 'Javier Cubas',
      'type': 1,
    },
    {
      'img':
          'https://pps.whatsapp.net/v/t61.24694-24/349097925_485471047078699_1026749108030812927_n.jpg?ccb=11-4&oh=01_AdSmmFffGP2FRMpqs_iSNKsBI-AcKlGr5TVb1SukWNP7Dw&oe=64BAB22E',
      'name': 'Javier Cubas',
      'type': 1,
    },
    {
      'img':
          'https://pps.whatsapp.net/v/t61.24694-24/349097925_485471047078699_1026749108030812927_n.jpg?ccb=11-4&oh=01_AdSmmFffGP2FRMpqs_iSNKsBI-AcKlGr5TVb1SukWNP7Dw&oe=64BAB22E',
      'name': 'Javier Cubas',
      'type': 1,
    },
    {
      'type': 2,
    },
  ];

  void removeMember(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Eliminar miembro'),
          content: Text(
            '¿Estás seguro de que quieres eliminar a ${members[index]['name']} del grupo?',
          ),
          actions: [
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el diálogo
              },
            ),
            TextButton(
              child: Text('Eliminar'),
              onPressed: () {
                setState(() {
                  members.removeAt(index);
                });
                Navigator.of(context).pop(); // Cierra el diálogo
              },
            ),
          ],
        );
      },
    );
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Descartar cambios'),
            content: Text('¿Deseas descartar los cambios realizados?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('Sí'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  void dispose() {
    // Rompe las referencias a los controladores de texto
    nameController.dispose();
    ubicacionController.dispose();
    descripcionController.dispose();
    etiquetasController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 39, 36, 36),
        body: Container(
          width: 100.w,
          height: 100.h,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('./assets/texture2.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: Center(
              child: Container(
                width: 90.w,
                height: 100.h,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Gap(3.h),
                      inputGrupo(
                        name: 'Nombre del grupo',
                        controller: nameController,
                        lines: 1,
                        type: 1,
                        maxLength: maxNameLength,
                      ),
                      Gap(1.h),
                      inputGrupo(
                        name: 'Ubicación del grupo',
                        controller: ubicacionController,
                        lines: 1,
                        type: 1,
                        maxLength: maxUbicacionLength,
                      ),
                      Gap(1.h),
                      inputGrupo(
                        name: 'Descripción del grupo',
                        controller: descripcionController,
                        lines: 5,
                        type: 1,
                        maxLength: maxDescripcionLength,
                      ),
                      Gap(1.h),
                      inputGrupo(name: 'Miembros', type: 2),
                      Gap(3.h),
                      inputGrupo(
                        name: 'Etiquetas del grupo',
                        controller: etiquetasController,
                        lines: 1,
                        type: 1,
                        maxLength: maxEtiquetasLength,
                      ),
                      Gap(1.h),
                      inputGrupo(
                        name: 'Fotos del grupo',
                        type: 3,
                      ),
                      Gap(3.h),
                      Container(
                        width: 100.w,
                        height: 8.h,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            'GUARDAR CAMBIOS',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              color: Color.fromARGB(255, 39, 36, 36),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
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
      ),
    );
  }

  Column inputGrupo({
    TextEditingController? controller,
    int? lines,
    required String name,
    required int type,
    int? maxLength,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name.toUpperCase(),
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            color: Colors.white,
          ),
        ),
        Gap(1.h),
        type == 1
            ? textInputGrupo(controller!, lines!, name, maxLength)
            : type == 2
                ? ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: members.length,
                    itemBuilder: (context, index) {
                      final member = members[index];
                      return GestureDetector(
                        onTap: () {
                          if (member['type'] == 1) {
                            // Realizar acción cuando se toca un miembro existente
                          } else {
                            // Realizar acción cuando se toca el botón "Añadir miembro"
                          }
                        },
                        child: miembro(
                          img: member['img'],
                          name: member['name'],
                          type: member['type'],
                          index: index,
                        ),
                      );
                    },
                  )
                : Column(
                    children: [
                      Container(
                        height: 40.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 40.h,
                              width: 44.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white,
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 19.5.h,
                                  width: 44.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.white,
                                  ),
                                ),
                                Container(
                                  height: 19.5.h,
                                  width: 44.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Gap(2.h),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white,
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 2.w, vertical: 1.h),
                        child: Container(
                          height: 10.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.photo_camera_outlined,
                                color: Color.fromARGB(255, 39, 36, 36),
                              ),
                              Text(
                                'Añadir fotos',
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromARGB(255, 39, 36, 36),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
      ],
    );
  }

  Column miembro({
    String? img,
    String? name,
    required int type,
    int? index,
  }) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white,
          ),
          padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
          child: type == 1
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 12.w,
                          height: 12.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.w),
                            border: Border.all(
                              color: Color.fromARGB(255, 103, 58, 183),
                              width: 2.0,
                            ),
                            image: DecorationImage(
                              image: NetworkImage(img!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Gap(2.w),
                        Text(
                          name!,
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(255, 39, 36, 36),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      child: IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          removeMember(index!);
                        },
                      ),
                    ),
                  ],
                )
              : Container(
                  height: 10.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.people,
                        color: Color.fromARGB(255, 39, 36, 36),
                      ),
                      Text(
                        'Añadir miembro',
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 39, 36, 36),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
        Gap(1.h),
      ],
    );
  }

  TextField textInputGrupo(
    TextEditingController controller,
    int lines,
    String name,
    int? maxLength,
  ) {
    return TextField(
      controller: controller,
      maxLines: lines,
      maxLength: maxLength,
      textAlignVertical: TextAlignVertical.top,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: Color.fromARGB(255, 103, 58, 183),
            width: 3.0,
          ),
        ),
        hintText: name,
        counterStyle: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
