import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gym_app/interfaces/pages/home.dart';
import 'package:gym_app/themes/themes.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'interfaces/pages/login.dart';

void main() async {
  try {
    // initialise plugin services
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  } on Exception catch (e) {
    print("Exception:\n$e\nWhen initialising camera plugin services.");
  }

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      builder: (context, _) {
        final themeProvider = Provider.of<ThemeProvider>(context);
        return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            themeMode: themeProvider.themeMode,
            theme: MyThemes.lightThemeData,
            home: Scaffold(
                // if user is already logged in, take them to the home page
                body: StreamBuilder<User?>(
                    stream: FirebaseAuth.instance.authStateChanges(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return HomePage();
                      } else {
                        return LoginPage();
                      }
                    })));
      });
}
