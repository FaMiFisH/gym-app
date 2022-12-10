import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gym_app/interfaces/components/camera/cameraModel.dart';
import 'package:image_picker/image_picker.dart';

class CameraReview extends StatefulWidget {
  final CameraStatus status;
  final XFile picture;
  final CameraModel model;

  CameraReview(
      {Key? key,
      required this.status,
      required this.picture,
      required this.model});

  @override
  _CameraReviewState createState() => _CameraReviewState();
}

class _CameraReviewState extends State<CameraReview> {
  Widget saveButton() {
    return Container(
        padding: EdgeInsets.only(left: 4),
        height: 40,
        width: 70,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Colors.grey[800]),
        child: Center(
            child: Row(children: [
          Icon(Icons.save_alt_rounded, size: 25, color: Colors.white),
          SizedBox(width: 4),
          Text("Save", style: TextStyle(color: Colors.white))
        ])));
  }

  @override
  Widget build(BuildContext context) {
    // get devices size
    final size = MediaQuery.of(context).size;
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.black,
      padding: EdgeInsets.all(5),
      child: Stack(children: [
        Column(
          children: [
            Container(
                width: size.width,
                height: size.height - 62,
                child: FittedBox(
                    fit: BoxFit.cover,
                    child: Image.file(File(widget.picture.path)))),
            Container(
                padding: EdgeInsets.only(top: 8),
                child: Row(
                  children: [saveButton()],
                ))
          ],
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Colors.black12),
                child: GestureDetector(
                  onTap: () => widget.model.cameraStatus = CameraStatus.preview,
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.white,
                  ),
                )),
          ),
          body: null,
        ),
      ]),
    );
  }
}
