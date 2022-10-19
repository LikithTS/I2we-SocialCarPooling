import 'dart:convert';

LoginApi loginFromJson(String str) => LoginApi.fromJson(json.decode(str));

String loginToJson(LoginApi data) => json.encode(data.toJson());

class LoginApi {
  LoginApi({
    String? phoneNumber,
    String? password
  }) {
    _username = phoneNumber;
    _password = password;
  }

  LoginApi.fromJson(dynamic json) {
    _username = json['phoneNumber'];
    _password = json['password'];
  }

  String? _username;
  String? _password;

  String? get username => _username;

  String? get password => _password;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['phoneNumber'] = _username;
    map['password'] = _password;
    return map;
  }
}
