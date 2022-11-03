import 'dart:convert';

import 'package:common/network/model/StartLocation.dart';
import 'package:common/network/model/Steps.dart';
import 'package:common/network/model/Stops.dart';

HistoryResponse historyResponseFromJson(String str) =>
    HistoryResponse.fromJson(json.decode(str));

String historyResponseToJson(HistoryResponse data) =>
    json.encode(data.toJson());

class HistoryResponse {
  List<RideData>? _rides;

  HistoryResponse({
    List<RideData>? rides,
  }) {
    _rides = rides;
  }

  HistoryResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      _rides = [];
      json['data'].forEach((v) {
        _rides?.add(RideData.fromJson(v));
      });
    }
  }

  List<RideData>? get rides => _rides;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_rides != null) {
      map['data'] = _rides?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class RideData {
  String? id;
  String? riderUserId;
  String? carTypeInterested;
  String? driverRideId;
  int? pricePaid;
  String? startTime;
  String? endTime;
  String? startDestinationFormattedAddress;
  StartLocation? startLocation;
  String? startDestinationPlaceId;
  String? endDestinationFormattedAddress;
  StartLocation? endLocation;
  String? endDestinationPlaceId;
  int? profileMatchPercentage;
  int? routeMatchPercentage;
  String? riderStatus;
  List<Steps>? steps;
  List<Stops>? stops;
  String? distance;
  String? duration;
  String? rideType;
  String? driverUserId;
  String? carId;
  int? totalAmount;
  int? amountPerSeat;
  int? seatsOffered;
  String? rideStatus;

  RideData(
      {this.id,
      this.riderUserId,
      this.carTypeInterested,
      this.driverRideId,
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
      this.steps,
      this.stops,
      this.distance,
      this.duration,
      this.rideType,
      this.driverUserId,
      this.carId,
      this.totalAmount,
      this.amountPerSeat,
      this.seatsOffered,
      this.rideStatus});

  RideData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    riderUserId = json['riderUserId'];
    carTypeInterested = json['carTypeInterested'];
    driverRideId = json['driverRideId'];
    pricePaid = json['pricePaid'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    startDestinationFormattedAddress = json['startDestinationFormattedAddress'];
    startLocation = json['startLocation'] != null
        ? StartLocation.fromJson(json['startLocation'])
        : null;
    startDestinationPlaceId = json['startDestinationPlaceId'];
    endDestinationFormattedAddress = json['endDestinationFormattedAddress'];
    endLocation = json['endLocation'] != null
        ? StartLocation.fromJson(json['endLocation'])
        : null;
    endDestinationPlaceId = json['endDestinationPlaceId'];
    profileMatchPercentage = json['profileMatchPercentage'];
    routeMatchPercentage = json['routeMatchPercentage'];
    riderStatus = json['riderStatus'];
    if (json['steps'] != null) {
      steps = <Steps>[];
      json['steps'].forEach((v) {
        steps!.add(Steps.fromJson(v));
      });
    }
    if (json['stops'] != null) {
      stops = <Stops>[];
      json['stops'].forEach((v) {
        stops!.add(Stops.fromJson(v));
      });
    }
    distance = json['distance'];
    duration = json['duration'];
    rideType = json['rideType'];
    driverUserId = json['driverUserId'];
    carId = json['carId'];
    totalAmount = json['totalAmount'];
    amountPerSeat = json['amountPerSeat'];
    seatsOffered = json['seatsOffered'];
    rideStatus = json['rideStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['riderUserId'] = riderUserId;
    data['carTypeInterested'] = carTypeInterested;
    data['driverRideId'] = driverRideId;
    data['pricePaid'] = pricePaid;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    data['startDestinationFormattedAddress'] =
        startDestinationFormattedAddress;
    if (startLocation != null) {
      data['startLocation'] = startLocation!.toJson();
    }
    data['startDestinationPlaceId'] = startDestinationPlaceId;
    data['endDestinationFormattedAddress'] =
        endDestinationFormattedAddress;
    if (endLocation != null) {
      data['endLocation'] = endLocation!.toJson();
    }
    data['endDestinationPlaceId'] = endDestinationPlaceId;
    data['profileMatchPercentage'] = profileMatchPercentage;
    data['routeMatchPercentage'] = routeMatchPercentage;
    data['riderStatus'] = riderStatus;
    if (steps != null) {
      data['steps'] = steps!.map((v) => v.toJson()).toList();
    }
    if (stops != null) {
      data['stops'] = stops!.map((v) => v.toJson()).toList();
    }
    data['distance'] = distance;
    data['duration'] = duration;
    data['rideType'] = rideType;
    data['driverUserId'] = driverUserId;
    data['carId'] = carId;
    data['totalAmount'] = totalAmount;
    data['amountPerSeat'] = amountPerSeat;
    data['seatsOffered'] = seatsOffered;
    data['rideStatus'] = rideStatus;
    return data;
  }
}
