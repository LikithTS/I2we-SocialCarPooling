import 'dart:convert';

SocialLoginApi loginFromJson(String str) => SocialLoginApi.fromJson(json.decode(str));

String loginToJson(SocialLoginApi data) => json.encode(data.toJson());

class SocialLoginApi {
  SocialLoginApi({
    String? name,
    String? email,
    String? phoneNumber,
    String? token,
    String? socialId
  }) {
    _name = name;
    _email = email;
    _phoneNumber = phoneNumber;
    _token = token;
    _socialId = socialId;
  }

  SocialLoginApi.fromJson(dynamic json) {
    _name = json['name'];
    _email = json['email'];
    _phoneNumber = json['phoneNumber'];
    _token = json['token'];
    _socialId = json['socialId'];
  }

  String? _name;
  String? _email;
  String? _phoneNumber;
  String? _token;
  String? _socialId;

  String? get name => _name;
  String? get email => _email;
  String? get phoneNumber => _phoneNumber;
  String? get token => _token;
  String? get socialId => _socialId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['email'] = _email;
    map['phoneNumber'] = _phoneNumber;
    map['token'] = _token;
    map['socialId'] = _socialId;
    return map;
  }
}
