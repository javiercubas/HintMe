import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  State<CameraPage> createState() => _CameraPageState();
}

enum WidgetState { NONE, LOADING, LOADED, ERROR }

class _CameraPageState extends State<CameraPage> {
  WidgetState _widgetState = WidgetState.NONE;
  late List<CameraDescription> _cameras;
  late CameraController _cameraController;
  int device = 0;

  @override
  void initState() {
    super.initState();
    initializeCamera(0);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    switch (_widgetState) {
      case WidgetState.NONE:
      case WidgetState.LOADING:
        return buildScaffold(
            context, Center(child: CircularProgressIndicator()));
      case WidgetState.LOADED:
        return buildScaffold(
            context,
            Container(
              width: 100.w,
              height: 100.h,
              child: GestureDetector(
                onDoubleTap: () {
                  setState(() {
                    device = device == 0 ? 1 : 0;
                    initializeCamera(device);
                    print("Holaaa $device");
                  });
                },
                child: AspectRatio(
                    aspectRatio: 1 / _cameraController!.value.aspectRatio,
                    child: CameraPreview(_cameraController)),
              ),
            ));
      case WidgetState.ERROR:
        return buildScaffold(
            context,
            Center(
                child: Text(
                    "¡Ooops! Error al cargar la cámara 😩. Reinicia la apliación.")));
    }
  }

  Widget buildScaffold(BuildContext context, Widget body) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Cámara"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: body,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          try {
            _cameraController.takePicture().then((XFile? file) {
              if (mounted) {
                if (file != null) {}
              }
            });
            // Navigator.pop(context, path);
          } catch (e) {
            print("Picture $e");
          }
        },
        child: Icon(
          Icons.camera_alt,
          color: Colors.black,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Future<void> initializeCamera(int device) async {
    _widgetState = WidgetState.LOADING;
    if (mounted) setState(() {});

    _cameras = await availableCameras();

    _cameraController = CameraController(_cameras[device], ResolutionPreset.max,
        enableAudio: false);

    await _cameraController.initialize();

    if (_cameraController.value.hasError) {
      _widgetState = WidgetState.ERROR;
      if (mounted) setState(() {});
    } else {
      _widgetState = WidgetState.LOADED;
      if (mounted) setState(() {});
    }
  }
}
