import 'package:flutter/material.dart';

import '../dashboard_screen/dashboard_screen.dart';

class SplashScreen extends StatefulWidget {


  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    _timerSplash();
    super.initState();
  }

  _timerSplash() async {
    await Future.delayed(Duration(milliseconds: 3000), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => DashboardScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {


    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Image.asset('assets/images/lime.png',),
      ),
    );
  }
}
