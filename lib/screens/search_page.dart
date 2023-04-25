import 'package:HintMe/components/avatar.dart';
import 'package:HintMe/model/bbdd.dart';
import 'package:HintMe/model/usuario.dart';
import 'package:HintMe/screens/home.dart';
import 'package:HintMe/screens/perfil.dart';
import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import 'package:sizer/sizer.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key, required this.usuario_actual}) : super(key: key);
  final Usuario usuario_actual;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String name = "";
  List<Usuario> usuarios = [];
  Usuario? usuario_actual;

  Future<void> buscarUsuarios() async {
    if (name.isNotEmpty) {
      try {
        usuarios = await Conexion.buscarUsuarios(name);
      } on MySqlException catch (e) {
        print(e.message);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Ocurrió un error al buscar los usuarios')));
      }
    } else {
      setState(() {
        usuarios.clear();
      });
    }
  }

  void initState() {
    super.initState();
    usuario_actual = widget.usuario_actual;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 39, 36, 36),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 39, 36, 36),
        elevation: 0,
        title: Card(
          color: Color.fromRGBO(49, 45, 45, 1),
          child: TextField(
            onChanged: (value) {
              setState(() {
                name = value;
              });
              buscarUsuarios();
            },
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              hintText: 'Buscar usuario',
              hintStyle: TextStyle(color: Colors.white),
              border: InputBorder.none,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: ListView.builder(
          itemCount: usuarios.length,
          itemBuilder: (context, index) {
            final usuario = usuarios[index];
            return ListTile(
              leading: Avatar(
                border: true,
                image: usuario.avatar!,
                size: 5.h,
              ),
              title: Text(
                usuario.nombre,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                usuario.correo ?? "",
                style: TextStyle(
                  color: Colors.white.withOpacity(0.6),
                ),
              ),
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
        ),
      ),
    );
  }
}
