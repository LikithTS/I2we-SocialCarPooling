
import 'dart:convert';

SendOtpApi sendOtpApiFromJson(String str) => SendOtpApi.fromJson(json.decode(str));

String sendOtpApiToJson(SendOtpApi data) => json.encode(data.toJson());

class SendOtpApi {
  SendOtpApi({
   required this.phoneNumber,
  });

  String phoneNumber;

  factory SendOtpApi.fromJson(Map<String, dynamic> json) => SendOtpApi(
    phoneNumber: json["phoneNumber"],
  );

  Map<String, dynamic> toJson() => {
    "phoneNumber": phoneNumber,
  };
}
