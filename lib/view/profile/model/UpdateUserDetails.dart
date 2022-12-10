// To parse this JSON data, do
//
//     final signInApi = signInApiFromJson(jsonString);

import 'dart:convert';



UserApi updaterUserApiFromJson(String str) =>
    UserApi.fromJson(json.decode(str));

String updaterUserApiToJson(UserApi data) => json.encode(data.toJson());

class UserApi {
  UserApi({
    this.bio,
    this.profileImage,
    this.designation,
    this.education,
    this.language,
    this.facebook,
    this.linkedIn,
    this.twitter,
    this.work,
    this.address1,
    this.address2,
    this.city,
    this.state,
    this.pincode,
  });

  String? bio = "";
  String? profileImage = "";
  String? designation = "";
  String? education = "";
  List<String>? language = [];
  String? facebook = "";
  String? linkedIn = "";
  String? twitter = "";
  String? work = "";
  String? address1 = "";
  String? address2 = "";
  String? city = "";
  String? state = "";
  String? pincode = "";

  factory UserApi.fromJson(Map<String, dynamic> json) => UserApi(
        bio: json["bio"],
        profileImage: json["profileImage"],
        designation: json["designation"],
        education: json["education"],
        language: json["language"],
        facebook: json["facebook"],
        linkedIn: json["linkedIn"],
        twitter: json["twitter"],
        work: json["work"],
        address1: json["address1"],
        address2: json["address2"],
        city: json["city"],
        state: json["state"],
      );

  Map<String, dynamic> toJson() => {
        "bio": bio,
        "profileImage": profileImage,
        "designation": designation,
        "education": education,
        "language": language,
        "facebook": facebook,
        "linkedIn": linkedIn,
        "twitter": twitter,
        "work": work,
        "address1": address1,
        "address2": address2,
        "city": city,
        "state": state,
        "pincode": pincode,
      };
}
