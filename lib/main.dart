import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testcase/screens/dashboard_screen/dashboard_screen.dart';
import 'package:testcase/screens/splash_screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TestCase',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
        primarySwatch: Colors.blueGrey,
      ),
      home:  SplashScreen(),
    );
  }
}

