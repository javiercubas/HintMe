import 'package:HintMe/model/bbdd.dart';

class Seguidores {
  int idSeguidor;
  int idSeguido;
  DateTime fechaSuceso;
  DateTime fechaUnfollow;

  Seguidores(
      {required this.idSeguidor,
      required this.idSeguido,
      required this.fechaSuceso,
      required this.fechaUnfollow});

  // funcion estatica para obtener el numero de seguidores de un usuario
  static Future<int> getNumeroSeguidores(int idUsuario) async {
    final conexion = await Conexion.conectar();

    final resultado = await conexion.query(
        'SELECT COUNT(*) FROM seguidores WHERE id_seguido = ? AND fecha_unfollow IS NULL',
        [idUsuario]);

    await conexion.close();
    int numeroSeguidores = 0;
    if (resultado.isNotEmpty) {
      final row = resultado.first;
      numeroSeguidores = row[0];
    }
    return numeroSeguidores;
  }

  // funcion estatica para obtener el numero de usuarios que sigue un usuario
  static Future<int> getNumeroSeguidos(int idUsuario) async {
    final conexion = await Conexion.conectar();

    final resultado = await conexion.query(
        'SELECT COUNT(*) FROM seguidores WHERE id_seguidor = ? AND fecha_unfollow IS NULL',
        [idUsuario]);

    await conexion.close();
    int numeroSeguidos = 0;
    if (resultado.isNotEmpty) {
      final row = resultado.first;
      numeroSeguidos = row[0];
    }
    return numeroSeguidos;
  }

  // funcion estatica para seguir a un usuario
  static Future<void> seguirUsuario(int idUsuario, int idSeguido) async {
    final conexion = await Conexion.conectar();

    final results = await conexion.query(
      'SELECT * FROM seguidores WHERE id_seguidor = ? AND id_seguido = ?',
      [idUsuario, idSeguido],
    );

    if (results.isNotEmpty) {
      await conexion.query(
        'UPDATE seguidores SET fecha_suceso = NOW(), fecha_unfollow = null WHERE id_seguidor = ? AND id_seguido = ?',
        [idUsuario, idSeguido],
      );
    } else {
      await conexion.query(
        'INSERT INTO seguidores (id_seguidor, id_seguido, fecha_suceso) VALUES (?, ?, NOW())',
        [idUsuario, idSeguido],
      );
    }

    await Conexion.desconectar();
  }

  // funcion estatica para dejar de seguir a un usuario
  static Future<void> dejarSeguirUsuario(int idUsuario, int idSeguido) async {
    final conexion = await Conexion.conectar();

    await conexion.query(
      'UPDATE seguidores SET fecha_unfollow=NOW()  WHERE id_seguidor = ? AND id_seguido = ?',
      [idUsuario, idSeguido],
    );

    await Conexion.desconectar();
  }

  // funcion estatica para comprobar si un usuario sigue a otro
  static Future<bool> comprobarSeguidor(int idUsuario, int idSeguido) async {
    final conexion = await Conexion.conectar();

    final resultado = await conexion.query(
        'SELECT * FROM seguidores WHERE id_seguidor = ? AND id_seguido = ? AND fecha_unfollow IS NULL',
        [idUsuario, idSeguido]);

    await conexion.close();
    bool esSeguidor = false;
    if (resultado.isNotEmpty) {
      esSeguidor = true;
    }
    return esSeguidor;
  }
}
