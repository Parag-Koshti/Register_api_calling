import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'model.dart';

class RegisterProvider with ChangeNotifier {
  RegisterResponse registerResponse = RegisterResponse();
  bool isLoading = false;
  int _statusCode = 0;
  int get statusCode => _statusCode;
  set registerStaus(int value) {
    _statusCode = value;
  }

  registerUser(String email, String password) async {
    isLoading = true;
    notifyListeners();
    final Map<String, dynamic> registerData = {
      "email": email.trim(),
      "password": password.trim(),
    };
    return await post(Uri.parse(Api.url),
            body: jsonEncode(registerData),
            headers: {"Content-Type": 'application/json'})
        .then(onvalue)
        .catchError(onError);
  }

  Future<FutureOr> onvalue(Response response) async {
    String? result;
    final Map<String, dynamic> registerData = json.decode(response.body);
    registerResponse = RegisterResponse.fromJson(registerData);

    _statusCode = response.statusCode;
    if (response.statusCode == 200) {
      result = registerResponse.token;
      isLoading = false;
    } else {
      result = registerResponse.error;
      isLoading = true;
    }
    notifyListeners();
    return result;
  }

  onError(error) async {
    return error;
  }
}
