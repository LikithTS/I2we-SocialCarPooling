// To parse this JSON data, do
//
//     final signInApi = signInApiFromJson(jsonString);

import 'dart:convert';

SignInApi signInApiFromJson(String str) => SignInApi.fromJson(json.decode(str));

String signInApiToJson(SignInApi data) => json.encode(data.toJson());

class SignInApi {
  SignInApi({
    required this.name,
    this.education,
    this.gender,
    this.email,
    this.age,
    this.dob,
    this.address1,
    this.address2,
    this.city,
    this.state,
    this.pincode,
    required this.phoneNumber,
    this.work,
    required this.password,
  });

  String name;
  String? education;
  String? gender;
  String? email;
  int? age;
  String? dob;
  String? address1;
  String? address2;
  String? city;
  String? state;
  String? pincode;
  String phoneNumber;
  String? work;
  String password;

  factory SignInApi.fromJson(Map<String, dynamic> json) => SignInApi(
        name: json["name"],
        education: json["education"],
        gender: json["gender"],
        email: json["email"],
        age: json["age"],
        dob: json["DOB"],
        address1: json["address1"],
        address2: json["address2"],
        city: json["city"],
        state: json["state"],
        pincode: json["pincode"],
        phoneNumber: json["phoneNumber"],
        work: json["work"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "education": education,
        "gender": gender,
        "email": email,
        "age": age,
        "DOB": dob,
        "address1": address1,
        "address2": address2,
        "city": city,
        "state": state,
        "pincode": pincode,
        "phoneNumber": phoneNumber,
        "work": work,
        "password": password,
      };
}
