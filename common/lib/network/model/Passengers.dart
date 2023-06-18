import 'package:common/network/model/Stops.dart';

import 'StartLocation.dart';

class Passengers {
  Passengers({
      this.id, 
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
      this.stops, 
      this.distance, 
      this.duration,});

  Passengers.fromJson(dynamic json) {
    id = json['id'];
    riderUserId = json['riderUserId'];
    carTypeInterested = json['carTypeInterested'];
    driverRideId = json['driverRideId'];
    pricePaid = json['pricePaid'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    startDestinationFormattedAddress = json['startDestinationFormattedAddress'];
    startLocation = json['startLocation'] != null ? StartLocation.fromJson(json['startLocation']) : null;
    startDestinationPlaceId = json['startDestinationPlaceId'];
    endDestinationFormattedAddress = json['endDestinationFormattedAddress'];
    endLocation = json['endLocation'] != null ? StartLocation.fromJson(json['endLocation']) : null;
    endDestinationPlaceId = json['endDestinationPlaceId'];
    profileMatchPercentage = json['profileMatchPercentage'];
    routeMatchPercentage = json['routeMatchPercentage'];
    riderStatus = json['riderStatus'];
    if (json['stops'] != null) {
      stops = [];
      json['stops'].forEach((v) {
        stops!.add(Stops.fromJson(v));
      });
    }
    distance = json['distance'];
    duration = json['duration'];
  }
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
  List<Stops>? stops;
  String? distance;
  String? duration;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['riderUserId'] = riderUserId;
    map['carTypeInterested'] = carTypeInterested;
    map['driverRideId'] = driverRideId;
    map['pricePaid'] = pricePaid;
    map['startTime'] = startTime;
    map['endTime'] = endTime;
    map['startDestinationFormattedAddress'] = startDestinationFormattedAddress;
    if (startLocation != null) {
      map['startLocation'] = startLocation!.toJson();
    }
    map['startDestinationPlaceId'] = startDestinationPlaceId;
    map['endDestinationFormattedAddress'] = endDestinationFormattedAddress;
    if (endLocation != null) {
      map['endLocation'] = endLocation!.toJson();
    }
    map['endDestinationPlaceId'] = endDestinationPlaceId;
    map['profileMatchPercentage'] = profileMatchPercentage;
    map['routeMatchPercentage'] = routeMatchPercentage;
    map['riderStatus'] = riderStatus;
    if (stops != null) {
      map['stops'] = stops!.map((v) => v.toJson()).toList();
    }
    map['distance'] = distance;
    map['duration'] = duration;
    return map;
  }

}