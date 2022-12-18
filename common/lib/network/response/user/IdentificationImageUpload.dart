import 'dart:convert';

/// statusCode : 200
/// data : [{"url":"https://i2w-data.s3-ap-south-1.amazonaws.com/users/63236056267a855814e999a8/identification-front.jpg?Content-Type=image%2Fjpeg&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAXGXJFS3T76TPE4SA%2F20221218%2Fap-south-1%2Fs3%2Faws4_request&X-Amz-Date=20221218T093653Z&X-Amz-Expires=7200&X-Amz-Signature=7abcdbec2782b4694bc3759bede755766899cc9f6c4ab85e0991e34a2094b750&X-Amz-SignedHeaders=host","key":"users/63236056267a855814e999a8/identification-front.jpg"},{"url":"https://i2w-data.s3-ap-south-1.amazonaws.com/users/63236056267a855814e999a8/identification-back.jpg?Content-Type=image%2Fjpeg&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAXGXJFS3T76TPE4SA%2F20221218%2Fap-south-1%2Fs3%2Faws4_request&X-Amz-Date=20221218T093653Z&X-Amz-Expires=7200&X-Amz-Signature=73da0b4dedcb92187b9421a2900cd489e566fa41788c49d9f7536c4070cd9690&X-Amz-SignedHeaders=host","key":"users/63236056267a855814e999a8/identification-back.jpg"}]
/// message : ""

IdentificationImageUpload identificationImageUploadFromJson(String str) =>
    IdentificationImageUpload.fromJson(json.decode(str));
String identificationImageUploadToJson(IdentificationImageUpload data) =>
    json.encode(data.toJson());

class IdentificationImageUpload {
  IdentificationImageUpload({
    num? statusCode,
    List<Data>? data,
    String? message,
  }) {
    _statusCode = statusCode;
    _data = data;
    _message = message;
  }

  IdentificationImageUpload.fromJson(dynamic json) {
    _statusCode = json['statusCode'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
    _message = json['message'];
  }
  num? _statusCode;
  List<Data>? _data;
  String? _message;
  IdentificationImageUpload copyWith({
    num? statusCode,
    List<Data>? data,
    String? message,
  }) =>
      IdentificationImageUpload(
        statusCode: statusCode ?? _statusCode,
        data: data ?? _data,
        message: message ?? _message,
      );
  num? get statusCode => _statusCode;
  List<Data>? get data => _data;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['statusCode'] = _statusCode;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['message'] = _message;
    return map;
  }
}

/// url : "https://i2w-data.s3-ap-south-1.amazonaws.com/users/63236056267a855814e999a8/identification-front.jpg?Content-Type=image%2Fjpeg&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAXGXJFS3T76TPE4SA%2F20221218%2Fap-south-1%2Fs3%2Faws4_request&X-Amz-Date=20221218T093653Z&X-Amz-Expires=7200&X-Amz-Signature=7abcdbec2782b4694bc3759bede755766899cc9f6c4ab85e0991e34a2094b750&X-Amz-SignedHeaders=host"
/// key : "users/63236056267a855814e999a8/identification-front.jpg"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    String? url,
    String? key,
  }) {
    _url = url;
    _key = key;
  }

  Data.fromJson(dynamic json) {
    _url = json['url'];
    _key = json['key'];
  }
  String? _url;
  String? _key;
  Data copyWith({
    String? url,
    String? key,
  }) =>
      Data(
        url: url ?? _url,
        key: key ?? _key,
      );
  String? get url => _url;
  String? get key => _key;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = _url;
    map['key'] = _key;
    return map;
  }
}
