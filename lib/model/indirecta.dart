import 'package:HintMe/model/bbdd.dart';

class IndirectaModel {
  int id;
  String mensaje;
  DateTime fechaPublicacion;
  DateTime? fechaEliminacion;
  int idUsuario;
  int idTema;
  int idCirculo;

  IndirectaModel({
    required this.id,
    required this.mensaje,
    required this.fechaPublicacion,
    this.fechaEliminacion,
    required this.idUsuario,
    required this.idTema,
    required this.idCirculo,
  });

  factory IndirectaModel.fromJson(Map<String, dynamic> json) {
    return IndirectaModel(
      id: json['id'],
      mensaje: json['mensaje'],
      fechaPublicacion: DateTime.parse(json['fecha_publicacion']),
      fechaEliminacion: json['fecha_eliminacion'] == null
          ? null
          : DateTime.parse(json['fecha_eliminacion']),
      idUsuario: json['id_usuario'],
      idTema: json['id_tema'],
      idCirculo: json['id_circulo'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['mensaje'] = this.mensaje;
    data['fecha_publicacion'] = this.fechaPublicacion.toIso8601String();
    data['fecha_eliminacion'] = this.fechaEliminacion == null
        ? null
        : this.fechaEliminacion!.toIso8601String();
    data['id_usuario'] = this.idUsuario;
    data['id_tema'] = this.idTema;
    data['id_circulo'] = this.idCirculo;
    return data;
  }

  // función estática que devuelve el número de indirectas publicadas por un usuario concreto
  static Future<int> getNumeroIndirectasPublicadasPorUsuario(
      int idUsuario) async {
    final conexion = await Conexion.conectar();

    final resultado = await conexion.query(
      'SELECT COUNT(*) FROM indirectas WHERE id_usuario = ? AND fecha_eliminacion IS NULL',
      [idUsuario],
    );

    await conexion.close();
    int numeroIndirectas = 0;
    if (resultado.isNotEmpty) {
      final row = resultado.first;
      numeroIndirectas = row[0];
    }
    return numeroIndirectas;
  }

  // función estática que devuelve la lista de indirectas publicadas por un usuario concreto
  static Future<List<IndirectaModel>> getIndirectasPublicadasPorUsuario(
      int idUsuario) async {
    final conexion = await Conexion.conectar();

    final resultado = await conexion.query(
      'SELECT id_usuario, mensaje, fecha_publicacion FROM indirectas WHERE id_usuario = ? AND fecha_eliminacion IS NULL ORDER BY fecha_publicacion DESC',
      [idUsuario],
    );

    await conexion.close();
    List<IndirectaModel> listaIndirectas = [];
    if (resultado.isNotEmpty) {
      for (final row in resultado) {
        listaIndirectas.add(IndirectaModel(
          id: 0,
          mensaje: row[1],
          fechaPublicacion: row[2] as DateTime,
          fechaEliminacion: null,
          idUsuario: row[0],
          idTema: 0,
          idCirculo: 0,
        ));
      }
    }
    return listaIndirectas;
  }

  // función estatica que devuelve el número de indirectas publicadas por un usuario hoy
  static Future<int> getNumeroIndirectasPublicadasPorUsuarioHoy(
      int idUsuario) async {
    final conexion = await Conexion.conectar();

    final resultado = await conexion.query(
      'SELECT COUNT(*) FROM indirectas WHERE id_usuario = ? AND fecha_publicacion >= DATE_SUB(NOW(), INTERVAL 1 DAY) AND fecha_eliminacion IS NULL',
      [idUsuario],
    );

    await conexion.close();
    int numeroIndirectas = 0;
    if (resultado.isNotEmpty) {
      final row = resultado.first;
      numeroIndirectas = row[0];
    }
    return numeroIndirectas;
  }

  // Función estática que devuelve la lista de indirectas publicadas por los seguidos de un usuario ordenadas por fecha de publicación
  static Future<List<IndirectaModel>> getIndirectasSeguidos(
      int idUsuario) async {
    final conexion = await Conexion.conectar();

    final resultado = await conexion.query(
      'SELECT id_usuario, mensaje, fecha_publicacion FROM indirectas WHERE id_usuario IN (SELECT id_seguido FROM seguidores WHERE id_seguidor = ? AND fecha_unfollow IS NULL AND (aceptada = 1 or fecha_solicitud IS NULL)) AND fecha_eliminacion IS NULL ORDER BY fecha_publicacion DESC',
      [idUsuario],
    );

    await conexion.close();
    List<IndirectaModel> listaIndirectas = [];
    if (resultado.isNotEmpty) {
      for (final row in resultado) {
        listaIndirectas.add(IndirectaModel(
          id: 0,
          mensaje: row[1],
          fechaPublicacion: row[2] as DateTime,
          fechaEliminacion: null,
          idUsuario: row[0],
          idTema: 0,
          idCirculo: 0,
        ));
      }
    }
    return listaIndirectas;
  }
}
