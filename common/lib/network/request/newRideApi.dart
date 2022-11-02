

import 'package:common/network/request/StartDestination.dart';
import 'package:common/network/request/Steps.dart';
import 'package:common/network/request/Stops.dart';

class NewRideApi {
  StartDestination? startDestination;
  StartDestination? endDestination;
  String? rideType;
  String? startTime;
  String? carTypeInterested;
  int? seatsOffered;
  int? amountPerSeat;
  String? distance;
  String? duration;
  List<Steps>? steps;
  List<Stops>? stops;

  NewRideApi(
      {this.startDestination,
        this.endDestination,
        this.rideType,
        this.startTime,
        this.carTypeInterested,
        this.seatsOffered,
        this.amountPerSeat,
        this.distance,
        this.duration,
        this.steps,
        this.stops});

  NewRideApi.fromJson(Map<String, dynamic> json) {
    startDestination = json['startDestination'] != null
        ? new StartDestination.fromJson(json['startDestination'])
        : null;
    endDestination = json['endDestination'] != null
        ? new StartDestination.fromJson(json['endDestination'])
        : null;
    rideType = json['rideType'];
    startTime = json['startTime'];
    carTypeInterested = json['carTypeInterested'];
    seatsOffered = json['seatsOffered'];
    amountPerSeat = json['amountPerSeat'];
    distance = json['distance'];
    duration = json['duration'];
    if (json['steps'] != null) {
      steps = <Steps>[];
      json['steps'].forEach((v) {
        steps!.add(new Steps.fromJson(v));
      });
    }
    if (json['stops'] != null) {
      stops = <Stops>[];
      json['stops'].forEach((v) {
        stops!.add(new Stops.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.startDestination != null) {
      data['startDestination'] = this.startDestination!.toJson();
    }
    if (this.endDestination != null) {
      data['endDestination'] = this.endDestination!.toJson();
    }
    data['rideType'] = this.rideType;
    data['startTime'] = this.startTime;
    data['carTypeInterested'] = this.carTypeInterested;
    data['seatsOffered'] = this.seatsOffered;
    data['amountPerSeat'] = this.amountPerSeat;
    data['distance'] = this.distance;
    data['duration'] = this.duration;
    if (this.steps != null) {
      data['steps'] = this.steps!.map((v) => v.toJson()).toList();
    }
    if (this.stops != null) {
      data['stops'] = this.stops!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}