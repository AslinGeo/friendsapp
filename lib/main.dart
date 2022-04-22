import 'package:flutter/material.dart';
import 'package:friends_app/splashscreen/splashscreen.dart';

void main() {
  runApp(MyApp());
}
  
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash Screen',
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}


