import 'dart:convert';
import 'dart:developer';

import 'package:flood/data/models/response_model.dart';
import 'package:flood/data/utils/auth_utils.dart';
import 'package:flood/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../ui/screens/auth/login_screen.dart';

class NetworkCaller {
  Future<NetworkResponse> getRequest(String url) async {
    try {
      Response response = await get(Uri.parse(url),
          headers: {
          'Authorization':'Bearer ${AuthUtility.userInfo.token.toString()}', 
          'Accept': 'application/json'
      });
      log("$url ${response.statusCode}");
      if (response.statusCode == 200) {
        return NetworkResponse(
            true, response.statusCode, jsonDecode(response.body));
      } else if (response.statusCode == 401) {
        moveToLogin();
      } else {
        return NetworkResponse(
          false,
          response.statusCode,
          null,
        );
      }
    } catch (e) {
      log(e.toString());
    }
    return NetworkResponse(
      false,
      -1,
      null,
    );
  }

  Future<NetworkResponse> postRequest(
    String url,
    Map<String, dynamic>? body,
  ) async {
    try {
      Response response = await post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${AuthUtility.userInfo.token.toString()}',
        },
        body: jsonEncode(body),
      );
      log(AuthUtility.userInfo.token.toString());
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        return NetworkResponse(
            true, response.statusCode, jsonDecode(response.body));
      } else if (response.statusCode == 401) {
        moveToLogin();
      } else {
        return NetworkResponse(
          false,
          response.statusCode,
          null,
        );
      }
    } catch (e) {
      log(e.toString());
    }
    return NetworkResponse(
      false,
      -1,
      null,
    );
  }
}

void moveToLogin() async {
  await AuthUtility.clearUserInfo();
  // ignore: use_build_context_synchronously
  Navigator.pushAndRemoveUntil(
      Flood.navigatorKey.currentState!.context,
      MaterialPageRoute(builder: (context) => const LoginScreen()), // Change to your login screen
      (route) => false);
}
