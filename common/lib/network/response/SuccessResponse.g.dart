// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SuccessResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SuccessResponse _$SuccessResponseFromJson(Map<String, dynamic> json) {
  return SuccessResponse(
    status: json['status'] as int?,
    responseData: json['responseData'] as List<dynamic>?,
    message: json['message'] as String?,
  );
}

Map<String, dynamic> _$SuccessResponseToJson(SuccessResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'responseData': instance.responseData,
      'message': instance.message,
    };
