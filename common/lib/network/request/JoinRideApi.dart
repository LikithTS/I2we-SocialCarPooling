import 'dart:convert';

JoinRideApi joinRideApiFromJson(String str) => JoinRideApi.fromJson(json.decode(str));

String joinRideApiToJson(JoinRideApi data) => json.encode(data.toJson());

class JoinRideApi {
  JoinRideApi({
    required this.inviteId
  });

  String inviteId;

  factory JoinRideApi.fromJson(Map<String, dynamic> json) => JoinRideApi(
      inviteId: json["inviteId"]
  );

  Map<String, dynamic> toJson() => {
    "inviteId": inviteId
  };
}