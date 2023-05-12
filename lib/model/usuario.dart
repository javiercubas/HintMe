import 'package:HintMe/model/bbdd.dart';

class Usuario {
  int id;
  String user;
  String correo;
  String? contrasena;
  DateTime fechaRegistro;
  bool en_linea;
  DateTime? ultimaConexion;
  String nombre;
  String? avatar;
  DateTime? fechaNacimiento;
  String biografia;
  bool anonimo;
  bool privado;
  DateTime? fechaDesactivacion;
  int idRol;

  Usuario({
    required this.id,
    required this.user,
    required this.correo,
    this.contrasena,
    required this.fechaRegistro,
    required this.en_linea,
    this.ultimaConexion,
    required this.nombre,
    this.avatar,
    required this.fechaNacimiento,
    required this.biografia,
    required this.anonimo,
    required this.privado,
    required this.fechaDesactivacion,
    required this.idRol,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        id: json["id"],
        user: json["user"],
        correo: json["correo"],
        fechaRegistro: DateTime.parse(json["fecha_registro"]),
        en_linea: json["en_linea"] == 1 ? true : false,
        ultimaConexion: json["ultima_conexion"] != null
            ? DateTime.parse(json["ultima_conexion"])
            : null,
        nombre: json["nombre"],
        avatar: json["avatar"],
        fechaNacimiento: json["fecha_nacimiento"] != null
            ? DateTime.parse(json["fecha_nacimiento"])
            : null,
        biografia: json["biografia"],
        anonimo: json["anonimo"] == 1 ? true : false,
        privado: json["privado"] == 1 ? true : false,
        fechaDesactivacion: json["fecha_desactivacion"] != null
            ? DateTime.parse(json["fecha_desactivacion"])
            : null,
        idRol: json["id_rol"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user,
        "correo": correo,
        "fecha_registro": fechaRegistro.toIso8601String(),
        "en_linea": en_linea == true ? 1 : 0,
        "ultima_conexion":
            ultimaConexion != null ? ultimaConexion?.toIso8601String() : null,
        "nombre": nombre,
        "avatar": avatar,
        "fecha_nacimiento":
            fechaNacimiento != null ? fechaNacimiento?.toIso8601String() : null,
        "biografia": biografia,
        "anonimo": anonimo == true ? 1 : 0,
        "privado": privado == true ? 1 : 0,
        "fecha_desactivacion": fechaDesactivacion != null
            ? fechaDesactivacion?.toIso8601String()
            : null,
        "id_rol": idRol,
      };

  // funcion estatica para actualizar el estado de en linea de un usuario
  static Future<void> actualizarEnLinea(int idUsuario, bool enLinea) async {
    final conexion = await Conexion.conectar();

    await conexion.query(
      'UPDATE usuarios SET en_linea = ? WHERE id = ?',
      [enLinea, idUsuario],
    );

    await Conexion.desconectar();
  }

  // funcion estatica para consultar el estado de en linea de un usuario
  static Future<bool> consultarEnLinea(int idUsuario) async {
    final conexion = await Conexion.conectar();

    final resultado = await conexion.query(
      'SELECT en_linea FROM usuarios WHERE id = ?',
      [idUsuario],
    );

    await Conexion.desconectar();

    return resultado.first[0] == 1 ? true : false;
  }
}
