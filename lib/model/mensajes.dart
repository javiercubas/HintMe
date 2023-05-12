import 'package:HintMe/model/bbdd.dart';

class Mensaje {
  int idMensaje;
  int idEmisor;
  int idReceptor;
  int? idMensaje_respondido;
  String mensaje;
  DateTime fechaEnvio;
  DateTime? fechaLectura;
  DateTime? fechaEliminacion;

  Mensaje(
      {required this.idMensaje,
      required this.idEmisor,
      required this.idReceptor,
      this.idMensaje_respondido,
      required this.mensaje,
      required this.fechaEnvio,
      this.fechaLectura,
      this.fechaEliminacion});

  factory Mensaje.fromJson(Map<String, dynamic> json) {
    return Mensaje(
      idMensaje: json['id_mensaje'],
      idEmisor: json['id_emisor'],
      idReceptor: json['id_receptor'],
      mensaje: json['mensaje'],
      fechaEnvio: DateTime.parse(json['fecha_envio']),
      fechaLectura: json['fecha_lectura'] != null
          ? DateTime.parse(json['fecha_lectura'])
          : null,
      fechaEliminacion: json['fecha_eliminacion'] != null
          ? DateTime.parse(json['fecha_eliminacion'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_mensaje'] = this.idMensaje;
    data['mensaje'] = this.mensaje;
    data['fecha_envio'] = this.fechaEnvio.toIso8601String();
    data['fecha_lectura'] =
        this.fechaLectura != null ? this.fechaLectura!.toIso8601String() : null;
    data['fecha_eliminacion'] = this.fechaEliminacion != null
        ? this.fechaEliminacion!.toIso8601String()
        : null;
    return data;
  }

  // funcion estatica para actualizar la fecha de lectura de los mensajes no leidos de una conversacion
  static Future<void> actualizarFechaLectura(
      int idUsuario, int idReceptor) async {
    try {
      final conexion = await Conexion.conectar();
      await conexion.query(
          'UPDATE mensajes JOIN usuarios_mensajes ON mensajes.id_mensaje = usuarios_mensajes.id_mensaje SET fecha_lectura = NOW() WHERE id_emisor = ? AND id_receptor = ? AND fecha_lectura IS NULL',
          [idReceptor, idUsuario]);
      await conexion.close();
    } catch (e) {
      print('Error while updating database: $e');
    }
  }

  // funcion estatica para borrar(actualizar fecha_eliminacion) un mensaje
  static Future<void> borrarMensaje(int idMensaje) async {
    try {
      final conexion = await Conexion.conectar();
      await conexion.query(
          'UPDATE mensajes SET fecha_eliminacion = NOW() WHERE id_mensaje = ?',
          [idMensaje]);
      await conexion.close();
    } catch (e) {
      print('Error while updating database: $e');
    }
  }

  // funcion estatica para borrar(actualizar fecha_eliminacion) los mensajes de una conversacion
  static Future<void> borrarMensajes(int idUsuario, int idReceptor) async {
    try {
      final conexion = await Conexion.conectar();
      await conexion.query(
          'UPDATE mensajes JOIN usuarios_mensajes ON mensajes.id_mensaje = usuarios_mensajes.id_mensaje SET fecha_eliminacion = NOW() WHERE (id_emisor = ? AND id_receptor = ?) OR (id_emisor = ? AND id_receptor = ?)',
          [idUsuario, idReceptor, idReceptor, idUsuario]);
      await conexion.close();
    } catch (e) {
      print('Error while updating database: $e');
    }
  }
}
