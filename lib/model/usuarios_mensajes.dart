import 'package:HintMe/model/bbdd.dart';
import 'package:HintMe/model/mensajes.dart';

class UsuarioMensaje {
  int idEmisor;
  int idReceptor;
  int idMensaje;

  UsuarioMensaje({
    required this.idEmisor,
    required this.idReceptor,
    required this.idMensaje,
  });

  factory UsuarioMensaje.fromJson(Map<String, dynamic> json) {
    return UsuarioMensaje(
      idEmisor: json['id_emisor'],
      idReceptor: json['id_receptor'],
      idMensaje: json['id_mensaje'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_emisor'] = this.idEmisor;
    data['id_receptor'] = this.idReceptor;
    data['id_mensaje'] = this.idMensaje;
    return data;
  }

  // funcion estatica para obtener los mensajes de una conversacion (no borrados)
  static Future<List<Mensaje>> getMensajes(
      int idUsuario, int idReceptor) async {
    final conexion = await Conexion.conectar();

    final resultado = await conexion.query(
        'SELECT * FROM mensajes JOIN usuarios_mensajes ON mensajes.id_mensaje = usuarios_mensajes.id_mensaje WHERE ((id_emisor = ? AND id_receptor = ?) OR (id_emisor = ? AND id_receptor = ?)) AND fecha_eliminacion IS NULL ORDER BY fecha_envio DESC',
        [idUsuario, idReceptor, idReceptor, idUsuario]);

    await conexion.close();
    List<Mensaje> mensajes = [];
    if (resultado.isNotEmpty) {
      for (var row in resultado) {
        final mensaje = Mensaje(
            idMensaje: row["id_mensaje"],
            idEmisor: row["id_emisor"],
            idReceptor: row["id_receptor"],
            idMensaje_respondido: row["id_mensaje_respondido"] ?? null,
            mensaje: row["mensaje"],
            fechaEnvio: row["fecha_envio"],
            fechaLectura: row["fecha_lectura"] ?? null);

        mensajes.add(mensaje);
      }
    }
    return mensajes;
  }

  // funcion estatica para insertar un mensaje
  static Future<void> insertarMensaje(int idEmisor, int idReceptor,
      String mensaje, int? idMensaje_respondido) async {
    final conexion = await Conexion.conectar();

    final resultado = await conexion.query(
        'INSERT INTO mensajes (id_mensaje_respondido, mensaje, fecha_envio) VALUES (?, ?, NOW())',
        [idMensaje_respondido, mensaje]);

    final idMensaje = resultado.insertId;

    await conexion.query(
        'INSERT INTO usuarios_mensajes (id_emisor, id_receptor, id_mensaje) VALUES (?, ?, ?)',
        [idEmisor, idReceptor, idMensaje]);

    await conexion.close();
  }
}
