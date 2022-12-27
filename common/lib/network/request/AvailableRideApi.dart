import 'dart:convert';

AvailableRideApi availableRideApiFromJson(String str) => AvailableRideApi.fromJson(json.decode(str));

String availableRideApiToJson(AvailableRideApi data) => json.encode(data.toJson());

class AvailableRideApi {
  AvailableRideApi({
    required this.rideId,
    required this.rideType
  });

  String rideId;
  String rideType;

  factory AvailableRideApi.fromJson(Map<String, dynamic> json) => AvailableRideApi(
      rideId: json["rideId"],
      rideType: json["rideType"]
  );

  Map<String, dynamic> toJson() => {
    "rideId": rideId,
    "rideType": rideType
  };
}