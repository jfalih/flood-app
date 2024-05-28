import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flood/data/auth_utils.dart';
import 'package:flood/data/urls.dart';

import '/main.dart';
import '/ui/screens/login_screen.dart';
import '../utils/snack_bar_message.dart';

class NetworkUtils {
  /// get request
  static Future<dynamic> getMethod({
    required String url,
    VoidCallback? onUnAuthorized,
  }) async {
    try {
      final http.Response response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'token': AuthUtils.token ?? ''
        },
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 401) {
        if (onUnAuthorized != null) {
          onUnAuthorized();
        } else {
          moveToLogin();
        }
      } else {
        log('Something went wrong');
      }
    } catch (e) {
      log('Error: $e', stackTrace: StackTrace.current);
    }
  }

  /// post request
  static Future<dynamic> postMethod({
    required String url,
    required Map<String, String> body,
    VoidCallback? onUnAuthorized,
    String? token,
  }) async {
    try {
      final http.Response response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'token': AuthUtils.token ?? ''
        },
        body: jsonEncode(body),
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 401) {
        if (onUnAuthorized != null) {
          onUnAuthorized();
        } else {
          moveToLogin();
        }
      } else {
        log('Something went wrong');
      }
    } catch (e) {
      log('error: $e', stackTrace: StackTrace.current);
    }
  }

  // delete task by id
  static deleteTask(taskId) async {
    final response = await NetworkUtils.getMethod(
      url: Urls.deleteTask(taskId),
    );

    //
    if (response != null) {
      showSnackBarMessage(
        Flood.navigatorKey.currentContext!,
        title: "Delete successful",
      );
    } else {
      showSnackBarMessage(Flood.navigatorKey.currentContext!,
          title: "Delete failed!", error: true);
    }
  }
}

//
moveToLogin() async {
  //clear cache
  await AuthUtils.clearData();

  //
  Navigator.pushAndRemoveUntil(
      Flood.navigatorKey.currentContext!,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (route) => false);
}
