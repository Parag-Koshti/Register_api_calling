import 'dart:convert';

class Api {
  static String url = "https://reqres.in/api/register";
}

class RegisterResponse {
  int? id;
  String? token;
  String? error;

  RegisterResponse({this.id, this.token, this.error});

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      id: json['id'],
      token: json['token'],
      error: json['error'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {
      'id': id,
      'token': token,
      'error': error,
    };
    return data;
  }
}
