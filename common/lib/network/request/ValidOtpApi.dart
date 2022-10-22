import 'dart:convert';

ValidOtpApi validOtpApiFromJson(String str) =>
    ValidOtpApi.fromJson(json.decode(str));

String validOtpApiToJson(ValidOtpApi data) => json.encode(data.toJson());

class ValidOtpApi {
  ValidOtpApi({
    required this.phoneNumber,
    required this.otp,
  });

  String phoneNumber;
  String otp;

  factory ValidOtpApi.fromJson(Map<String, dynamic> json) => ValidOtpApi(
        phoneNumber: json["phoneNumber"],
        otp: json["otp"],
      );

  Map<String, dynamic> toJson() => {
        "phoneNumber": phoneNumber,
        "otp": otp,
      };
}
