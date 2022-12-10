import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../components/gallery/gallery.dart';
import '../components/gallery/galleryModel.dart';
// import '../components/temp.dart';

class SubHome extends StatefulWidget {
  @override
  _SubHomeState createState() => _SubHomeState();
}

class _SubHomeState extends State<SubHome> {
  // initiate a gallery model to check and maintain its status
  late GalleryModel model;

  void initState() {
    super.initState();
    // initialise a gallery model
    model = new GalleryModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("App name", style: TextStyle(color: Colors.black)),
            backgroundColor: Colors.white,
            actions: [
              // upload image or video
              GestureDetector(
                  onTap: () => openGallery(context),
                  child: appBarButton(Icons.upload_outlined, 20, 10)),
            ]),
        body: Center(child: Text("body")));
  }

  // handle open gallery request
  Future openGallery(BuildContext context) async {
    try {
      // get status on gallery permission status
      await model.requestPermission();

      // return if user denies the request to access the gallery
      if (model.galleryStatus == GalleryStatus.noStoragePermission)
        return;
      else {
        // load the the gallery
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Gallery(model: model)));
      }
    } on PlatformException catch (e) {
      print("Failed to pick an image.\n$e");
    }
  }

  // create app bar buttons
  Widget appBarButton(IconData icon, double left, double right) {
    return Container(
        margin: EdgeInsets.only(right: right, left: left),
        child: Icon(icon, color: Colors.black));
  }
}
