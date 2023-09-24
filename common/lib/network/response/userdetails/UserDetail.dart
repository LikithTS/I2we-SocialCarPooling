import 'dart:convert';

/// id : "63236056267a855814e999a8"
/// name : "TestUser"
/// email : "likith.ts@gmail.com"
/// age : 30
/// DOB : "1991-06-10T16:56:47.346Z"
/// address1 : ""
/// address2 : ""
/// city : ""
/// state : ""
/// pincode : ""
/// phoneNumber : "9986215749"
/// answeredQuestionnaries : [{"id":"634166c2f628ec64792bee4b","subCategories":["634166c8f628ec64792bee82","634166c8f628ec64792bee83","634166c8f628ec64792bee84"]},{"id":"634166bef628ec64792bee20","subCategories":["634166c8f628ec64792bee82","634166c8f628ec64792bee83","634166c8f628ec64792bee84"]},{"id":"634166c4f628ec64792bee5b","subCategories":["634166c8f628ec64792bee82","634166c8f628ec64792bee83","634166c8f628ec64792bee84"]},{"id":"634166c7f628ec64792bee76","subCategories":["634166c8f628ec64792bee82","634166c8f628ec64792bee83","634166c8f628ec64792bee84"]},{"id":"634166baf628ec64792bedfe","subCategories":["634166c8f628ec64792bee82","634166c8f628ec64792bee83","634166c8f628ec64792bee84"]},{"id":"634166c1f628ec64792bee3c","subCategories":["634166c8f628ec64792bee82","634166c8f628ec64792bee83","634166c8f628ec64792bee84"]},{"id":"634166c8f628ec64792bee81","subCategories":["634166c8f628ec64792bee82","634166c8f628ec64792bee83","634166c8f628ec64792bee84"]},{"id":"634166bff628ec64792bee26","subCategories":["634166c8f628ec64792bee82","634166c8f628ec64792bee83","634166c8f628ec64792bee84"]}]
/// work : ""
/// education : ""
/// password : "$2b$10$tozSo7RtdFXEca64g3hC9uxmyHD4VpHct4l1E4sL/2KvodQ17s7MK"
/// verificationStatus : "NOT_VERIFIED"
/// profileImage : "users/63236056267a855814e999a8/profileImage.jpg"
/// drivingLicence : ""
/// userIdentificationFront : ""
/// designation : ""
/// userIdentificationBack : ""
/// userPersonalIdentityDocumentType : "AADHAR"
/// hashedRt : "$2b$10$dGeoepucM112eehg4pemLOJSA618kSuW9GLpUbASzI71x.o3Lu57G"
/// bio : "my name is test I am here to test the app"
/// language : ["ENGLISH"]
/// facebook : ""
/// linkedIn : ""
/// twitter : ""
/// otp : ""
/// otpExpirationTime : ""
/// gender : "MALE"
/// percentageOfCompletion : 63

UserDetail userDetailFromJson(String str) =>
    UserDetail.fromJson(json.decode(str));
String userDetailToJson(UserDetail data) => json.encode(data.toJson());

class UserDetail {
  UserDetail({
    String? id,
    String? name,
    String? email,
    num? age,
    String? dob,
    String? address1,
    String? address2,
    String? city,
    String? state,
    String? pincode,
    String? phoneNumber,
    List<AnsweredQuestionnaries>? answeredQuestionnaries,
    String? work,
    String? education,
    String? password,
    String? verificationStatus,
    String? profileImage,
    String? drivingLicence,
    String? userIdentificationFront,
    String? designation,
    String? userIdentificationBack,
    String? userPersonalIdentityDocumentType,
    String? hashedRt,
    String? bio,
    List<String>? language,
    String? facebook,
    String? linkedIn,
    String? twitter,
    String? otp,
    String? otpExpirationTime,
    String? gender,
    String? verificationRejectedReason,
    num? percentageOfCompletion,
  }) {
    _id = id;
    _name = name;
    _email = email;
    _age = age;
    _dob = dob;
    _address1 = address1;
    _address2 = address2;
    _city = city;
    _state = state;
    _pincode = pincode;
    _phoneNumber = phoneNumber;
    _answeredQuestionnaries = answeredQuestionnaries;
    _work = work;
    _education = education;
    _password = password;
    _verificationStatus = verificationStatus;
    _profileImage = profileImage;
    _drivingLicence = drivingLicence;
    _userIdentificationFront = userIdentificationFront;
    _designation = designation;
    _userIdentificationBack = userIdentificationBack;
    _userPersonalIdentityDocumentType = userPersonalIdentityDocumentType;
    _hashedRt = hashedRt;
    _bio = bio;
    _language = language;
    _facebook = facebook;
    _linkedIn = linkedIn;
    _twitter = twitter;
    _otp = otp;
    _otpExpirationTime = otpExpirationTime;
    _gender = gender;
    _verificationRejectedReason = verificationRejectedReason;
    _percentageOfCompletion = percentageOfCompletion;
  }

  UserDetail.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _email = json['email'];
    _age = json['age'];
    _dob = json['DOB'];
    _address1 = json['address1'];
    _address2 = json['address2'];
    _city = json['city'];
    _state = json['state'];
    _pincode = json['pincode'];
    _phoneNumber = json['phoneNumber'];
    if (json['answeredQuestionnaries'] != null) {
      _answeredQuestionnaries = [];
      json['answeredQuestionnaries'].forEach((v) {
        _answeredQuestionnaries?.add(AnsweredQuestionnaries.fromJson(v));
      });
    }
    _work = json['work'];
    _education = json['education'];
    _password = json['password'];
    _verificationStatus = json['verificationStatus'];
    _profileImage = json['profileImage'];
    _drivingLicence = json['drivingLicence'];
    _userIdentificationFront = json['userIdentificationFront'];
    _designation = json['designation'];
    _userIdentificationBack = json['userIdentificationBack'];
    _userPersonalIdentityDocumentType =
        json['userPersonalIdentityDocumentType'];
    _hashedRt = json['hashedRt'];
    _bio = json['bio'];
    _language = json['language'] != null ? json['language'].cast<String>() : [];
    _facebook = json['facebook'];
    _linkedIn = json['linkedIn'];
    _twitter = json['twitter'];
    _otp = json['otp'];
    _otpExpirationTime = json['otpExpirationTime'];
    _gender = json['gender'];
    _verificationRejectedReason = json['verificationRejectedReason'];
    _percentageOfCompletion = json['percentageOfCompletion'];
  }
  String? _id;
  String? _name;
  String? _email;
  num? _age;
  String? _dob;
  String? _address1;
  String? _address2;
  String? _city;
  String? _state;
  String? _pincode;
  String? _phoneNumber;
  List<AnsweredQuestionnaries>? _answeredQuestionnaries;
  String? _work;
  String? _education;
  String? _password;
  String? _verificationStatus;
  String? _profileImage;
  String? _drivingLicence;
  String? _userIdentificationFront;
  String? _designation;
  String? _userIdentificationBack;
  String? _userPersonalIdentityDocumentType;
  String? _hashedRt;
  String? _bio;
  List<String>? _language;
  String? _facebook;
  String? _linkedIn;
  String? _twitter;
  String? _otp;
  String? _otpExpirationTime;
  String? _gender;
  String? _verificationRejectedReason;
  num? _percentageOfCompletion;
  UserDetail copyWith({
    String? id,
    String? name,
    String? email,
    num? age,
    String? dob,
    String? address1,
    String? address2,
    String? city,
    String? state,
    String? pincode,
    String? phoneNumber,
    List<AnsweredQuestionnaries>? answeredQuestionnaries,
    String? work,
    String? education,
    String? password,
    String? verificationStatus,
    String? profileImage,
    String? drivingLicence,
    String? userIdentificationFront,
    String? designation,
    String? userIdentificationBack,
    String? userPersonalIdentityDocumentType,
    String? hashedRt,
    String? bio,
    List<String>? language,
    String? facebook,
    String? linkedIn,
    String? twitter,
    String? otp,
    String? otpExpirationTime,
    String? gender,
    String? verificationRejectedReason,
    num? percentageOfCompletion,
  }) =>
      UserDetail(
        id: id ?? _id,
        name: name ?? _name,
        email: email ?? _email,
        age: age ?? _age,
        dob: dob ?? _dob,
        address1: address1 ?? _address1,
        address2: address2 ?? _address2,
        city: city ?? _city,
        state: state ?? _state,
        pincode: pincode ?? _pincode,
        phoneNumber: phoneNumber ?? _phoneNumber,
        answeredQuestionnaries:
            answeredQuestionnaries ?? _answeredQuestionnaries,
        work: work ?? _work,
        education: education ?? _education,
        password: password ?? _password,
        verificationStatus: verificationStatus ?? _verificationStatus,
        profileImage: profileImage ?? _profileImage,
        drivingLicence: drivingLicence ?? _drivingLicence,
        userIdentificationFront:
            userIdentificationFront ?? _userIdentificationFront,
        designation: designation ?? _designation,
        userIdentificationBack:
            userIdentificationBack ?? _userIdentificationBack,
        userPersonalIdentityDocumentType: userPersonalIdentityDocumentType ??
            _userPersonalIdentityDocumentType,
        hashedRt: hashedRt ?? _hashedRt,
        bio: bio ?? _bio,
        language: language ?? _language,
        facebook: facebook ?? _facebook,
        linkedIn: linkedIn ?? _linkedIn,
        twitter: twitter ?? _twitter,
        otp: otp ?? _otp,
        otpExpirationTime: otpExpirationTime ?? _otpExpirationTime,
        gender: gender ?? _gender,
        verificationRejectedReason: verificationRejectedReason ?? _verificationRejectedReason,
        percentageOfCompletion:
            percentageOfCompletion ?? _percentageOfCompletion,
      );
  String? get id => _id;
  String? get name => _name;
  String? get email => _email;
  num? get age => _age;
  String? get dob => _dob;
  String? get address1 => _address1;
  String? get address2 => _address2;
  String? get city => _city;
  String? get state => _state;
  String? get pincode => _pincode;
  String? get phoneNumber => _phoneNumber;
  List<AnsweredQuestionnaries>? get answeredQuestionnaries =>
      _answeredQuestionnaries;
  String? get work => _work;
  String? get education => _education;
  String? get password => _password;
  String? get verificationStatus => _verificationStatus;
  String? get profileImage => _profileImage;
  String? get drivingLicence => _drivingLicence;
  String? get userIdentificationFront => _userIdentificationFront;
  String? get designation => _designation;
  String? get userIdentificationBack => _userIdentificationBack;
  String? get userPersonalIdentityDocumentType =>
      _userPersonalIdentityDocumentType;
  String? get hashedRt => _hashedRt;
  String? get bio => _bio;
  List<String>? get language => _language;
  String? get facebook => _facebook;
  String? get linkedIn => _linkedIn;
  String? get twitter => _twitter;
  String? get otp => _otp;
  String? get otpExpirationTime => _otpExpirationTime;
  String? get gender => _gender;
  String? get verificationRejectedReason => _verificationRejectedReason;
  num? get percentageOfCompletion => _percentageOfCompletion;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['email'] = _email;
    map['age'] = _age;
    map['DOB'] = _dob;
    map['address1'] = _address1;
    map['address2'] = _address2;
    map['city'] = _city;
    map['state'] = _state;
    map['pincode'] = _pincode;
    map['phoneNumber'] = _phoneNumber;
    if (_answeredQuestionnaries != null) {
      map['answeredQuestionnaries'] =
          _answeredQuestionnaries?.map((v) => v.toJson()).toList();
    }
    map['work'] = _work;
    map['education'] = _education;
    map['password'] = _password;
    map['verificationStatus'] = _verificationStatus;
    map['profileImage'] = _profileImage;
    map['drivingLicence'] = _drivingLicence;
    map['userIdentificationFront'] = _userIdentificationFront;
    map['designation'] = _designation;
    map['userIdentificationBack'] = _userIdentificationBack;
    map['userPersonalIdentityDocumentType'] = _userPersonalIdentityDocumentType;
    map['hashedRt'] = _hashedRt;
    map['bio'] = _bio;
    map['language'] = _language;
    map['facebook'] = _facebook;
    map['linkedIn'] = _linkedIn;
    map['twitter'] = _twitter;
    map['otp'] = _otp;
    map['otpExpirationTime'] = _otpExpirationTime;
    map['gender'] = _gender;
    map['verificationRejectedReason'] = _verificationRejectedReason;
    map['percentageOfCompletion'] = _percentageOfCompletion;
    return map;
  }
}

/// id : "634166c2f628ec64792bee4b"
/// subCategories : ["634166c8f628ec64792bee82","634166c8f628ec64792bee83","634166c8f628ec64792bee84"]

AnsweredQuestionnaries answeredQuestionnariesFromJson(String str) =>
    AnsweredQuestionnaries.fromJson(json.decode(str));
String answeredQuestionnariesToJson(AnsweredQuestionnaries data) =>
    json.encode(data.toJson());

class AnsweredQuestionnaries {
  AnsweredQuestionnaries({
    String? id,
    List<String>? subCategories,
  }) {
    _id = id;
    _subCategories = subCategories;
  }

  AnsweredQuestionnaries.fromJson(dynamic json) {
    _id = json['id'];
    _subCategories = json['subCategories'] != null
        ? json['subCategories'].cast<String>()
        : [];
  }
  String? _id;
  List<String>? _subCategories;
  AnsweredQuestionnaries copyWith({
    String? id,
    List<String>? subCategories,
  }) =>
      AnsweredQuestionnaries(
        id: id ?? _id,
        subCategories: subCategories ?? _subCategories,
      );
  String? get id => _id;
  List<String>? get subCategories => _subCategories;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['subCategories'] = _subCategories;
    return map;
  }
}
