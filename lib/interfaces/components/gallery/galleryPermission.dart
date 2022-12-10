import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class GalleryPermission extends StatelessWidget {
  final bool isPermanent;
  final VoidCallback onPressed;

  const GalleryPermission(
      {Key? key, required this.isPermanent, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
      Container(
          padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 24.0),
          child: Text("Allow app to access gallery",
              style: Theme.of(context).textTheme.headline6)),
      Container(
        padding: const EdgeInsets.only(
          left: 16.0,
          top: 24.0,
          right: 16.0,
        ),
        child: const Text(
          'how it effects them, how we use it, how to change settings',
          textAlign: TextAlign.center,
        ),
      ),
      if (isPermanent)
        Container(
          padding: const EdgeInsets.only(
            left: 16.0,
            top: 24.0,
            right: 16.0,
          ),
          child: const Text(
            'You need to give this permission from the system settings.',
            textAlign: TextAlign.center,
          ),
        ),
      Container(
        padding: const EdgeInsets.only(
            left: 16.0, top: 24.0, right: 16.0, bottom: 24.0),
        child: ElevatedButton(
          child: Text(isPermanent
              ? 'Open settings'
              : 'Allow access'), // continue will lead to (dont) allow pop up
          onPressed: () => isPermanent ? openAppSettings() : onPressed(),
        ),
      ),
    ]));
  }
}
