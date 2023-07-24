import 'package:flutter/material.dart';
import 'package:beta_projek/dashboard/dashboard.dart';
import 'package:beta_projek/register/regis.dart';
import 'package:beta_projek/Login/login.dart';
import 'package:beta_projek/splashscreen/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: dasbor(),
      // home: SplashPage(),
    );
  }
}
