import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gym_app/interfaces/components/camera/cameraModel.dart';
import 'package:gym_app/interfaces/pages/account.dart';
import 'package:gym_app/interfaces/pages/subHome.dart';

import '../components/camera/camera.dart';

class HomePage extends StatefulWidget {
  // get the user logged in
  final user = FirebaseAuth.instance.currentUser!;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  PageController pageController = PageController(initialPage: 0);

  late CameraModel model;

  void initState() {
    super.initState();
    model = new CameraModel();
  }

  @override
  void dispose() {
    model.getCameraController?.dispose();
    super.dispose();
  }

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: PageView(
          controller: pageController,
          onPageChanged: (newIndex) {
            setState(() {
              _selectedIndex = newIndex;
            });
          },
          children: [SubHome(), Camera(model: model), Account()]),
      // Center(child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: _selectedIndex == 1
          ? null
          : BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: 'Home'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.camera), label: 'Camera'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.account_circle_sharp), label: 'Account')
                ],
              selectedItemColor: Colors.amber[800],
              currentIndex: _selectedIndex,
              onTap: (index) {
                pageController.animateToPage(index,
                    duration: Duration(milliseconds: 500), curve: Curves.ease);
              }),
    );
  }
}
