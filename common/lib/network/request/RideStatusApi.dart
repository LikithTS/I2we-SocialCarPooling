
import 'dart:convert';

RideStatusApi rideStatusApiFromJson(String str) => RideStatusApi.fromJson(json.decode(str));

String rideStatusApiToJson(RideStatusApi data) => json.encode(data.toJson());

class RideStatusApi {
  RideStatusApi({
    required this.rideId,
    required this.rideStatus
  });

  String rideId;
  String rideStatus;

  factory RideStatusApi.fromJson(Map<String, dynamic> json) => RideStatusApi(
    rideId: json["rideId"],
    rideStatus: json["status"]
  );

  Map<String, dynamic> toJson() => {
    "rideId": rideId,
    "status": rideStatus
  };
}