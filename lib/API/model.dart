class Api {
  static String url = "https://reqres.in/api/register";
  static String url2 = "https://reqres.in/api/login";
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

class LoginResponse {
  int? id;
  String? token;
  String? error;

  LoginResponse({this.id, this.token, this.error});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      id: json['id'],
      token: json['token'],
      error: json['error'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data2 = {
      'id': id,
      'token': token,
      'error': error,
    };
    return data2;
  }
}
