class StartDestination {
  String? formattedAddress;
  String? placeId;
  String? lat;
  String? long;

  StartDestination({this.formattedAddress, this.placeId, this.lat, this.long});

  StartDestination.fromJson(Map<String, dynamic> json) {
    formattedAddress = json['formatted_address'];
    placeId = json['placeId'];
    lat = json['lat'];
    long = json['long'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['formatted_address'] = this.formattedAddress;
    data['placeId'] = this.placeId;
    data['lat'] = this.lat;
    data['long'] = this.long;
    return data;
  }
}