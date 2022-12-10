import 'package:flutter/material.dart';
import 'package:gym_app/interfaces/pages/login.dart';

class RegisterFooter extends StatelessWidget {
  // execute the login call
  void _login(BuildContext context) {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
            height: 72,
            decoration:
                BoxDecoration(color: Theme.of(context).primaryColorDark),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Already have an account?",
                    style: Theme.of(context).textTheme.bodyText2),
                SizedBox(width: 5.0),
                InkWell(
                    onTap: () => _login(context),
                    child: Text("Login",
                        style: Theme.of(context).textTheme.subtitle2))
              ],
            )));
  }
}
