import 'dart:io';

import 'package:flutter/material.dart';

class GalleryReview extends StatefulWidget {
  // file to display
  final File? file;
  final VoidCallback onPressed;

  GalleryReview({Key? key, required this.file, required this.onPressed})
      : super(key: key);

  @override
  _GalleryReviewState createState() => _GalleryReviewState();
}

class _GalleryReviewState extends State<GalleryReview> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: widget.file == null
            ? Column(children: [
                Container(
                    child: ElevatedButton(
                        onPressed: widget.onPressed,
                        child: Text("Select a file")))
              ])
            : Column(children: [
                Container(
                    margin: EdgeInsets.all(20),
                    child: Image.file(widget.file!)),
                Container(
                    child:
                        ElevatedButton(onPressed: null, child: Text("Upload")))
              ]));
  }
}
