import 'dart:convert';

/// url : "https://i2w-data.s3-ap-south-1.amazonaws.com/users/63236056267a855814e999a8/profileImage.jpg?Content-Type=image%2Fjpeg&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAXGXJFS3T76TPE4SA%2F20221212%2Fap-south-1%2Fs3%2Faws4_request&X-Amz-Date=20221212T054026Z&X-Amz-Expires=3600&X-Amz-Signature=786a3685ff7655ca8d7ec6146c465e7dbe05ff0115cf9b6acecdf27816c20311&X-Amz-SignedHeaders=host"
/// key : "users/63236056267a855814e999a8/profileImage.jpg"

ProfileImageUpload profileImageUploadFromJson(String str) =>
    ProfileImageUpload.fromJson(json.decode(str));
String profileImageUploadToJson(ProfileImageUpload data) =>
    json.encode(data.toJson());

class ProfileImageUpload {
  ProfileImageUpload({
    String? url,
    String? key,
  }) {
    _url = url;
    _key = key;
  }

  ProfileImageUpload.fromJson(dynamic json) {
    _url = json['url'];
    _key = json['key'];
  }
  String? _url;
  String? _key;
  ProfileImageUpload copyWith({
    String? url,
    String? key,
  }) =>
      ProfileImageUpload(
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
