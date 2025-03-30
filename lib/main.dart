import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tudo_app_with_firebase/screen/splash_screen.dart';
import 'package:tudo_app_with_firebase/view/ui_helper.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.white
  ));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    User? user = FirebaseAuth.instance.currentUser;
    print('user?.email');
    print(user?.email);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) {
          return UiHelper(
            screenWidth: constraints.maxWidth,
            screenHeight: constraints.maxHeight,
            child: MediaQuery(
              data: MediaQueryData.fromWindow(WidgetsBinding.instance.window).copyWith(
                textScaleFactor: 1.0,
                size: Size(constraints.maxWidth, constraints.maxHeight), // Set custom width and height
              ),
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                  useMaterial3: true,
                ),
                home: SplashScreen(), // Check if user is signed in
              ),
            ),
          );
        });
  }
}
