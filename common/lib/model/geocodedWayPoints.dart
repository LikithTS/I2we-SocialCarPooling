

class GeocodedWaypoints {
  String? geocoderStatus;
  String? placeId;

  GeocodedWaypoints({this.geocoderStatus, this.placeId});

  GeocodedWaypoints.fromJson(Map<String, dynamic> json) {
    geocoderStatus = json['geocoder_status'];
    placeId = json['place_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['geocoder_status'] = this.geocoderStatus;
    data['place_id'] = this.placeId;
    return data;
  }
}