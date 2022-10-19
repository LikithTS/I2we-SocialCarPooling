import 'package:common/network/model/StartLocation.dart';
import 'package:common/network/model/Steps.dart';
import 'package:common/network/model/Stops.dart';

class RecentRides {
  String? _id;
  String? _driverUserId;
  String? _carId;
  int? _totalAmount;
  int? _amountPerSeat;
  String? _distance;
  String? _duration;
  StartLocation? _startLocation;
  String? _startDestinationFormattedAddress;
  String? _startDestinationPlaceId;
  int? _seatsOffered;
  String? _startTime;
  String? _endTime;
  String? _endDestinationFormattedAddress;
  StartLocation? _endLocation;
  String? _endDestinationPlaceId;
  List<Steps>? _steps;
  List<Stops>? _stops;
  String? _rideStatus;
  String? _rideType;

  RecentRides(
      {String? id,
        String? driverUserId,
        String? carId,
        int? totalAmount,
        int? amountPerSeat,
        String? distance,
        String? duration,
        StartLocation? startLocation,
        String? startDestinationFormattedAddress,
        String? startDestinationPlaceId,
        int? seatsOffered,
        String? startTime,
        String? endTime,
        String? endDestinationFormattedAddress,
        StartLocation? endLocation,
        String? endDestinationPlaceId,
        List<Steps>? steps,
        List<Stops>? stops,
        String? rideStatus,
        String? rideType}) {
    if (id != null) {
      this._id = id;
    }
    if (driverUserId != null) {
      this._driverUserId = driverUserId;
    }
    if (carId != null) {
      this._carId = carId;
    }
    if (totalAmount != null) {
      this._totalAmount = totalAmount;
    }
    if (amountPerSeat != null) {
      this._amountPerSeat = amountPerSeat;
    }
    if (distance != null) {
      this._distance = distance;
    }
    if (duration != null) {
      this._duration = duration;
    }
    if (startLocation != null) {
      this._startLocation = startLocation;
    }
    if (startDestinationFormattedAddress != null) {
      this._startDestinationFormattedAddress = startDestinationFormattedAddress;
    }
    if (startDestinationPlaceId != null) {
      this._startDestinationPlaceId = startDestinationPlaceId;
    }
    if (seatsOffered != null) {
      this._seatsOffered = seatsOffered;
    }
    if (startTime != null) {
      this._startTime = startTime;
    }
    if (endTime != null) {
      this._endTime = endTime;
    }
    if (endDestinationFormattedAddress != null) {
      this._endDestinationFormattedAddress = endDestinationFormattedAddress;
    }
    if (endLocation != null) {
      this._endLocation = endLocation;
    }
    if (endDestinationPlaceId != null) {
      this._endDestinationPlaceId = endDestinationPlaceId;
    }
    if (steps != null) {
      this._steps = steps;
    }
    if (stops != null) {
      this._stops = stops;
    }
    if (rideStatus != null) {
      this._rideStatus = rideStatus;
    }
    if (rideType != null) {
      this._rideType = rideType;
    }
  }

  String? get id => _id;
  set id(String? id) => _id = id;
  String? get driverUserId => _driverUserId;
  set driverUserId(String? driverUserId) => _driverUserId = driverUserId;
  String? get carId => _carId;
  set carId(String? carId) => _carId = carId;
  int? get totalAmount => _totalAmount;
  set totalAmount(int? totalAmount) => _totalAmount = totalAmount;
  int? get amountPerSeat => _amountPerSeat;
  set amountPerSeat(int? amountPerSeat) => _amountPerSeat = amountPerSeat;
  String? get distance => _distance;
  set distance(String? distance) => _distance = distance;
  String? get duration => _duration;
  set duration(String? duration) => _duration = duration;
  StartLocation? get startLocation => _startLocation;
  set startLocation(StartLocation? startLocation) =>
      _startLocation = startLocation;
  String? get startDestinationFormattedAddress =>
      _startDestinationFormattedAddress;
  set startDestinationFormattedAddress(
      String? startDestinationFormattedAddress) =>
      _startDestinationFormattedAddress = startDestinationFormattedAddress;
  String? get startDestinationPlaceId => _startDestinationPlaceId;
  set startDestinationPlaceId(String? startDestinationPlaceId) =>
      _startDestinationPlaceId = startDestinationPlaceId;
  int? get seatsOffered => _seatsOffered;
  set seatsOffered(int? seatsOffered) => _seatsOffered = seatsOffered;
  String? get startTime => _startTime;
  set startTime(String? startTime) => _startTime = startTime;
  String? get endTime => _endTime;
  set endTime(String? endTime) => _endTime = endTime;
  String? get endDestinationFormattedAddress => _endDestinationFormattedAddress;
  set endDestinationFormattedAddress(String? endDestinationFormattedAddress) =>
      _endDestinationFormattedAddress = endDestinationFormattedAddress;
  StartLocation? get endLocation => _endLocation;
  set endLocation(StartLocation? endLocation) => _endLocation = endLocation;
  String? get endDestinationPlaceId => _endDestinationPlaceId;
  set endDestinationPlaceId(String? endDestinationPlaceId) =>
      _endDestinationPlaceId = endDestinationPlaceId;
  List<Steps>? get steps => _steps;
  set steps(List<Steps>? steps) => _steps = steps;
  List<Stops>? get stops => _stops;
  set stops(List<Stops>? stops) => _stops = stops;
  String? get rideStatus => _rideStatus;
  set rideStatus(String? rideStatus) => _rideStatus = rideStatus;
  String? get rideType => _rideType;
  set rideType(String? rideType) => _rideType = rideType;

  RecentRides.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _driverUserId = json['driverUserId'];
    _carId = json['carId'];
    _totalAmount = json['totalAmount'];
    _amountPerSeat = json['amountPerSeat'];
    _distance = json['distance'];
    _duration = json['duration'];
    _startLocation = json['startLocation'] != null
        ? new StartLocation.fromJson(json['startLocation'])
        : null;
    _startDestinationFormattedAddress =
    json['startDestinationFormattedAddress'];
    _startDestinationPlaceId = json['startDestinationPlaceId'];
    _seatsOffered = json['seatsOffered'];
    _startTime = json['startTime'];
    _endTime = json['endTime'];
    _endDestinationFormattedAddress = json['endDestinationFormattedAddress'];
    _endLocation = json['endLocation'] != null
        ? new StartLocation.fromJson(json['endLocation'])
        : null;
    _endDestinationPlaceId = json['endDestinationPlaceId'];
    if (json['steps'] != null) {
      _steps = <Steps>[];
      json['steps'].forEach((v) {
        _steps!.add(new Steps.fromJson(v));
      });
    }
    if (json['stops'] != null) {
      _stops = <Stops>[];
      json['stops'].forEach((v) {
        _stops!.add(new Stops.fromJson(v));
      });
    }
    _rideStatus = json['rideStatus'];
    _rideType = json['rideType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['driverUserId'] = this._driverUserId;
    data['carId'] = this._carId;
    data['totalAmount'] = this._totalAmount;
    data['amountPerSeat'] = this._amountPerSeat;
    data['distance'] = this._distance;
    data['duration'] = this._duration;
    if (this._startLocation != null) {
      data['startLocation'] = this._startLocation!.toJson();
    }
    data['startDestinationFormattedAddress'] =
        this._startDestinationFormattedAddress;
    data['startDestinationPlaceId'] = this._startDestinationPlaceId;
    data['seatsOffered'] = this._seatsOffered;
    data['startTime'] = this._startTime;
    data['endTime'] = this._endTime;
    data['endDestinationFormattedAddress'] =
        this._endDestinationFormattedAddress;
    if (this._endLocation != null) {
      data['endLocation'] = this._endLocation!.toJson();
    }
    data['endDestinationPlaceId'] = this._endDestinationPlaceId;
    if (this._steps != null) {
      data['steps'] = this._steps!.map((v) => v.toJson()).toList();
    }
    if (this._stops != null) {
      data['stops'] = this._stops!.map((v) => v.toJson()).toList();
    }
    data['rideStatus'] = this._rideStatus;
    data['rideType'] = this._rideType;
    return data;
  }
}