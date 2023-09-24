import 'dart:convert';

ChangePasswordApi loginFromJson(String str) => ChangePasswordApi.fromJson(json.decode(str));

String loginToJson(ChangePasswordApi data) => json.encode(data.toJson());

class ChangePasswordApi {
  ChangePasswordApi({
    String? oldPassword,
    String? newPassword
  }) {
    _oldPassword = oldPassword;
    _newPassword = newPassword;
  }

  ChangePasswordApi.fromJson(dynamic json) {
    _oldPassword = json['newPassword'];
    _newPassword = json['oldPassword'];
  }

  String? _oldPassword;
  String? _newPassword;

  String? get oldPassword => _oldPassword;

  String? get newPassword => _newPassword;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['newPassword'] = _oldPassword;
    map['oldPassword'] = _newPassword;
    return map;
  }
}
