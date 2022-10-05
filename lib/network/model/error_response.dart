import 'dart:convert';

ErrorResponse errorResponseFromJson(String str) =>
    ErrorResponse.fromJson(json.decode(str));

String errorResponseToJson(ErrorResponse data) => json.encode(data.toJson());

class ErrorResponse {
  ErrorResponse({
    int? status,
    int? errorCode,
    String? errorMessage,
  }) {
    _status = status;
    _errorCode = errorCode;
    _errorMessage = errorMessage;
  }

  ErrorResponse.fromJson(dynamic json) {
    _status = json['status'];
    _errorCode = json['errorCode'];
    _errorMessage = json['errorMessage'];
  }

  int? _status;
  int? _errorCode;
  String? _errorMessage;

  int? get status => _status;

  int? get errorCode => _errorCode;

  String? get errorMessage => _errorMessage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['errorCode'] = _errorCode;
    map['errorMessage'] = _errorMessage;
    return map;
  }
}
