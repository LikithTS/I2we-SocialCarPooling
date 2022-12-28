import 'package:common/network/model/Profile.dart';
import 'package:common/network/model/StartLocation.dart';

class TravelledPassengers {
  String? id;
  String? riderUserId;
  String? carTypeInterested;
  String? driverRideId;
  String? startTime;
  String? startDestinationFormattedAddress;
  StartLocation? startLocation;
  String? endDestinationFormattedAddress;
  StartLocation? endLocation;
  String? riderStatus;
  Profile? user;

  TravelledPassengers(
      {this.id,
        this.riderUserId,
        this.carTypeInterested,
        this.driverRideId,
        this.startTime,
        this.startDestinationFormattedAddress,
        this.startLocation,
        this.endDestinationFormattedAddress,
        this.endLocation,
        this.riderStatus,
        this.user,});

  TravelledPassengers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    riderUserId = json['riderUserId'];
    carTypeInterested = json['carTypeInterested'];
    driverRideId = json['driverRideId'];
    startTime = json['startTime'];
    startDestinationFormattedAddress = json['startDestinationFormattedAddress'];
    startLocation = json['startLocation'] != null
        ? new StartLocation.fromJson(json['startLocation'])
        : null;
    endDestinationFormattedAddress = json['endDestinationFormattedAddress'];
    user = json['user'] != null ? new Profile.fromJson(json['user']) : null;
    endLocation = json['endLocation'] != null
        ? new StartLocation.fromJson(json['endLocation'])
        : null;
    riderStatus = json['riderStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['riderUserId'] = this.riderUserId;
    data['carTypeInterested'] = this.carTypeInterested;
    data['driverRideId'] = this.driverRideId;
    data['startTime'] = this.startTime;
    data['startDestinationFormattedAddress'] =
        this.startDestinationFormattedAddress;
    if (this.startLocation != null) {
      data['startLocation'] = this.startLocation!.toJson();
    }
    data['endDestinationFormattedAddress'] =
        this.endDestinationFormattedAddress;
    if (this.endLocation != null) {
      data['endLocation'] = this.endLocation!.toJson();
    }
    data['riderStatus'] = this.riderStatus;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}