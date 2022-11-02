class Stops {
  String? placeId;
  String? lat;
  String? long;

  Stops({this.placeId, this.lat, this.long});

  Stops.fromJson(Map<String, dynamic> json) {
    placeId = json['placeId'];
    lat = json['lat'];
    long = json['long'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['placeId'] = this.placeId;
    data['lat'] = this.lat;
    data['long'] = this.long;
    return data;
  }
}