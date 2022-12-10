import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gym_app/interfaces/components/account/AccountInfo.dart';
import 'package:gym_app/interfaces/components/account/posts.dart';

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("account name"), actions: [
        // upload image or video
        GestureDetector(
            onTap: () {},
            child: Container(
                margin: EdgeInsets.fromLTRB(0, 0, 8, 0),
                child: Icon(
                  Icons.menu,
                ))),
      ]),
      body: Container(
          child: Column(children: <Widget>[
        Expanded(child: AccountInfo()),
        Container(
            child: ElevatedButton(
                child: Text("Logout"),
                onPressed: () => FirebaseAuth.instance.signOut())),
        Container(
            height: 100,
            width: double.infinity,
            child: Center(child: Text("sub tabs"))),
        Expanded(flex: 2, child: Posts())
      ])),
    );
  }
}
