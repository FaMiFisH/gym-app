import 'package:flutter/material.dart';
import 'package:gym_app/interfaces/components/footer/registerFooter.dart';
import 'package:gym_app/interfaces/pages/home.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // keep track of pass/confirmPass visibility
  var hidePass = true;
  var hideConfirmPass = true;

  //sets the state for pass/confirmPass visibility
  void togglePassVisibility() {
    setState(() {
      hidePass = !hidePass;
    });
  }

  void toggleConfirmPassVisibility() {
    setState(() {
      hideConfirmPass = !hideConfirmPass;
    });
  }

  _register(BuildContext context) {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => HomePage()));
  }

  // intialising text field controllers
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var confirmPassController = TextEditingController();

  @override
  void initState() {
    super.initState();

    //start listening to changes
    nameController.addListener(() {
      setState(() {});
    });
    emailController.addListener(() {
      setState(() {});
    });
    passController.addListener(() {
      setState(() {});
    });
    confirmPassController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // clean the controllers when the widget is removed from the widget tree
    passController.dispose();
    emailController.dispose();
    nameController.dispose();
    confirmPassController.dispose();

    super.dispose();
  }

  // -Build method---------
  @override
  Widget build(BuildContext context) {
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
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            child: Text("Gym App",
                                style: Theme.of(context).textTheme.headline3),
                          ),
                          SizedBox(height: 24.0),
                          Container(
                              child: Column(
                            children: [
                              Container(
                                child: TextFormField(
                                  controller: nameController,
                                  decoration: InputDecoration(
                                    labelText: "Name",
                                    prefixIcon: Icon(Icons.person),
                                    // suffixIcon: nameController.text.isNotEmpty
                                    //     ? IconButton(
                                    //         icon: Icon(Icons.clear),
                                    //         onPressed: () =>
                                    //             {nameController.clear()},
                                    //       )
                                    //     : SizedBox.shrink()
                                  ),
                                ),
                              ),
                              SizedBox(height: 8.0),
                              Container(
                                child: TextFormField(
                                  controller: emailController,
                                  decoration: InputDecoration(
                                    labelText: "Email",
                                    prefixIcon: Icon(Icons.email),
                                    // suffixIcon:
                                    //     emailController.text.isNotEmpty
                                    //         ? IconButton(
                                    //             icon: Icon(Icons.clear),
                                    //             onPressed: () =>
                                    //                 {emailController.clear()},
                                    //           )
                                    //         : SizedBox.shrink()
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
                                          children:
                                              // passController.text.isNotEmpty ?
                                              [
                                            // IconButton(
                                            //     icon: Icon(Icons.clear),
                                            //     onPressed: () => {
                                            //           passController.clear()
                                            //         }),
                                            IconButton(
                                                icon: Icon(hidePass
                                                    ? Icons.visibility_off
                                                    : Icons.visibility),
                                                onPressed: () =>
                                                    togglePassVisibility()),
                                          ]
                                          // : [],
                                          )),
                                  obscureText: hidePass,
                                  enableSuggestions: false,
                                  autocorrect: false,
                                ),
                              ),
                              SizedBox(height: 8.0),
                              Container(
                                child: TextFormField(
                                  controller: confirmPassController,
                                  decoration: InputDecoration(
                                      labelText: "Confirm Password",
                                      prefixIcon: Icon(Icons.lock),
                                      suffixIcon: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          mainAxisSize: MainAxisSize.min,
                                          children:
                                              // confirmPassController
                                              //         .text.isNotEmpty ?
                                              [
                                            //         IconButton(
                                            //             icon: Icon(Icons.clear),
                                            //             onPressed: () => {
                                            //                   confirmPassController
                                            //                       .clear()
                                            //                 }),
                                            IconButton(
                                                icon: Icon(
                                                  hideConfirmPass
                                                      ? Icons.visibility_off
                                                      : Icons.visibility,
                                                ),
                                                onPressed: () =>
                                                    toggleConfirmPassVisibility()),
                                          ]
                                          // : [],
                                          )),
                                  obscureText: hideConfirmPass,
                                  enableSuggestions: false,
                                  autocorrect: false,
                                ),
                              ),
                              SizedBox(height: 48.0),
                              Container(
                                child: ElevatedButton(
                                    onPressed: () => _register(context),
                                    child: Text("Register")),
                              )
                            ],
                          )),
                        ]),
                  ),
                ),
              )),
            ),
            RegisterFooter()
          ],
        ),
      ),
    );
  }
}
