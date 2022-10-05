import 'dart:convert';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    bool? active,
    String? userid,
    String? firstName,
    String? lastName,
    String? roles,
    String? password,
    String? phoneNumber,
    String? email,
    String? token,
    String? subscriberId,
    String? createdAt,
    String? cdnURL,
  }) {
    _active = active;
    _userid = userid;
    _firstName = firstName;
    _lastName = lastName;
    _roles = roles;
    _password = password;
    _phoneNumber = phoneNumber;
    _email = email;
    _token = token;
    _subscriberId = subscriberId;
    _createdAt = createdAt;
    _cdnURL = cdnURL;
  }

  LoginResponse.fromJson(dynamic json) {
    _active = json['active'];
    _userid = json['userid'];
    _firstName = json['firstName'];
    _lastName = json['lastName'];
    _roles = json['roles'];
    _password = json['password'];
    _phoneNumber = json['phoneNumber'];
    _email = json['email'];
    _token = json['token'];
    _subscriberId = json['subscriberId'];
    _createdAt = json['createdAt'];
    _cdnURL = json['cdnURL'];
  }

  bool? _active;
  String? _userid;
  String? _firstName;
  String? _lastName;
  String? _roles;
  String? _password;
  String? _phoneNumber;
  String? _email;
  String? _token;
  String? _subscriberId;
  String? _createdAt;
  String? _cdnURL;

  bool? get active => _active;

  String? get userid => _userid;

  String? get firstName => _firstName;

  String? get lastName => _lastName;

  String? get roles => _roles;

  String? get password => _password;

  String? get phoneNumber => _phoneNumber;

  String? get email => _email;

  String? get token => _token;

  dynamic get subscriberId => _subscriberId;

  String? get createdAt => _createdAt;

  String? get cdnURL => _cdnURL;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['active'] = _active;
    map['userid'] = _userid;
    map['firstName'] = _firstName;
    map['lastName'] = _lastName;
    map['roles'] = _roles;
    map['password'] = _password;
    map['phoneNumber'] = _phoneNumber;
    map['email'] = _email;
    map['token'] = _token;
    map['subscriberId'] = _subscriberId;
    map['createdAt'] = _createdAt;
    map['cdnURL'] = _cdnURL;
    return map;
  }
}
