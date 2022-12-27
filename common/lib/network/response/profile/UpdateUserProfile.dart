import 'dart:convert';

/// bio : "string"
/// profileImage : "string"
/// designation : "string"
/// education : "PRIMARY_EDUCATION"
/// language : ["ENGLISH"]
/// facebook : "string"
/// userIdentificationFront : "string"
/// userIdentificationBack : "string"
/// drivingLicence : "string"
/// linkedIn : "string"
/// twitter : "string"
/// work : "string"
/// address1 : "string"
/// address2 : "string"
/// city : "string"
/// state : "string"
/// pincode : "string"

UpdateUserProfile updateUserProfileFromJson(String str) =>
    UpdateUserProfile.fromJson(json.decode(str));
String updateUserProfileToJson(UpdateUserProfile data) =>
    json.encode(data.toJson());

class UpdateUserProfile {
  UpdateUserProfile({
    this.bio,
    this.profileImage,
    this.designation,
    this.education,
    this.language,
    this.facebook,
    this.userIdentificationFront,
    this.userIdentificationBack,
    this.drivingLicence,
    this.linkedIn,
    this.twitter,
    this.work,
    this.address1,
    this.address2,
    this.city,
    this.state,
    this.pincode,
  });

  UpdateUserProfile.fromJson(dynamic json) {
    bio = json['bio'];
    profileImage = json['profileImage'];
    designation = json['designation'];
    education = json['education'];
    language = json['language'] != null ? json['language'].cast<String>() : [];
    facebook = json['facebook'];
    userIdentificationFront = json['userIdentificationFront'];
    userIdentificationBack = json['userIdentificationBack'];
    drivingLicence = json['drivingLicence'];
    linkedIn = json['linkedIn'];
    twitter = json['twitter'];
    work = json['work'];
    address1 = json['address1'];
    address2 = json['address2'];
    city = json['city'];
    state = json['state'];
    pincode = json['pincode'];
  }
  String? bio;
  String? profileImage;
  String? designation;
  String? education;
  List<String>? language;
  String? facebook;
  String? userIdentificationFront;
  String? userIdentificationBack;
  String? drivingLicence;
  String? linkedIn;
  String? twitter;
  String? work;
  String? address1;
  String? address2;
  String? city;
  String? state;
  String? pincode;
  UpdateUserProfile copyWith({
    String? bio,
    String? profileImage,
    String? designation,
    String? education,
    List<String>? language,
    String? facebook,
    String? userIdentificationFront,
    String? userIdentificationBack,
    String? drivingLicence,
    String? linkedIn,
    String? twitter,
    String? work,
    String? address1,
    String? address2,
    String? city,
    String? state,
    String? pincode,
    String? dob,
    String? name,
  }) =>
      UpdateUserProfile(
        bio: bio ?? this.bio,
        profileImage: profileImage ?? this.profileImage,
        designation: designation ?? this.designation,
        education: education ?? this.education,
        language: language ?? this.language,
        facebook: facebook ?? this.facebook,
        userIdentificationFront:
            userIdentificationFront ?? this.userIdentificationFront,
        userIdentificationBack:
            userIdentificationBack ?? this.userIdentificationBack,
        drivingLicence: drivingLicence ?? this.drivingLicence,
        linkedIn: linkedIn ?? this.linkedIn,
        twitter: twitter ?? this.twitter,
        work: work ?? this.work,
        address1: address1 ?? this.address1,
        address2: address2 ?? this.address2,
        city: city ?? this.city,
        state: state ?? this.state,
        pincode: pincode ?? this.pincode,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['bio'] = bio;
    map['profileImage'] = profileImage;
    map['designation'] = designation;
    map['education'] = education;
    map['language'] = language;
    map['facebook'] = facebook;
    map['userIdentificationFront'] = userIdentificationFront;
    map['userIdentificationBack'] = userIdentificationBack;
    map['drivingLicence'] = drivingLicence;
    map['linkedIn'] = linkedIn;
    map['twitter'] = twitter;
    map['work'] = work;
    map['address1'] = address1;
    map['address2'] = address2;
    map['city'] = city;
    map['state'] = state;
    map['pincode'] = pincode;
    return map;
  }
}
