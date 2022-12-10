import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

enum GalleryStatus {
  noStoragePermission,
  noStoragePermissionPermanent,
  browse,
  fileSelected
}

class GalleryModel extends ChangeNotifier {
  // store the selected file
  File? file;

  // initialise state to browse
  GalleryStatus _galleryStatus = GalleryStatus.browse;

  // getter
  GalleryStatus get galleryStatus => _galleryStatus;

  // setter
  set galleryStatus(GalleryStatus status) {
    if (status != _galleryStatus) {
      _galleryStatus = status;
      notifyListeners();
    }
  }

  // request gallery permission and update UI state accordingly
  Future<bool> requestPermission() async {
    PermissionStatus result;

    // android uses storage and ios uses photos
    if (Platform.isAndroid) {
      result = await Permission.storage.request();
    } else {
      result = await Permission.photos.request();
    }

    // check the result
    if (result.isGranted) {
      galleryStatus = GalleryStatus.browse;
      return true;
    } else if (Platform.isIOS || result.isPermanentlyDenied) {
      galleryStatus = GalleryStatus.noStoragePermissionPermanent;
    } else {
      galleryStatus = GalleryStatus.noStoragePermission;
    }
    return false;
  }

  // invoke the file picker
  Future<void> pickFile() async {
    final result = await ImagePicker().pickImage(source: ImageSource.gallery);
    // // if user has not selected an image
    if (result == null) return;

    // if user has selected an image, store it
    this.file = File(result.path); //transorm image path to file object

    // update model status
    galleryStatus = GalleryStatus.fileSelected;
  }
}
