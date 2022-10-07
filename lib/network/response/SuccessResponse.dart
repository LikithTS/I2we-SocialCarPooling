import 'package:json_annotation/json_annotation.dart';

part 'SuccessResponse.g.dart';

@JsonSerializable()
class SuccessResponse {
  SuccessResponse({
    int? status,
    List<dynamic>? responseData,
    String? message,
  }) {
    _status = status;
    _responseData = responseData;
    _message = message;
  }

  int? _status;
  List<dynamic>? _responseData;
  String? _message;

  int? get status => _status;

  List<dynamic>? get responseData => _responseData;

  String? get message => _message;

  factory SuccessResponse.fromJson(Map<String, dynamic> json) => _$SuccessResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SuccessResponseToJson(this);

  // Map<String, dynamic> toJson() {
  //   final map = <String, dynamic>{};
  //   map['status'] = _status;
  //   if (_responseData != null) {
  //     map['responseData'] = _responseData?.map((v) => v.toJson()).toList();
  //   }
  //   map['message'] = _message;
  //   return map;
  // }
}
