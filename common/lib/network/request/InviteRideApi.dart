
import 'dart:convert';

InviteRideApi inviteRideApiFromJson(String str) => InviteRideApi.fromJson(json.decode(str));

String inviteRideApiToJson(InviteRideApi data) => json.encode(data.toJson());

class InviteRideApi {
  InviteRideApi({
    required this.asDriverId,
    required this.asPassengerId,
    required this.type
  });

  String asDriverId;
  String asPassengerId;
  String type;

  factory InviteRideApi.fromJson(Map<String, dynamic> json) => InviteRideApi(
      asDriverId: json["asDriverId"],
      asPassengerId: json["asPassengerId"],
      type: json["type"]
  );

  Map<String, dynamic> toJson() => {
    "asDriverId": asDriverId,
    "asPassengerId": asPassengerId,
    "type": type
  };
}