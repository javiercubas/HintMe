import 'dart:convert';

import 'package:HintMe/components/avatar.dart';
import 'package:HintMe/model/mensajes.dart';
import 'package:HintMe/model/usuario.dart';
import 'package:HintMe/model/usuarios_mensajes.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:shared_preferences/shared_preferences.dart';

class ConversacionPage extends StatefulWidget {
  const ConversacionPage(
      {Key? key, required this.usuario_actual, required this.usuario})
      : super(key: key);
  final Usuario usuario_actual;
  final Usuario usuario;

  @override
  _ConversacionPageState createState() => _ConversacionPageState();
}

class _ConversacionPageState extends State<ConversacionPage> {
  late IO.Socket _socket;
  Mensaje? answer = null;
  final meses = [
    '',
    'enero',
    'febrero',
    'marzo',
    'abril',
    'mayo',
    'junio',
    'julio',
    'agosto',
    'septiembre',
    'octubre',
    'noviembre',
    'diciembre'
  ];
  final _focusNode = FocusNode();

  @override
  void dispose() {
    _socket.disconnect(); // disconnect the socket
    _socket.close(); // close the socket
    _socket.clearListeners(); // remove all socket listeners
    _socket.destroy(); // destroy the socket
    _socket.dispose(); // dispose the socket connection
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString('draft', textEditingController.text.trim());
      prefs.setString('answer', json.encode(answer));
    });
    textEditingController.dispose(); // dispose the text editing controller
    _focusNode.dispose(); // dispose the focus node
    _scrollController.dispose(); // dispose the scroll controller
    super.dispose(); // llamando a dispose() en la clase base
  }

  void _showDeleteDialog(Mensaje mensaje) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Eliminar mensaje'),
        content: Text('¿Seguro que desea eliminar este mensaje?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              await Mensaje.borrarMensaje(mensaje.idMensaje);
              setState(() {
                mensajes.remove(mensaje);
              });
              Navigator.pop(context);
            },
            child: Text('Eliminar'),
          ),
        ],
      ),
    );
  }

  _connectSocket() {
    _socket.onConnect((data) => print("Conectado $data"));
    _socket.onConnectError((data) => print("Error $data"));
    _socket.onDisconnect((data) => print("Desconectado"));
    _socket.on("message", (data) {
      print(data);
      print(mensajes[0].mensaje);
      print(data["sender"] == widget.usuario.id.toString());
      if (data["sender"] == widget.usuario.id.toString()) {
        print(data);
        setState(() {
          mensajes.add(Mensaje(
            idMensaje: mensajes.length + 1,
            idEmisor: data["sender"],
            idReceptor: data["receiver"],
            mensaje: data["message"],
            fechaEnvio: data["sentAt"],
          ));
        });
      }
    });
    _socket.on("typing", (data) {
      setState(() {
        _isWriting = data["isTyping"];
      });
    });

    // escuchar el evento connectedUsers
    _socket.on('connectedUsers', (data) {
      print(List<String>.from(data));
    });
  }

  _sendMessage() {
    if (!mounted) return; // check if the widget is still in the tree
    _socket.emit("message", {
      "message": textEditingController.text.trim(),
      "sender": widget.usuario_actual.id,
      "receiver": widget.usuario.id,
      "sentAt": DateTime.now().toString(),
    });
  }

  TextEditingController textEditingController = TextEditingController();
  List<Mensaje> mensajes = [];
  ScrollController _scrollController = ScrollController();
  bool _isWriting = false;

  @override
  void initState() {
    super.initState();

    _socket = IO.io(
        "http://192.168.1.99:3000",
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .setQuery({
              "id": widget.usuario_actual.id.toString(),
              "id_destinatario": widget.usuario.id.toString()
            })
            .disableAutoConnect()
            .build());

    _socket.connect();

    _connectSocket();
    _initState();
    // si abro el teclado, se mueve el scroll al final para ver el ultimo mensaje
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.offset) {
        _scrollController.animateTo(_scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
      }
    });
  }

  Future<void> _initState() async {
    await SharedPreferences.getInstance().then((prefs) {
      final draft = prefs.getString('draft');
      final _answer = prefs.getString('answer');
      if (draft != null) {
        setState(() {
          textEditingController.text = draft;
        });
      }
      if (_answer != null) {
        final Mensaje? _answer2 = json.decode(_answer);
        setState(() {
          answer = Mensaje(
            idMensaje: _answer2?.idMensaje ?? 0,
            idEmisor: _answer2?.idEmisor ?? 0,
            idReceptor: _answer2?.idReceptor ?? 0,
            mensaje: _answer2?.mensaje ?? "",
            fechaEnvio: _answer2?.fechaEnvio ?? DateTime.now(),
          );
        });
      }
    });

    await UsuarioMensaje.getMensajes(
            widget.usuario_actual.id, widget.usuario.id)
        .then((value) => {
              setState(() {
                mensajes = value;
              })
            });

    await Mensaje.actualizarFechaLectura(
        widget.usuario_actual.id, widget.usuario.id);

    await Usuario.consultarEnLinea(widget.usuario.id).then((value) => {
          setState(() {
            widget.usuario.en_linea = value;
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 39, 36, 36),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 39, 36, 36),
          elevation: 0,
          title: Row(children: [
            Avatar(border: true, image: widget.usuario.avatar!, size: 6.h),
            Gap(5.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.usuario.user,
                  style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),
                ),
                Text(
                  widget.usuario.en_linea ? "En linea" : "Desconectado",
                  style: TextStyle(
                      fontSize: 12.sp,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w400),
                ),
              ],
            )
          ]),
          toolbarHeight: 8.h,
        ),
        body: Container(
          padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 2.h),
          child: Stack(
            children: [
              ListView.builder(
                itemCount: mensajes.length,
                controller: _scrollController,
                reverse: true,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  final mensaje = mensajes[index];
                  final isMensajeActual =
                      mensaje.idEmisor == widget.usuario_actual.id;

                  // Obtener la fecha del mensaje actual y del siguiente mensaje (si existe)
                  final fechaMensaje = mensaje.fechaEnvio;
                  final fechaSiguienteMensaje = index < mensajes.length - 1
                      ? mensajes[index + 1].fechaEnvio
                      : null;

                  // Verificar si es el primer mensaje del día
                  final esPrimerMensajeDelDia = fechaSiguienteMensaje == null ||
                      fechaMensaje.year != fechaSiguienteMensaje.year ||
                      fechaMensaje.month != fechaSiguienteMensaje.month ||
                      fechaMensaje.day != fechaSiguienteMensaje.day;

                  // Si es el primer mensaje del día, mostrar la fecha
                  final fecha = esPrimerMensajeDelDia
                      ? '${fechaMensaje.day} de ${meses[fechaMensaje.month - 1]}'
                      : null;

                  Mensaje? mensaje_respondido = null;
                  if (mensaje.idMensaje_respondido != null) {
                    int i = 0;
                    while (mensaje_respondido == null && i < mensajes.length) {
                      if (mensaje.idMensaje_respondido ==
                          mensajes[i].idMensaje) {
                        mensaje_respondido = mensajes[i];
                      } else {
                        i++;
                      }
                    }
                  }

                  return GestureDetector(
                      onLongPress: () =>
                          mensaje.idEmisor == widget.usuario_actual.id
                              ? _showDeleteDialog(mensaje)
                              : null,
                      onHorizontalDragEnd: (details) {
                        if ((details.primaryVelocity?.toDouble() ?? 0.0) >
                            0.0) {
                          // User swiped Right
                          setState(() {
                            answer = mensaje;
                          });
                          _focusNode.requestFocus();
                        } else if ((details.primaryVelocity?.toDouble() ??
                                0.0) <
                            0) {
                          // User swiped Left
                        }
                      },
                      child: Column(
                        crossAxisAlignment: isMensajeActual
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: [
                          if (fecha != null) ...[
                            // Mostrar la fecha si es el primer mensaje del día
                            Container(
                              width: 100.w,
                              child: Center(
                                child: Text(
                                  fecha,
                                  style: TextStyle(
                                    color: Colors.grey[500],
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 8.0),
                          ],
                          mensaje.idMensaje_respondido != null
                              ? Row(
                                  mainAxisAlignment: isMensajeActual
                                      ? MainAxisAlignment.end
                                      : MainAxisAlignment.start,
                                  children: [
                                    Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Color.fromRGBO(
                                                49, 45, 45, 0.9)),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 5.w,
                                          vertical: 1.h,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Ha respondido a",
                                              style: TextStyle(
                                                  color: Colors.white54,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Gap(1.h),
                                            Text(
                                              mensaje_respondido?.mensaje ??
                                                  "El mensaje ha sido eliminado",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ],
                                        )),
                                    Gap(1.w),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.white30,
                                      ),
                                      width: 1.w,
                                      height: 7.h,
                                    ),
                                  ],
                                )
                              : Container(),
                          Row(
                            mainAxisAlignment: isMensajeActual
                                ? MainAxisAlignment.end
                                : MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              isMensajeActual ? Container() : Gap(2.w),
                              isMensajeActual
                                  ? Container()
                                  : Avatar(
                                      border: false,
                                      image: widget.usuario.avatar!,
                                      size: 5.h),
                              Gap(3.w),
                              Container(
                                decoration: BoxDecoration(
                                  color: isMensajeActual
                                      ? Color.fromARGB(255, 103, 58, 183)
                                      : Color.fromARGB(255, 49, 45,
                                          45), // Color del mensaje del otro usuario
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                constraints: BoxConstraints(
                                  maxWidth: 70.w,
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 4.w, vertical: 2.h),
                                margin: EdgeInsets.only(top: 1.h),
                                child: Text(
                                  mensaje.mensaje,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: isMensajeActual
                                ? MainAxisAlignment.end
                                : MainAxisAlignment.start,
                            children: [
                              Gap(18.w),
                              Text(
                                mensaje.fechaEnvio
                                    .toUtc()
                                    .toIso8601String()
                                    .substring(11, 16),
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.grey[400],
                                ),
                              ),
                            ],
                          ),
                          Gap(index == 0 ? 11.h : 1.h)
                        ],
                      ));
                },
              ),
              Positioned(
                bottom: 2.h,
                child: Column(
                  children: [
                    answer != null
                        ? Container(
                            width: 90.w,
                            padding: EdgeInsets.symmetric(
                                vertical: 2.h, horizontal: 5.w),
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(49, 45, 45, 0.9),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    topRight: Radius.circular(12))),
                            child: Stack(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      answer!.idEmisor ==
                                              widget.usuario_actual.id
                                          ? "Estas respondiendo a un mensaje de ${widget.usuario_actual.user}"
                                          : "Estas respondiendo a un mensaje de ${widget.usuario.user}",
                                      style: TextStyle(
                                          color: Colors.white54,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Gap(1.h),
                                    Text(
                                      answer!.mensaje,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                                Positioned(
                                    right: 0,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          answer = null;
                                        });
                                      },
                                      child: Icon(
                                        Icons.close,
                                        color: Colors.white,
                                        size: 15.sp,
                                      ),
                                    ))
                              ],
                            ),
                          )
                        : Container(),
                    Container(
                      width: 90.w,
                      height: 7.h,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 49, 45, 45),
                        borderRadius: answer != null
                            ? BorderRadius.only(
                                bottomLeft: Radius.circular(12),
                                bottomRight: Radius.circular(12))
                            : BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 80.w,
                            padding: EdgeInsets.only(left: 5.w),
                            child: TextField(
                              focusNode: _focusNode,
                              controller: textEditingController,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w400,
                              ),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Escribe un mensaje...",
                                  hintStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w400,
                                  )),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              if (textEditingController.text.isNotEmpty) {
                                _sendMessage();

                                await UsuarioMensaje.insertarMensaje(
                                    widget.usuario_actual.id,
                                    widget.usuario.id,
                                    textEditingController.text.trim(),
                                    answer != null ? answer!.idMensaje : null);
                                setState(() {
                                  mensajes.insert(
                                      0,
                                      (Mensaje(
                                          idMensaje: mensajes.length > 0
                                              ? mensajes[mensajes.length - 1]
                                                      .idMensaje +
                                                  1
                                              : 1,
                                          idEmisor: widget.usuario_actual.id,
                                          idReceptor: widget.usuario.id,
                                          idMensaje_respondido: answer != null
                                              ? answer?.idMensaje
                                              : null,
                                          mensaje: textEditingController.text,
                                          fechaEnvio: DateTime.now())));
                                });

                                if (answer != null) {
                                  setState(() {
                                    answer = null;
                                  });
                                }
                                textEditingController.clear();
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.only(right: 5.w),
                              width: 8.w,
                              child: Icon(
                                Icons.send,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
