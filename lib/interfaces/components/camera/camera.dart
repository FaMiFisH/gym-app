import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:gym_app/interfaces/components/camera/buttons.dart';
import 'package:gym_app/interfaces/components/camera/cameraModel.dart';
import 'package:gym_app/interfaces/components/camera/cameraPermission.dart';
import 'package:gym_app/interfaces/components/camera/cameraReview.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class Camera extends StatefulWidget {
  // TODO: add loading widget
  final loadingWidget = null;
  final CameraModel model;
  Camera({Key? key, required this.model}) : super(key: key);

  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> with WidgetsBindingObserver {
  setupCamera() async {
    widget.model.cameraDescriptions = await availableCameras();
    // if user has camera permissions, initialise the camera controller
    final hasPermission = await widget.model.requestPermission();
    if (hasPermission) {
      var controller = CameraController(
          widget.model.getCameraDescriptions[widget.model.getSelected],
          ResolutionPreset.high);
      await controller.initialize();
      widget.model.controller = controller;
    } else {
      widget.model.controller = null;
    }
  }

  @override
  void initState() {
    super.initState();
    setupCamera();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.addObserver(this);
    // widget.model.getCameraController?.dispose();
    super.dispose();
  }

// todo: update
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (widget.model.getCameraController == null) return;
    if (!widget.model.getCameraController!.value.isInitialized) return;

    if (state == AppLifecycleState.inactive) {
      widget.model.getCameraController?.dispose(); // _controller?
    } else if (state == AppLifecycleState.resumed) {
      setupCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: widget.model,
        child: Consumer<CameraModel>(builder: (context, model, child) {
          Widget? _widget;

          // get devices size
          final size = MediaQuery.of(context).size;

          switch (model.getCameraStatus) {
            case CameraStatus.noCameraPermission:
              _widget = CameraPermission(
                  isPermanent: false, onPressed: checkPermissionAndInit);
              break;
            case CameraStatus.noCameraPermissionPermanent:
              _widget = CameraPermission(
                  isPermanent: true, onPressed: checkPermissionAndInit);
              break;
            case CameraStatus.pictureTaken:
              _widget = CameraReview(
                  status: CameraStatus.pictureTaken,
                  picture: widget.model.getFile,
                  model: model);
              break;
            case CameraStatus.videoTaken:
              _widget = null;
              break;
            case CameraStatus.preview:
              if (widget.model.getCameraController == null) {
                if (widget.loadingWidget != null) {
                  _widget = widget.loadingWidget;
                } else {
                  _widget = Container(
                    color: Colors.black,
                  );
                }
              } else {
                _widget = Stack(children: [
                  Container(
                      width: size.width,
                      height: size.height,
                      child: FittedBox(
                          fit: BoxFit.cover,
                          child: Container(
                              width: 100,
                              child: CameraPreview(
                                  widget.model.getCameraController!)))),
                  Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Container(
                      color: Colors.black45,
                      padding: const EdgeInsets.only(bottom: 10.0, top: 10),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                margin: EdgeInsets.only(right: 10.0),
                                child: GestureDetector(
                                    onTap: () => stateChange(1),
                                    child: Text("Picture",
                                        style: TextStyle(
                                            color:
                                                widget.model.getTakingPhoto == 1
                                                    ? Colors.yellow
                                                    : Colors.white)))),
                            Container(
                                margin: EdgeInsets.only(left: 10.0),
                                child: GestureDetector(
                                    onTap: () => stateChange(0),
                                    child: Text("Video",
                                        style: TextStyle(
                                            color:
                                                widget.model.getTakingPhoto == 0
                                                    ? Colors.yellow
                                                    : Colors.white))))
                          ]),
                    ),
                    Container(
                      color: Colors.black45,
                      padding: EdgeInsets.only(top: 10),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                                margin: EdgeInsets.only(
                                    left: 20, bottom: 20, right: 20),
                                height: 50,
                                width: 50,
                                alignment: Alignment.bottomLeft),
                            widget.model.getTakingPhoto == 1
                                ? GestureDetector(
                                    onTap: () {
                                      widget.model.getCameraController
                                          ?.takePicture()
                                          .then((XFile? file) {
                                        if (mounted) {
                                          if (file != null) {
                                            setState(() {
                                              widget.model.setFile = file;
                                            });
                                            // update status
                                            // _model.cameraStatus =
                                            model.cameraStatus =
                                                CameraStatus.pictureTaken;

                                            // saveImagePermanently(file.path);
                                            print(
                                                "Picture saved to ${file.path}");
                                          }
                                        }
                                      });
                                    },
                                    child: picButton())
                                : Container(),
                            GestureDetector(
                                onTap: toggleCamera, child: switchButton()),
                          ]),
                    )
                  ]),
                ]);
              }
              break;
          }
          return Scaffold(body: _widget);
        }));
  }

  // check user has permissions
  checkPermissionAndInit() async {
    final hasPermission = await widget.model.requestPermission();
    if (hasPermission) {
      try {
        var controller = CameraController(
            widget.model.getCameraDescriptions[widget.model.getSelected],
            ResolutionPreset.high);
        await controller.initialize();
        widget.model.controller = controller;
      } on CameraException catch (e) {
        debugPrint("Error while initialising camera: $e");
      }
    }
  }

  // function to switch cameras
  // user can only toggle if they have camera permissions to begin with
  toggleCamera() async {
    int newSelected = (widget.model.getSelected + 1) %
        widget.model.getCameraDescriptions.length;
    widget.model.cameraSelected = newSelected;

    // var controller = await selectCamera();
    var controller = CameraController(
        widget.model.getCameraDescriptions[widget.model.getSelected],
        ResolutionPreset.high);
    await controller.initialize();
    setState(() => widget.model.controller = controller);
  }

  // update picture or video state flag
  void stateChange(int val) {
    // return if user is already on the desired state
    if (widget.model.getTakingPhoto == val) {
      return;
    }
    setState(() {
      widget.model.takingPhoto = val;
    });
  }

  Future<File> saveImagePermanently(String path) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(path);
    final image = File('${directory.path}/$name');

    return File(path).copy(image.path);
  }
}
