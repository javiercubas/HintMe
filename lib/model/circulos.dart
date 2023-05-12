import 'package:HintMe/model/bbdd.dart';

class Circulo {
  int id;
  String nombre;
  String foto;
  bool temasPropios;
  bool privacidad;
  bool anonimato;
  DateTime fechaCreacion;
  DateTime? fechaEliminacion;
  int idCreador;

  Circulo({
    required this.id,
    required this.nombre,
    required this.foto,
    required this.temasPropios,
    required this.privacidad,
    required this.anonimato,
    required this.fechaCreacion,
    this.fechaEliminacion,
    required this.idCreador,
  });

  factory Circulo.fromJson(Map<String, dynamic> json) {
    return Circulo(
      id: json['id'],
      nombre: json['nombre'],
      foto: json['foto'],
      temasPropios: json['temas_propios'],
      privacidad: json['privacidad'],
      anonimato: json['anonimato'],
      fechaCreacion: DateTime.parse(json['fecha_creacion']),
      fechaEliminacion: DateTime.parse(json['fecha_eliminacion']),
      idCreador: json['id_creador'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'foto': foto,
      'temas_propios': temasPropios,
      'privacidad': privacidad,
      'anonimato': anonimato,
      'fecha_creacion': fechaCreacion.toIso8601String(),
      'fecha_eliminacion': fechaEliminacion?.toIso8601String(),
      'id_creador': idCreador,
    };
  }

  // función estática que devuelve una lista de círculos a los que pertenece un usuario concreto con un número máximo de círculos
  static Future<List<Circulo>> getCirculosUsuario(
      int idUsuario, int numeroMaximoCirculos) async {
    final conexion = await Conexion.conectar();

    final resultado = await conexion.query(
      'SELECT * FROM circulos WHERE id_creador = ? AND fecha_eliminacion IS NULL LIMIT ?',
      [idUsuario, numeroMaximoCirculos],
    );

    await conexion.close();
    List<Circulo> circulos = [];
    for (var circulo in resultado) {
      final circulo_ = Circulo(
          id: circulo["id"],
          anonimato: circulo["anonimato"] == 1 ? true : false,
          fechaCreacion: circulo["fecha_creacion"],
          fechaEliminacion: circulo["fecha_eliminacion"] == null
              ? null
              : circulo["fecha_eliminacion"],
          foto: circulo["foto"],
          idCreador: circulo["id_creador"],
          nombre: circulo["nombre"],
          privacidad: circulo["privacidad"] == 1 ? true : false,
          temasPropios: circulo["temas_propios"] == 1 ? true : false);
      circulos.add(circulo_);
    }
    return circulos;
  }
}
