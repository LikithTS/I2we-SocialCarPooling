import 'dart:convert';

/// drivingLicence : "string"

DrivingLicenseUpdate drivingLicenseUpdateFromJson(String str) =>
    DrivingLicenseUpdate.fromJson(json.decode(str));
String drivingLicenseUpdateToJson(DrivingLicenseUpdate data) =>
    json.encode(data.toJson());

class DrivingLicenseUpdate {
  DrivingLicenseUpdate({
    String? drivingLicence,
  }) {
    _drivingLicence = drivingLicence;
  }

  DrivingLicenseUpdate.fromJson(dynamic json) {
    _drivingLicence = json['drivingLicence'];
  }
  String? _drivingLicence;
  DrivingLicenseUpdate copyWith({
    String? drivingLicence,
  }) =>
      DrivingLicenseUpdate(
        drivingLicence: drivingLicence ?? _drivingLicence,
      );
  String? get drivingLicence => _drivingLicence;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['drivingLicence'] = _drivingLicence;
    return map;
  }
}
