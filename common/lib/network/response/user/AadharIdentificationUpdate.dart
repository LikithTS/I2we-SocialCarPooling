import 'dart:convert';

/// userIdentificationFront : "string"
/// userIdentificationBack : "string"

AadharIdentificationUpdate aadhareIdentificationUpdateFromJson(String str) =>
    AadharIdentificationUpdate.fromJson(json.decode(str));
String aadhareIdentificationUpdateToJson(AadharIdentificationUpdate data) =>
    json.encode(data.toJson());

class AadharIdentificationUpdate {
  AadharIdentificationUpdate({
    this.userIdentificationFront,
    this.userIdentificationBack,
  });

  AadharIdentificationUpdate.fromJson(dynamic json) {
    userIdentificationFront = json['userIdentificationFront'];
    userIdentificationBack = json['userIdentificationBack'];
  }
  String? userIdentificationFront;
  String? userIdentificationBack;
  AadharIdentificationUpdate copyWith({
    String? userIdentificationFront,
    String? userIdentificationBack,
  }) =>
      AadharIdentificationUpdate(
        userIdentificationFront:
            userIdentificationFront ?? this.userIdentificationFront,
        userIdentificationBack:
            userIdentificationBack ?? this.userIdentificationBack,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userIdentificationFront'] = userIdentificationFront;
    map['userIdentificationBack'] = userIdentificationBack;
    return map;
  }
}
