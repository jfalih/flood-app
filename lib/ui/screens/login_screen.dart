import 'package:flutter/material.dart';
import 'package:flood/data/auth_utils.dart';
import 'package:flood/utils/text_styles.dart';

import '../../../data/network_utils.dart';
import '../../../data/urls.dart';
import '../../../utils/snack_bar_message.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController emailTextEditController = TextEditingController();

  final TextEditingController passwordTextEditController =
      TextEditingController();

  final regExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  bool _inProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }

//
  Future login() async {
    setState(() {
      _inProgress = true;
    });
    //
    final result = await NetworkUtils.postMethod(
      url: Urls.loginUrl,
      body: {
        "email": emailTextEditController.text.trim(),
        "password": passwordTextEditController.text,
      },
      onUnAuthorized: () {
        showSnackBarMessage(context,
            title: 'User name or password incorrect', error: true);
      },
    );
    setState(() {
      _inProgress = false;
    });
    print(result);
    if (result != null && result['status'] == 'success') {
      //save
      AuthUtils.saveUserData(
        result['token'],
        result['data']['firstName'],
        result['data']['lastName'],
        result['data']['email'],
        result['data']['mobile'],
        result['data']['photo'],
      );

      if (!mounted) return;
      //
      // showSnackBarMessage(context, title: 'Login successful');

      //clean field
      emailTextEditController.clear();
      passwordTextEditController.clear();

      //
      setState(() {
        _inProgress = false;
      });

      //
      // Navigator.pushAndRemoveUntil(
      //     context,
      //     MaterialPageRoute(builder: (context) => const MainBottomNavBar()),
      //     (route) => false);
    } else {
      if (!mounted) return;

      showSnackBarMessage(
        context,
        title: 'Login failed',
        error: true,
      );

      //
      setState(() {
        _inProgress = false;
      });
    }
  }
}
