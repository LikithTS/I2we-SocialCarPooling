import 'package:common/network/model/StartLocation.dart';

class Steps {
  int? _distanceInMeters;
  StartLocation? _location;

  Steps({int? distanceInMeters, StartLocation? location}) {
    if (distanceInMeters != null) {
      this._distanceInMeters = distanceInMeters;
    }
    if (location != null) {
      this._location = location;
    }
  }

  int? get distanceInMeters => _distanceInMeters;
  set distanceInMeters(int? distanceInMeters) =>
      _distanceInMeters = distanceInMeters;
  StartLocation? get location => _location;
  set location(StartLocation? location) => _location = location;

  Steps.fromJson(Map<String, dynamic> json) {
    _distanceInMeters = json['distanceInMeters'];
    _location = json['location'] != null
        ? new StartLocation.fromJson(json['location'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['distanceInMeters'] = this._distanceInMeters;
    if (this._location != null) {
      data['location'] = this._location!.toJson();
    }
    return data;
  }
}
