import 'package:flutter/material.dart';
import 'package:pokergame/view/constants/theme.dart';
import 'package:pokergame/view/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme().theme,
      debugShowCheckedModeBanner: false,
      title: 'Pocker Game',
      home: SplashScreen(),
    );
  }
}
