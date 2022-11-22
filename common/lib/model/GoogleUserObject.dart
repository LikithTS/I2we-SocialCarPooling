class GoogleUserObject {
  String? displayName;
  String? email;
  String? photoUrl;
  String? accessToken;
  int? token;
  String? phoneNumber;

  GoogleUserObject(
      {this.displayName,
        this.email,
        this.photoUrl,
        this.accessToken,
        this.token,
        this.phoneNumber});

  GoogleUserObject.fromJson(Map<String, dynamic> json) {
    displayName = json['displayName'];
    email = json['email'];
    photoUrl = json['photoUrl'];
    accessToken = json['accessToken'];
    token = json['token'];
    phoneNumber = json['phoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['displayName'] = this.displayName;
    data['email'] = this.email;
    data['photoUrl'] = this.photoUrl;
    data['accessToken'] = this.accessToken;
    data['token'] = this.token;
    data['phoneNumber'] = this.phoneNumber;
    return data;
  }
}