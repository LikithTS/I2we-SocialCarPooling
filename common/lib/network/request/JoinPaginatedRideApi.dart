import 'dart:convert';

JoinPaginatedRideApi joinPaginatedRideApiFromJson(String str) => JoinPaginatedRideApi.fromJson(json.decode(str));

String joinPaginatedRideApiToJson(JoinPaginatedRideApi data) => json.encode(data.toJson());

class JoinPaginatedRideApi {
  JoinPaginatedRideApi({
    required this.type
  });

  String type;

  factory JoinPaginatedRideApi.fromJson(Map<String, dynamic> json) => JoinPaginatedRideApi(
      type: json["type"]
  );

  Map<String, dynamic> toJson() => {
    "type": type
  };
}