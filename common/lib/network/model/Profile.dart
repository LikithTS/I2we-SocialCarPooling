class Profile {
  String? _id;
  String? _name;
  String? _verificationStatus;
  String? _profileImage;
  int? _percentageOfCompletion;

  Profile(
      {String? id,
        String? name,
        String? verificationStatus,
        String? profileImage,
        int? percentageOfCompletion}) {
    if (id != null) {
      this._id = id;
    }
    if (name != null) {
      this._name = name;
    }
    if (verificationStatus != null) {
      this._verificationStatus = verificationStatus;
    }
    if (profileImage != null) {
      this._profileImage = profileImage;
    }
    if (percentageOfCompletion != null) {
      this._percentageOfCompletion = percentageOfCompletion;
    }
  }

  String? get id => _id;
  set id(String? id) => _id = id;
  String? get name => _name;
  set name(String? name) => _name = name;
  String? get verificationStatus => _verificationStatus;
  set verificationStatus(String? verificationStatus) =>
      _verificationStatus = verificationStatus;
  String? get profileImage => _profileImage;
  set profileImage(String? profileImage) => _profileImage = profileImage;
  int? get percentageOfCompletion => _percentageOfCompletion;
  set percentageOfCompletion(int? percentageOfCompletion) =>
      _percentageOfCompletion = percentageOfCompletion;

  Profile.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _verificationStatus = json['verificationStatus'];
    _profileImage = json['profileImage'];
    _percentageOfCompletion = json['percentageOfCompletion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    data['verificationStatus'] = this._verificationStatus;
    data['profileImage'] = this._profileImage;
    data['percentageOfCompletion'] = this._percentageOfCompletion;
    return data;
  }
}
