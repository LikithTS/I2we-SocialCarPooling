import 'dart:convert';

/// profileImage : "string"

ProfileImageUpdate profileImageFromJson(String str) =>
    ProfileImageUpdate.fromJson(json.decode(str));
String profileImageToJson(ProfileImageUpdate data) =>
    json.encode(data.toJson());

class ProfileImageUpdate {
  ProfileImageUpdate({
    String? profileImage,
  }) {
    _profileImage = profileImage;
  }

  ProfileImageUpdate.fromJson(dynamic json) {
    _profileImage = json['profileImage'];
  }
  String? _profileImage;
  ProfileImageUpdate copyWith({
    String? profileImage,
  }) =>
      ProfileImageUpdate(
        profileImage: profileImage ?? _profileImage,
      );
  String? get profileImage => _profileImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['profileImage'] = _profileImage;
    return map;
  }
}
