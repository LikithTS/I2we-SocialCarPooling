import 'dart:convert';

ErrorResponse errorResponseFromJson(String str) =>
    ErrorResponse.fromJson(json.decode(str));

String errorResponseToJson(ErrorResponse data) => json.encode(data.toJson());

class ErrorResponse {
  int? statusCode;
  String? message;
  List<Error>? error;
  String? errorData;

  ErrorResponse({this.statusCode, this.message, this.error});

  ErrorResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    if(statusCode == 400 || statusCode == 404) {
      errorData = json['error'];
    } else {
      if (json['error'] != null) {
        error = <Error>[];
        json['error'].forEach((v) {
          error!.add(Error.fromJson(v));
        });
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    try{
      data['error'] = this.error;
      if (this.error != null) {
        data['error'] = this.error!.map((v) => v.toJson()).toList();
      }
    }  on Exception catch (_) {
      data['error'] = this.errorData;
    }
    return data;
  }
}

class Error {
  String? property;
  String? message;

  Error({this.property, this.message});

  Error.fromJson(Map<String, dynamic> json) {
    property = json['property'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['property'] = property;
    data['message'] = message;
    return data;
  }
}