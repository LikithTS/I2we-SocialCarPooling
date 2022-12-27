import 'dart:convert';

UploadUrl uploadUrlFromJson(String str) => UploadUrl.fromJson(json.decode(str));

String uploadUrlToJson(UploadUrl data) => json.encode(data.toJson());

class UploadUrl {
  UploadUrl({
    int? statusCode,
    String? data,
    String? message,
  }) {
    _statusCode = statusCode;
    _data = data;
    _message = message;
  }

  UploadUrl.fromJson(dynamic json) {
    _statusCode = json['statusCode'];
    _data = json['data'];
    _data = json['message'];
  }

  int? _statusCode;
  String? _data;
  String? _message;

  int? get statusCode => _statusCode;

  String? get data => _data;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['statusCode'] = _statusCode;
    map['data'] = _data;
    map['message'] = _message;
    return map;
  }
}
