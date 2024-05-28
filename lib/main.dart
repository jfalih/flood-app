import 'package:flood/ui/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flood/ui/screens/splash_screen.dart';

void main() {
  runApp(const Flood());
}

class Flood extends StatelessWidget {
  const Flood({Key? key}) : super(key: key);
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: Flood.navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: const SplashScreen(),
    );
  }
}
