import 'package:common/network/model/Stops.dart';

import 'StartLocation.dart';

class Drivers {
  Drivers({
      this.id, 
      this.driverUserId, 
      this.carId, 
      this.totalAmount, 
      this.amountPerSeat, 
      this.distance, 
      this.duration, 
      this.startLocation, 
      this.startDestinationFormattedAddress, 
      this.startDestinationPlaceId, 
      this.seatsOffered, 
      this.startTime, 
      this.endTime, 
      this.endDestinationFormattedAddress, 
      this.endLocation, 
      this.endDestinationPlaceId, 
      this.stops, 
      this.rideStatus,});

  Drivers.fromJson(dynamic json) {
    id = json['id'];
    driverUserId = json['driverUserId'];
    carId = json['carId'];
    totalAmount = json['totalAmount'];
    amountPerSeat = json['amountPerSeat'];
    distance = json['distance'];
    duration = json['duration'];
    startLocation = json['startLocation'] != null ? StartLocation.fromJson(json['startLocation']) : null;
    startDestinationFormattedAddress = json['startDestinationFormattedAddress'];
    startDestinationPlaceId = json['startDestinationPlaceId'];
    seatsOffered = json['seatsOffered'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    endDestinationFormattedAddress = json['endDestinationFormattedAddress'];
    endLocation = json['endLocation'] != null ? StartLocation.fromJson(json['endLocation']) : null;
    endDestinationPlaceId = json['endDestinationPlaceId'];
    if (json['stops'] != null) {
      stops = [];
      json['stops'].forEach((v) {
        stops!.add(Stops.fromJson(v));
      });
    }
    rideStatus = json['rideStatus'];
  }
  String? id;
  String? driverUserId;
  String? carId;
  int? totalAmount;
  int? amountPerSeat;
  String? distance;
  String? duration;
  StartLocation? startLocation;
  String? startDestinationFormattedAddress;
  String? startDestinationPlaceId;
  int? seatsOffered;
  String? startTime;
  String? endTime;
  String? endDestinationFormattedAddress;
  StartLocation? endLocation;
  String? endDestinationPlaceId;
  List<Stops>? stops;
  String? rideStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['driverUserId'] = driverUserId;
    map['carId'] = carId;
    map['totalAmount'] = totalAmount;
    map['amountPerSeat'] = amountPerSeat;
    map['distance'] = distance;
    map['duration'] = duration;
    if (startLocation != null) {
      map['startLocation'] = startLocation!.toJson();
    }
    map['startDestinationFormattedAddress'] = startDestinationFormattedAddress;
    map['startDestinationPlaceId'] = startDestinationPlaceId;
    map['seatsOffered'] = seatsOffered;
    map['startTime'] = startTime;
    map['endTime'] = endTime;
    map['endDestinationFormattedAddress'] = endDestinationFormattedAddress;
    if (endLocation != null) {
      map['endLocation'] = endLocation!.toJson();
    }
    map['endDestinationPlaceId'] = endDestinationPlaceId;
    if (stops != null) {
      map['stops'] = stops!.map((v) => v.toJson()).toList();
    }
    map['rideStatus'] = rideStatus;
    return map;
  }

}