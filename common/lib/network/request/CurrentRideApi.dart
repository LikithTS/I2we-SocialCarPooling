
import 'dart:convert';

CurrentRideApi rideStatusApiFromJson(String str) => CurrentRideApi.fromJson(json.decode(str));

String rideStatusApiToJson(CurrentRideApi data) => json.encode(data.toJson());

class CurrentRideApi {
  CurrentRideApi({
    required this.rideId,
    required this.rideType
  });

  String rideId;
  String rideType;

  factory CurrentRideApi.fromJson(Map<String, dynamic> json) => CurrentRideApi(
      rideId: json["rideId"],
      rideType: json["rideType"]
  );

  Map<String, dynamic> toJson() => {
    "rideId": rideId,
    "rideType": rideType
  };
}