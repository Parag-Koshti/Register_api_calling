import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'model.dart';

class LoginProvider with ChangeNotifier {
  LoginResponse loginResponse = LoginResponse();
  bool isLoading = false;
  int _statusCode = 0;
  int get statusCode => _statusCode;
  set loginStatus(int value) {
    _statusCode = value;
  }

  loginUser(String email, String password) async {
    isLoading = true;
    notifyListeners();
    final Map<String, dynamic> loginData = {
      "email": email.trim(),
      "password": password.trim(),
    };
    return await post(Uri.parse(Api.url2),
            body: jsonEncode(loginData),
            headers: {"Content-Type": 'application/json'})
        .then(onvalue)
        .catchError(onError);
  }

  Future<FutureOr> onvalue(Response response) async {
    String? result2;
    final Map<String, dynamic> loginData = json.decode(response.body);
    loginResponse = LoginResponse.fromJson(loginData);

    _statusCode = response.statusCode;
    if (response.statusCode == 200) {
      result2 = loginResponse.token;
      isLoading = false;
    } else {
      result2 = loginResponse.error;
      isLoading = false;
    }
    notifyListeners();
    return result2;
  }

  onError(error) async {
    return error;
  }
}
