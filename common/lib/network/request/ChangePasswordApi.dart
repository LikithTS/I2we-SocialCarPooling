import 'dart:convert';

ChangePasswordApi loginFromJson(String str) => ChangePasswordApi.fromJson(json.decode(str));

String loginToJson(ChangePasswordApi data) => json.encode(data.toJson());

class ChangePasswordApi {
  ChangePasswordApi({
    String? phoneNumber,
    String? password
  }) {
    _username = phoneNumber;
    _password = password;
  }

  ChangePasswordApi.fromJson(dynamic json) {
    _username = json['phoneNumber'];
    _password = json['newPassword'];
  }

  String? _username;
  String? _password;

  String? get username => _username;

  String? get password => _password;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['phoneNumber'] = _username;
    map['newPassword'] = _password;
    return map;
  }
}
