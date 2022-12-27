class Profile {
  String? _id;
  String? _name;
  String? _verificationStatus;
  String? _profileImage;
  int? _percentageOfCompletion;
  String? _designation;

  Profile(
      {String? id,
        String? name,
        String? verificationStatus,
        String? profileImage,
        int? percentageOfCompletion,
        String? designation}) {
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
    if(designation != null) {
      this._designation = designation;
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
  String? get designation => _designation;
  set designation(String? designation) =>
      _designation = designation;

  Profile.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _verificationStatus = json['verificationStatus'];
    _profileImage = json['profileImage'];
    _percentageOfCompletion = json['percentageOfCompletion'];
    _designation = json['designation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    data['verificationStatus'] = this._verificationStatus;
    data['profileImage'] = this._profileImage;
    data['percentageOfCompletion'] = this._percentageOfCompletion;
    data['designation'] = this._designation;
    return data;
  }
}
