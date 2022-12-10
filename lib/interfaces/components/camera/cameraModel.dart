import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

//TODO: make it so the mdoel is initialised only when the user is on the model tab

enum CameraStatus {
  // includes storage permission
  noCameraPermission,
  noCameraPermissionPermanent,
  preview,
  pictureTaken,
  videoTaken
}

class CameraModel extends ChangeNotifier {
  CameraController? _controller;

  // initialise state of camera
  CameraStatus _cameraStatus = CameraStatus.preview;

  // list of cameras to choose from
  late List<CameraDescription> _cameras;

  // specify which camera to use
  int _selected = 0;

  // flag to indicate whether user is taking a photo or video
  // 0 to indicate false and 1 to indicate true
  int _takingPhoto = 1;

  // store picture taken
  late XFile _picture;

  // getters
  CameraStatus get getCameraStatus => _cameraStatus;
  CameraController? get getCameraController => _controller;
  List<CameraDescription> get getCameraDescriptions => _cameras;
  int get getSelected => _selected;
  int get getTakingPhoto => _takingPhoto;
  XFile get getFile => _picture;

  // setter
  set cameraStatus(CameraStatus status) {
    if (status != _cameraStatus) {
      _cameraStatus = status;
      notifyListeners();
    }
  }

  set controller(CameraController? controller) {
    _controller = controller;
    notifyListeners();
  }

  set cameraDescriptions(List<CameraDescription> descriptions) {
    _cameras = descriptions;
    notifyListeners();
  }

  set cameraSelected(int val) {
    _selected = val;
    notifyListeners();
  }

  set takingPhoto(int val) {
    _takingPhoto = val;
    notifyListeners();
  }

  set setFile(XFile file) {
    _picture = file;
    notifyListeners();
  }

  // request camera permissions and update UI accordingly
  Future<bool> requestPermission() async {
    // TOFO: cehck for microphone permissions for android
    PermissionStatus cameraResult;
    PermissionStatus storageResult;

    // check camera permission
    cameraResult = await Permission.camera.request();

    // check storgae permissions
    if (Platform.isAndroid) {
      storageResult = await Permission.storage.request();
    } else {
      storageResult = await Permission.photos.request();
    }

    // check the results
    if (cameraResult.isGranted && storageResult.isGranted) {
      cameraStatus = CameraStatus.preview;
      return true;
    } else if (cameraResult.isPermanentlyDenied) {
      cameraStatus = CameraStatus.noCameraPermissionPermanent;
    } else if (Platform.isIOS || storageResult.isPermanentlyDenied) {
      cameraStatus = CameraStatus.noCameraPermissionPermanent;
    } else {
      cameraStatus = CameraStatus.noCameraPermission;
    }
    return false;
  }
}
