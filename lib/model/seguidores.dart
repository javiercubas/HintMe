import 'package:HintMe/model/bbdd.dart';
import 'package:HintMe/model/usuario.dart';

class Seguidores {
  int idSeguidor;
  int idSeguido;
  DateTime fechaSuceso;
  DateTime? fechaSolicitud;
  DateTime? fecharesolucion;
  bool? aceptada;
  DateTime? fechaUnfollow;

  Seguidores(
      {required this.idSeguidor,
      required this.idSeguido,
      required this.fechaSuceso,
      this.fechaSolicitud,
      this.fecharesolucion,
      this.aceptada,
      this.fechaUnfollow});

  // funcion estatica para obtener el numero de seguidores de un usuario
  static Future<int> getNumeroSeguidores(int idUsuario) async {
    final conexion = await Conexion.conectar();

    final resultado = await conexion.query(
        'SELECT COUNT(*) FROM seguidores WHERE id_seguido = ? AND fecha_unfollow IS NULL AND (aceptada = 1 or fecha_solicitud IS NULL)',
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
        'SELECT COUNT(*) FROM seguidores WHERE id_seguidor = ? AND fecha_unfollow IS NULL AND (aceptada = 1 or fecha_solicitud IS NULL)',
        [idUsuario]);

    await conexion.close();
    int numeroSeguidos = 0;
    if (resultado.isNotEmpty) {
      final row = resultado.first;
      numeroSeguidos = row[0];
    }
    return numeroSeguidos;
  }

  // función estática para seguir a un usuario
  static Future<void> seguirUsuario(int idUsuario, int idSeguido) async {
    final conexion = await Conexion.conectar();

    final seguidoPrivado = await conexion.query(
      'SELECT privado FROM usuarios WHERE id = ?',
      [idSeguido],
    );

    if (seguidoPrivado.isEmpty) {
      // El usuario a seguir no existe
      await Conexion.desconectar();
      throw Exception("El usuario a seguir no existe");
    }

    final esPrivado = seguidoPrivado.first['privado'] == 1;

    if (esPrivado) {
      // Comprobamos si ya hay una fila en la tabla seguidores con el id_seguidor y el id_seguido
      final results = await conexion.query(
        'SELECT * FROM seguidores WHERE id_seguidor = ? AND id_seguido = ?',
        [idUsuario, idSeguido],
      );

      if (results.isNotEmpty) {
        await conexion.query(
          'UPDATE seguidores SET fecha_solicitud=NOW(), fecha_resolucion=NULL, aceptada=NULL ,fecha_unfollow=NULL WHERE id_seguidor = ? AND id_seguido = ?',
          [idUsuario, idSeguido],
        );
      } else {
        await conexion.query(
          'INSERT INTO seguidores (id_seguidor, id_seguido, fecha_suceso, fecha_solicitud, fecha_resolucion, aceptada) VALUES (?, ?, NOW(), NOW(), NULL, NULL)',
          [idUsuario, idSeguido],
        );
      }
    } else {
      // Comprobamos si ya hay una fila en la tabla seguidores con el id_seguidor y el id_seguido
      final results = await conexion.query(
        'SELECT * FROM seguidores WHERE id_seguidor = ? AND id_seguido = ?',
        [idUsuario, idSeguido],
      );

      if (results.isNotEmpty) {
        await conexion.query(
          'UPDATE seguidores SET fecha_suceso=NOW(), fecha_unfollow=NULL WHERE id_seguidor = ? AND id_seguido = ?',
          [idUsuario, idSeguido],
        );
      } else {
        await conexion.query(
          'INSERT INTO seguidores (id_seguidor, id_seguido, fecha_suceso) VALUES (?, ?, NOW())',
          [idUsuario, idSeguido],
        );
      }
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
        'SELECT * FROM seguidores WHERE id_seguidor = ? AND id_seguido = ? AND fecha_unfollow IS NULL AND (aceptada = 1 or fecha_solicitud IS NULL)',
        [idUsuario, idSeguido]);

    await conexion.close();
    bool esSeguidor = false;
    if (resultado.isNotEmpty) {
      esSeguidor = true;
    }
    return esSeguidor;
  }

  // funcion estatica para aceptar o rechazar una solicitud de seguimiento
  static Future<void> aceptarSolicitudSeguidor(
      int idUsuario, int idSeguido, bool aceptar) async {
    final conexion = await Conexion.conectar();

    if (aceptar) {
      await conexion.query(
        'UPDATE seguidores SET fecha_resolucion=NOW(), aceptada=1 WHERE id_seguidor = ? AND id_seguido = ?',
        [idUsuario, idSeguido],
      );
    } else {
      await conexion.query(
        'UPDATE seguidores SET fecha_resolucion=NOW(), aceptada=0 WHERE id_seguidor = ? AND id_seguido = ?',
        [idUsuario, idSeguido],
      );
    }

    await Conexion.desconectar();
  }

  // funcion estatica para obtener las solicitudes de seguimiento pendientes de un usuario
  static Future<List<Usuario>> getSolicitudesSeguidores(int idUsuario) async {
    final conexion = await Conexion.conectar();

    final resultado = await conexion.query(
        'SELECT * FROM seguidores WHERE id_seguido = ? AND fecha_solicitud IS NOT NULL AND fecha_resolucion IS NULL',
        [idUsuario]);

    await conexion.close();
    List<Usuario> usuarios = [];
    if (resultado.isNotEmpty) {
      for (var row in resultado) {
        final usuario = await Conexion.consultarUsuario(row['id_seguidor']);
        usuarios.add(usuario!);
      }
    }
    return usuarios;
  }

  // funcion estatica para obtener los seguidores de un usuario
  static Future<List<Usuario>> getSeguidores(int idUsuario) async {
    final conexion = await Conexion.conectar();

    final resultado = await conexion.query(
        'SELECT * FROM seguidores WHERE id_seguido = ? AND fecha_unfollow IS NULL AND (aceptada = 1 or fecha_solicitud IS NULL)',
        [idUsuario]);

    await conexion.close();
    List<Usuario> usuarios = [];
    if (resultado.isNotEmpty) {
      for (var row in resultado) {
        final usuario = await Conexion.consultarUsuario(row['id_seguidor']);
        usuarios.add(usuario!);
      }
    }
    return usuarios;
  }

  // funcion estatica para obtener los seguidos de un usuario
  static Future<List<Usuario>> getSeguidos(int idUsuario) async {
    final conexion = await Conexion.conectar();

    final resultado = await conexion.query(
        'SELECT * FROM seguidores WHERE id_seguidor = ? AND fecha_unfollow IS NULL AND (aceptada = 1 or fecha_solicitud IS NULL)',
        [idUsuario]);

    await conexion.close();
    List<Usuario> usuarios = [];
    if (resultado.isNotEmpty) {
      for (var row in resultado) {
        final usuario = await Conexion.consultarUsuario(row['id_seguido']);
        usuarios.add(usuario!);
      }
    }
    return usuarios;
  }
}
