
import 'dart:convert';

RidePaginationApi ridePaginationApiFromJson(String str) => RidePaginationApi.fromJson(json.decode(str));

String ridePaginationApiToJson(RidePaginationApi data) => json.encode(data.toJson());

class RidePaginationApi {
  RidePaginationApi({
    required this.start,
    required this.end,
  });

  String start;
  String end;

  factory RidePaginationApi.fromJson(Map<String, dynamic> json) => RidePaginationApi(
      start: json["_start"],
      end: json["_end"],
  );

  Map<String, dynamic> toJson() => {
    "_start": start,
    "_end": end,
  };
}