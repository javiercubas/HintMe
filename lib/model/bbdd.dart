import 'dart:async';
import 'package:HintMe/model/usuario.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mysql1/mysql1.dart';

class Conexion {
  static MySqlConnection? conexion;

  static Future<MySqlConnection> conectar() async {
    final settings = ConnectionSettings(
      host: dotenv.env['DB_HOST']!,
      port: int.parse(dotenv.env['DB_PORT']!),
      user: dotenv.env['DB_USER'],
      password: dotenv.env['DB_PASSWORD'],
      db: dotenv.env['DB_NAME'],
    );

    conexion = await MySqlConnection.connect(settings);
    print(conexion);
    return conexion!;
  }

  static Future<void> desconectar() async {
    await conexion!.close();
  }

  static Future<Usuario?> login(String usuario, String contrasena) async {
    final conexion = await Conexion.conectar();

    final resultados = await conexion.query(
      'SELECT * FROM usuarios WHERE correo = ? AND contraseña = MD5(?)',
      [usuario, contrasena],
    );

    await Conexion.desconectar();

    if (resultados.isNotEmpty) {
      final row = resultados.first;
      return Usuario(
        id: row['id'],
        user: row['user'],
        correo: row['correo'],
        fechaRegistro: row['fecha_registro'] as DateTime,
        en_linea: row['en_linea'] == 1,
        ultimaConexion: row['ultima_conexion'] as DateTime?,
        nombre: row['nombre'],
        avatar: row['avatar'],
        fechaNacimiento: row['fecha_nacimiento'] as DateTime?,
        biografia: row['biografia'],
        anonimo: row['anonimo'] == 1,
        privado: row['privado'] == 1,
        fechaDesactivacion: row['fecha_desactivacion'] as DateTime?,
        idRol: row['id_rol'],
      );
    }

    return null;
  }

  static Future<void> registrarUsuario(Usuario usuario) async {
    final conexion = await Conexion.conectar();

    final resultados = await conexion.query(
        'INSERT INTO usuarios (user, correo, contraseña, fecha_registro, nombre, avatar, fecha_nacimiento, biografia, id_rol) VALUES (?, ?, MD5(?), NOW(), ?, ?, ?, ?, ?)',
        [
          usuario.user,
          usuario.correo,
          usuario.contrasena,
          usuario.nombre,
          usuario.avatar,
          usuario.fechaNacimiento,
          usuario.biografia,
          usuario.idRol
        ]);

    if (resultados.affectedRows! > 0) {
      print('Usuario registrado correctamente');
    } else {
      print('Error al registrar usuario');
    }

    await Conexion.desconectar();
  }

  static Future<void> actualizarUsuario(Usuario usuario) async {
    final conexion = await Conexion.conectar();

    final resultados = await conexion.query(
        'UPDATE usuarios SET user = ?, correo = ?, nombre = ?, avatar = ?, fecha_nacimiento = ?, biografia = ?, id_rol = ? WHERE id = ?',
        [
          usuario.user,
          usuario.correo,
          usuario.nombre,
          usuario.avatar,
          usuario.fechaNacimiento,
          usuario.biografia,
          usuario.idRol,
          usuario.id
        ]);

    if (resultados.affectedRows! > 0) {
      print('Usuario actualizado correctamente');
    } else {
      print('Error al actualizar usuario');
    }

    await Conexion.desconectar();
  }

  static Future<List<Usuario>> buscarUsuarios(String name) async {
    final conexion = await Conexion.conectar();

    final resultados = await conexion.query(
      'SELECT * FROM usuarios WHERE nombre LIKE ? OR correo LIKE ? OR user LIKE ?',
      ['%$name%', '%$name%', '%$name%'],
    );

    await Conexion.desconectar();

    List<Usuario> usuarios = resultados
        .map((row) => Usuario(
              id: row['id'],
              user: row['user'],
              correo: row['correo'],
              fechaRegistro: row['fecha_registro'] as DateTime,
              en_linea: row['en_linea'] == 1,
              ultimaConexion: row['ultima_conexion'] as DateTime?,
              nombre: row['nombre'],
              avatar: row['avatar'],
              fechaNacimiento: row['fecha_nacimiento'] as DateTime?,
              biografia: row['biografia'],
              anonimo: row['anonimo'] == 1,
              privado: row['privado'] == 1,
              fechaDesactivacion: row['fecha_desactivacion'] as DateTime?,
              idRol: row['id_rol'],
            ))
        .toList();
    return usuarios;
  }

  static Future<Usuario?> consultarUsuario(int id) async {
    final conexion = await Conexion.conectar();

    final resultados = await conexion.query(
      'SELECT * FROM usuarios WHERE id = ?',
      [id],
    );

    await Conexion.desconectar();

    if (resultados.isNotEmpty) {
      final row = resultados.first;
      return Usuario(
        id: row['id'],
        user: row['user'],
        correo: row['correo'],
        fechaRegistro: row['fecha_registro'] as DateTime,
        en_linea: row['en_linea'] == 1,
        ultimaConexion: row['ultima_conexion'] as DateTime?,
        nombre: row['nombre'],
        avatar: row['avatar'],
        fechaNacimiento: row['fecha_nacimiento'] as DateTime?,
        biografia: row['biografia'],
        anonimo: row['anonimo'] == 1,
        privado: row['privado'] == 1,
        fechaDesactivacion: row['fecha_desactivacion'] as DateTime?,
        idRol: row['id_rol'],
      );
    } else {
      return null;
    }
  }
}
