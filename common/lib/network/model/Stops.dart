import 'package:common/network/model/StartLocation.dart';

class Stops {
  String? _placeId;
  StartLocation? _location;

  Stops({String? placeId, StartLocation? location}) {
    if (placeId != null) {
      this._placeId = placeId;
    }
    if (location != null) {
      this._location = location;
    }
  }

  String? get placeId => _placeId;
  set placeId(String? placeId) => _placeId = placeId;
  StartLocation? get location => _location;
  set location(StartLocation? location) => _location = location;

  Stops.fromJson(Map<String, dynamic> json) {
    _placeId = json['placeId'];
    _location = json['location'] != null
        ? new StartLocation.fromJson(json['location'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['placeId'] = this._placeId;
    if (this._location != null) {
      data['location'] = this._location!.toJson();
    }
    return data;
  }
}