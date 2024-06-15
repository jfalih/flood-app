import 'dart:async';

import 'package:flood/data/utils/auth_utils.dart';
import 'package:flood/ui/screens/auth/login_screen.dart';
import 'package:flood/ui/screens/bottom_navbar_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    navigateToLogin();
    super.initState();
  }

  void navigateToLogin() {
    //another way to impliment splash screen;
    // await Future.delayed(Duration(seconds: 4));
    // Navigator.pushAndRemoveUntil(
    //   context,
    //   MaterialPageRoute(builder: (context) => const LoginScreen()),
    //       (route) => false,
    // );
    Future.delayed(const Duration(seconds: 3)).then((_) async {
      final bool loggedIn = await AuthUtility.isUserLoggedIn();
      if (mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  loggedIn ? const BottomNavBarScreen() : const LoginScreen()),
          (route) => false,
        );
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Colors.white),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset("assets/images/flood.png"),
                        const Padding(
                          padding: EdgeInsets.only(top: 20.0),
                        ),
                        const Text(
                          "Blood Donation an Easy Way",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      //CircularProgressIndicator(backgroundColor: Colors.grey),
                      Padding(padding: EdgeInsets.only(top: 20.0)),
                      Text(
                        "Kelompok 3",
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 17.0,
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 60.0)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}