class Steps {
  int? distanceInMeters;
  String? lat;
  String? long;

  Steps({this.distanceInMeters, this.lat, this.long});

  Steps.fromJson(Map<String, dynamic> json) {
    distanceInMeters = json['distanceInMeters'];
    lat = json['lat'];
    long = json['long'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['distanceInMeters'] = this.distanceInMeters;
    data['lat'] = this.lat;
    data['long'] = this.long;
    return data;
  }
}