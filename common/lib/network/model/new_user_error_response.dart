import 'dart:convert';

NewUserErrorResponse errorResponseFromJson(String str) =>
    NewUserErrorResponse.fromJson(json.decode(str));

String errorResponseToJson(NewUserErrorResponse data) => json.encode(data.toJson());

class NewUserErrorResponse {
  int? statusCode;
  String? message;
  String? error;

  NewUserErrorResponse({this.statusCode, this.message, this.error});

  NewUserErrorResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    data['error'] = this.error;
    return data;
  }
}