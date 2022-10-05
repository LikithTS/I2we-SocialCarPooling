import 'dart:convert';

LoginApi loginFromJson(String str) => LoginApi.fromJson(json.decode(str));

String loginToJson(LoginApi data) => json.encode(data.toJson());

class LoginApi {
  LoginApi({
    String? username,
    String? password,
    String? usertype,
  }) {
    _username = username;
    _password = password;
    _usertype = usertype;
  }

  LoginApi.fromJson(dynamic json) {
    _username = json['username'];
    _password = json['password'];
    _usertype = json['usertype'];
  }

  String? _username;
  String? _password;
  String? _usertype;

  String? get username => _username;

  String? get password => _password;

  String? get usertype => _usertype;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['username'] = _username;
    map['password'] = _password;
    map['usertype'] = _usertype;
    return map;
  }
}
