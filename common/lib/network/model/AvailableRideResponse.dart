import 'dart:developer';

import 'package:common/network/model/MyCars.dart';
import 'package:common/network/model/Profile.dart';
import 'package:common/network/model/StartLocation.dart';
import 'package:common/network/model/Steps.dart';
import 'package:common/network/model/Stops.dart';

class AvailableRidesResponse {
  String? id;
  String? driverUserId;
  String? riderUserId;
  String? carTypeInterested;
  String? driverRideId;
  String? carId;
  int? amountPerSeat;
  String? distance;
  String? duration;
  StartLocation? startLocation;
  int? pricePaid;
  String? startTime;
  String? endTime;
  String? startDestinationFormattedAddress;
  String? startDestinationPlaceId;
  int? seatsOffered;
  String? endDestinationFormattedAddress;
  StartLocation? endLocation;
  String? endDestinationPlaceId;
  int? profileMatchPercentage;
  int? routeMatchPercentage;
  String? riderStatus;
  List<Stops>? stops;
  List<Steps>? steps;
  Profile? user;
  MyCars? car;
  double? rideMatchPercentage;
  int? profileMatchingPercentage;

  AvailableRidesResponse(
      {this.id,
        this.driverUserId,
        this.riderUserId,
        this.carTypeInterested,
        this.driverRideId,
        this.carId,
        this.amountPerSeat,
        this.seatsOffered,
        this.pricePaid,
        this.startTime,
        this.endTime,
        this.startDestinationFormattedAddress,
        this.startLocation,
        this.startDestinationPlaceId,
        this.endDestinationFormattedAddress,
        this.endLocation,
        this.endDestinationPlaceId,
        this.profileMatchPercentage,
        this.routeMatchPercentage,
        this.riderStatus,
        this.stops,
        this.distance,
        this.duration,
        this.steps,
        this.user,
        this.car,
        this.rideMatchPercentage,
        this.profileMatchingPercentage});

  AvailableRidesResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    driverUserId = json['driverUserId'];
    riderUserId = json['riderUserId'];
    carTypeInterested = json['carTypeInterested'];
    driverRideId = json['driverRideId'];
    carId = json['carId'];
    amountPerSeat = json['amountPerSeat'];
    pricePaid = json['pricePaid'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    startDestinationFormattedAddress = json['startDestinationFormattedAddress'];
    startLocation = json['startLocation'] != null
        ? new StartLocation.fromJson(json['startLocation'])
        : null;
    startDestinationPlaceId = json['startDestinationPlaceId'];
    endDestinationFormattedAddress = json['endDestinationFormattedAddress'];
    endLocation = json['endLocation'] != null
        ? new StartLocation.fromJson(json['endLocation'])
        : null;
    endDestinationPlaceId = json['endDestinationPlaceId'];
    profileMatchPercentage = json['profileMatchPercentage'];
    routeMatchPercentage = json['routeMatchPercentage'];
    riderStatus = json['riderStatus'];
    seatsOffered = json['seatsOffered'];
    startTime = json['startTime'];
    if (json['stops'] != null) {
      stops = <Stops>[];
      json['stops'].forEach((v) {
        stops!.add(new Stops.fromJson(v));
      });
    }
    distance = json['distance'];
    duration = json['duration'];
    car = json['car'] != null ? new MyCars.fromJson(json['car']) : null;
    if (json['steps'] != null) {
      steps = <Steps>[];
      json['steps'].forEach((v) {
        steps!.add(new Steps.fromJson(v));
      });
    }
    user = json['user'] != null ? new Profile.fromJson(json['user']) : null;
    rideMatchPercentage = json['rideMatchPercentage'];
    profileMatchingPercentage = json['profileMatchingPercentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['riderUserId'] = this.riderUserId;
    data['carId'] = this.carId;
    data['amountPerSeat'] = this.amountPerSeat;
    data['carTypeInterested'] = this.carTypeInterested;
    data['driverRideId'] = this.driverRideId;
    data['pricePaid'] = this.pricePaid;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['startDestinationFormattedAddress'] =
        this.startDestinationFormattedAddress;
    if (this.startLocation != null) {
      data['startLocation'] = this.startLocation!.toJson();
    }
    data['startDestinationPlaceId'] = this.startDestinationPlaceId;
    data['endDestinationFormattedAddress'] =
        this.endDestinationFormattedAddress;
    if (this.endLocation != null) {
      data['endLocation'] = this.endLocation!.toJson();
    }
    data['endDestinationPlaceId'] = this.endDestinationPlaceId;
    data['profileMatchPercentage'] = this.profileMatchPercentage;
    data['routeMatchPercentage'] = this.routeMatchPercentage;
    data['riderStatus'] = this.riderStatus;
    if (this.stops != null) {
      data['stops'] = this.stops!.map((v) => v.toJson()).toList();
    }
    data['distance'] = this.distance;
    data['duration'] = this.duration;
    if (this.steps != null) {
      data['steps'] = this.steps!.map((v) => v.toJson()).toList();
    }
    data['seatsOffered'] = this.seatsOffered;
    data['startTime'] = this.startTime;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['rideMatchPercentage'] = this.rideMatchPercentage;
    data['profileMatchingPercentage'] = this.profileMatchingPercentage;
    return data;
  }
}
