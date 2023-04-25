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
      temasPropios: json['temas_propios'].cast<int>(),
      privacidad: json['privacidad'].cast<int>(),
      anonimato: json['anonimato'].cast<int>(),
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
}
