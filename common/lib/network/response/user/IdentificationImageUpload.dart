import 'dart:convert';

/// front_verification_url : {"url":"https://i2w-data.s3-ap-south-1.amazonaws.com/users/63236056267a855814e999a8/identification-front.jpg?Content-Type=image%2Fjpeg&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAXGXJFS3T76TPE4SA%2F20221222%2Fap-south-1%2Fs3%2Faws4_request&X-Amz-Date=20221222T093320Z&X-Amz-Expires=7200&X-Amz-Signature=12b793c201ac7cbdda80f73278efd1946e22f0a4712cf469c115df10e63c314d&X-Amz-SignedHeaders=host","key":"users/63236056267a855814e999a8/identification-front.jpg"}
/// back_verification_url : {"url":"https://i2w-data.s3-ap-south-1.amazonaws.com/users/63236056267a855814e999a8/identification-front.jpg?Content-Type=image%2Fjpeg&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAXGXJFS3T76TPE4SA%2F20221222%2Fap-south-1%2Fs3%2Faws4_request&X-Amz-Date=20221222T093320Z&X-Amz-Expires=7200&X-Amz-Signature=12b793c201ac7cbdda80f73278efd1946e22f0a4712cf469c115df10e63c314d&X-Amz-SignedHeaders=host","key":"users/63236056267a855814e999a8/identification-front.jpg"}

IdentificationImageUpload identificationImageUploadFromJson(String str) =>
    IdentificationImageUpload.fromJson(json.decode(str));
String identificationImageUploadToJson(IdentificationImageUpload data) =>
    json.encode(data.toJson());

class IdentificationImageUpload {
  IdentificationImageUpload({
    FrontVerificationUrl? frontVerificationUrl,
    BackVerificationUrl? backVerificationUrl,
  }) {
    _frontVerificationUrl = frontVerificationUrl;
    _backVerificationUrl = backVerificationUrl;
  }

  IdentificationImageUpload.fromJson(dynamic json) {
    _frontVerificationUrl = json['front_verification_url'] != null
        ? FrontVerificationUrl.fromJson(json['front_verification_url'])
        : null;
    _backVerificationUrl = json['back_verification_url'] != null
        ? BackVerificationUrl.fromJson(json['back_verification_url'])
        : null;
  }
  FrontVerificationUrl? _frontVerificationUrl;
  BackVerificationUrl? _backVerificationUrl;
  IdentificationImageUpload copyWith({
    FrontVerificationUrl? frontVerificationUrl,
    BackVerificationUrl? backVerificationUrl,
  }) =>
      IdentificationImageUpload(
        frontVerificationUrl: frontVerificationUrl ?? _frontVerificationUrl,
        backVerificationUrl: backVerificationUrl ?? _backVerificationUrl,
      );
  FrontVerificationUrl? get frontVerificationUrl => _frontVerificationUrl;
  BackVerificationUrl? get backVerificationUrl => _backVerificationUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_frontVerificationUrl != null) {
      map['front_verification_url'] = _frontVerificationUrl?.toJson();
    }
    if (_backVerificationUrl != null) {
      map['back_verification_url'] = _backVerificationUrl?.toJson();
    }
    return map;
  }
}

/// url : "https://i2w-data.s3-ap-south-1.amazonaws.com/users/63236056267a855814e999a8/identification-front.jpg?Content-Type=image%2Fjpeg&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAXGXJFS3T76TPE4SA%2F20221222%2Fap-south-1%2Fs3%2Faws4_request&X-Amz-Date=20221222T093320Z&X-Amz-Expires=7200&X-Amz-Signature=12b793c201ac7cbdda80f73278efd1946e22f0a4712cf469c115df10e63c314d&X-Amz-SignedHeaders=host"
/// key : "users/63236056267a855814e999a8/identification-front.jpg"

BackVerificationUrl backVerificationUrlFromJson(String str) =>
    BackVerificationUrl.fromJson(json.decode(str));
String backVerificationUrlToJson(BackVerificationUrl data) =>
    json.encode(data.toJson());

class BackVerificationUrl {
  BackVerificationUrl({
    String? url,
    String? key,
  }) {
    _url = url;
    _key = key;
  }

  BackVerificationUrl.fromJson(dynamic json) {
    _url = json['url'];
    _key = json['key'];
  }
  String? _url;
  String? _key;
  BackVerificationUrl copyWith({
    String? url,
    String? key,
  }) =>
      BackVerificationUrl(
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

/// url : "https://i2w-data.s3-ap-south-1.amazonaws.com/users/63236056267a855814e999a8/identification-front.jpg?Content-Type=image%2Fjpeg&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAXGXJFS3T76TPE4SA%2F20221222%2Fap-south-1%2Fs3%2Faws4_request&X-Amz-Date=20221222T093320Z&X-Amz-Expires=7200&X-Amz-Signature=12b793c201ac7cbdda80f73278efd1946e22f0a4712cf469c115df10e63c314d&X-Amz-SignedHeaders=host"
/// key : "users/63236056267a855814e999a8/identification-front.jpg"

FrontVerificationUrl frontVerificationUrlFromJson(String str) =>
    FrontVerificationUrl.fromJson(json.decode(str));
String frontVerificationUrlToJson(FrontVerificationUrl data) =>
    json.encode(data.toJson());

class FrontVerificationUrl {
  FrontVerificationUrl({
    String? url,
    String? key,
  }) {
    _url = url;
    _key = key;
  }

  FrontVerificationUrl.fromJson(dynamic json) {
    _url = json['url'];
    _key = json['key'];
  }
  String? _url;
  String? _key;
  FrontVerificationUrl copyWith({
    String? url,
    String? key,
  }) =>
      FrontVerificationUrl(
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
