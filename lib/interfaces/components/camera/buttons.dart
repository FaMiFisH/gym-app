import 'package:flutter/material.dart';

// return a widget to take pic
Widget picButton() {
  return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
          margin: EdgeInsets.only(left: 20, bottom: 20, right: 20),
          height: 50,
          width: 50,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black26, offset: Offset(2, 2), blurRadius: 10)
              ]),
          child: Center(
              child:
                  Icon(Icons.circle_outlined, size: 50, color: Colors.black))));
}

Widget switchButton() {
  return Align(
      alignment: Alignment.bottomRight,
      child: Container(
          margin: EdgeInsets.only(left: 20, bottom: 20, right: 20),
          height: 50,
          width: 50,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black12,
              boxShadow: [
                BoxShadow(
                    color: Colors.black26, offset: Offset(2, 2), blurRadius: 10)
              ]),
          child: Center(
              child: Icon(Icons.swap_horiz_rounded,
                  size: 25, color: Colors.white))));
}
