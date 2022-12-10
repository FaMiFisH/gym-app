import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gym_app/interfaces/components/gallery/GalleryReview.dart';
import 'package:gym_app/interfaces/components/gallery/galleryModel.dart';
// import 'package:gym_app/interfaces/components/galleryPermission.dart';
// import 'package:gym_app/interfaces/components/temp.dart';
import 'package:provider/provider.dart';

import 'galleryPermission.dart';

// TODO: make loading in screen the selected pic one

class Gallery extends StatefulWidget {
  final GalleryModel model;
  const Gallery({Key? key, required this.model}) : super(key: key);

  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> with WidgetsBindingObserver {
  bool detectPermission = false;

  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // detects if permission has been granted when user returns from settings
  // Note: app stops running when whilst running the app, you switch storage permissions off
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed &&
        detectPermission &&
        (widget.model.galleryStatus ==
            GalleryStatus.noStoragePermissionPermanent)) {
      detectPermission = false;
      widget.model.requestPermission();
    } else if (state == AppLifecycleState.paused &&
        widget.model.galleryStatus ==
            GalleryStatus.noStoragePermissionPermanent) {
      detectPermission = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    // store the file selected
    File? file;
    return ChangeNotifierProvider.value(
        value: widget.model,
        child: Consumer<GalleryModel>(builder: (context, model, child) {
          Widget? widget;
          switch (model.galleryStatus) {
            case GalleryStatus.noStoragePermission:
              widget = GalleryPermission(
                  isPermanent: false, onPressed: checkPermissionAndPick);
              break;
            case GalleryStatus.noStoragePermissionPermanent:
              widget = GalleryPermission(
                  isPermanent: true, onPressed: checkPermissionAndPick);
              break;
            case GalleryStatus.browse:
              checkPermissionAndPick();
              widget =
                  GalleryReview(file: file, onPressed: checkPermissionAndPick);
              break;
            case GalleryStatus.fileSelected:
              file = model.file;
              widget =
                  GalleryReview(file: file, onPressed: checkPermissionAndPick);
              break;
          }

          return Scaffold(
              appBar: AppBar(
                  title: model.galleryStatus == GalleryStatus.browse
                      ? Text("Select an image")
                      : model.galleryStatus == GalleryStatus.fileSelected
                          ? Text("Upload")
                          : null),
              body: widget);
        }));
  }

  // check if permission is granted and pick the file using the gallery model methods
  Future<void> checkPermissionAndPick() async {
    final hasFilePermission = await widget.model.requestPermission();
    if (hasFilePermission) {
      try {
        await widget.model.pickFile();
      } on Exception catch (e) {
        debugPrint("Error when picking the file: $e");
        // inform user of the error
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("An error occured when picking a file")));
      }
    }
  }
}
