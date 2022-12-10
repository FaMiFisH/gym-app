import 'package:flutter/material.dart';
import 'package:gym_app/interfaces/pages/register.dart';

class LoginFooter extends StatelessWidget {
  // execute the register call
  _register(BuildContext context) {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => RegisterPage()));
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
                Text("Don't have an account?",
                    style: Theme.of(context).textTheme.bodyText2),
                SizedBox(width: 5.0),
                InkWell(
                    onTap: () => _register(context),
                    child: Text("Register",
                        style: Theme.of(context).textTheme.subtitle2))
              ],
            )));
  }
}
