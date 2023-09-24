import 'dart:convert';

ForgetPasswordApi loginFromJson(String str) => ForgetPasswordApi.fromJson(json.decode(str));

String loginToJson(ForgetPasswordApi data) => json.encode(data.toJson());

class ForgetPasswordApi {
  ForgetPasswordApi({
    String? password
  }) {
    _password = password;
  }

  ForgetPasswordApi.fromJson(dynamic json) {
    _password = json['oldPassword'];
  }

  String? _password;

  String? get password => _password;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['oldPassword'] = _password;
    return map;
  }
}
