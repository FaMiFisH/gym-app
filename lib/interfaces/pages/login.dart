import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gym_app/interfaces/components/footer/loginFooter.dart';
import 'package:gym_app/interfaces/pages/register.dart';
import 'package:gym_app/themes/themes.dart';
import 'package:provider/provider.dart';

import 'home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // keeps track of password visibility
  var hidePass = true;

  //sets the state for password visibility
  void toggleVisibility() {
    setState(() {
      hidePass = !hidePass;
    });
  }

  // initialising text field controllers
  // used to retrieve values of the text fields
  var passController = TextEditingController();
  var emailController = TextEditingController();

  // execute login call
  _login(BuildContext context) async {
    final email = emailController.text.trim();
    final password = passController.text.trim();

    // TODO: validate user inputs here

    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on Exception catch (e) {
      print(e);
    }
    // Navigator.pushReplacement(context,
    //     MaterialPageRoute(builder: (BuildContext context) => HomePage()));
  }

  @override
  void initState() {
    super.initState();

    // start listening to the changes
    passController.addListener(() {
      setState(() {});
    });
    emailController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // clean the controllers when the widget is removed from the widget tree
    passController.dispose();
    emailController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // gets the theme mode
    ThemeMode themeMode = Provider.of<ThemeProvider>(context).themeMode;

    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Center(
                          child: Container(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                            Container(
                                child: Text(
                              "Gym App",
                              style: Theme.of(context).textTheme.headline3,
                            )),
                            SizedBox(height: 24.0),
                            Container(
                              child: TextFormField(
                                controller: emailController,
                                decoration: InputDecoration(
                                  labelText: "Email",
                                  prefixIcon: Icon(Icons.email),
                                ),
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Container(
                                child: TextFormField(
                                    controller: passController,
                                    decoration: InputDecoration(
                                        labelText: "Password",
                                        prefixIcon: Icon(Icons.lock),
                                        suffixIcon: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              IconButton(
                                                  icon: Icon(hidePass
                                                      ? Icons.visibility_off
                                                      : Icons.visibility),
                                                  onPressed: () =>
                                                      toggleVisibility())
                                            ]
                                            // : []
                                            )),
                                    obscureText: hidePass,
                                    enableSuggestions: false,
                                    autocorrect: false)),
                            SizedBox(height: 8),
                            Container(
                                alignment: Alignment(1.0, 0.0),
                                padding: EdgeInsets.only(top: 12.0),
                                child: InkWell(
                                    child: Text("Forgot Password?",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1))),
                            SizedBox(height: 32.0),
                            Container(
                              child: ElevatedButton(
                                  onPressed: () => _login(context),
                                  child: Text("Login",
                                      style:
                                          Theme.of(context).textTheme.button)),
                            ),
                          ])))),
                ),
              ),
            ),
            LoginFooter()
          ],
        ),
      ),
    );
  }
}
