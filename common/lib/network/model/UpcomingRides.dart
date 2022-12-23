import 'package:common/network/model/StartLocation.dart';
import 'package:common/network/model/Steps.dart';
import 'package:common/network/model/Stops.dart';

class UpcomingRides {
  String? _id;
  String? _riderUserId;
  String? _carTypeInterested;
  String? _driverRideId;
  int? _pricePaid;
  String? _startTime;
  String? _endTime;
  String? _startDestinationFormattedAddress;
  StartLocation? _startLocation;
  String? _startDestinationPlaceId;
  String? _endDestinationFormattedAddress;
  StartLocation? _endLocation;
  String? _endDestinationPlaceId;
  int? _profileMatchPercentage;
  int? _routeMatchPercentage;
  String? _riderStatus;
  List<Steps>? _steps;
  List<Stops>? _stops;
  String? _distance;
  String? _duration;
  String? _rideType;
  String? _driverUserId;
  String? _carId;
  int? _totalAmount;
  int? _amountPerSeat;
  int? _seatsOffered;
  String? _rideStatus;
  int? _count;

  UpcomingRides(
      {String? id,
        String? riderUserId,
        String? carTypeInterested,
        String? driverRideId,
        int? pricePaid,
        String? startTime,
        String? endTime,
        String? startDestinationFormattedAddress,
        StartLocation? startLocation,
        String? startDestinationPlaceId,
        String? endDestinationFormattedAddress,
        StartLocation? endLocation,
        String? endDestinationPlaceId,
        int? profileMatchPercentage,
        int? routeMatchPercentage,
        String? riderStatus,
        List<Steps>? steps,
        List<Stops>? stops,
        String? distance,
        String? duration,
        String? rideType,
        String? driverUserId,
        String? carId,
        int? totalAmount,
        int? amountPerSeat,
        int? seatsOffered,
        String? rideStatus,
        int? count}) {
    if (id != null) {
      this._id = id;
    }
    if (riderUserId != null) {
      this._riderUserId = riderUserId;
    }
    if (carTypeInterested != null) {
      this._carTypeInterested = carTypeInterested;
    }
    if (driverRideId != null) {
      this._driverRideId = driverRideId;
    }
    if (pricePaid != null) {
      this._pricePaid = pricePaid;
    }
    if (startTime != null) {
      this._startTime = startTime;
    }
    if (endTime != null) {
      this._endTime = endTime;
    }
    if (startDestinationFormattedAddress != null) {
      this._startDestinationFormattedAddress = startDestinationFormattedAddress;
    }
    if (startLocation != null) {
      this._startLocation = startLocation;
    }
    if (startDestinationPlaceId != null) {
      this._startDestinationPlaceId = startDestinationPlaceId;
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
    if (profileMatchPercentage != null) {
      this._profileMatchPercentage = profileMatchPercentage;
    }
    if (routeMatchPercentage != null) {
      this._routeMatchPercentage = routeMatchPercentage;
    }
    if (riderStatus != null) {
      this._riderStatus = riderStatus;
    }
    if (steps != null) {
      this._steps = steps;
    }
    if (stops != null) {
      this._stops = stops;
    }
    if (distance != null) {
      this._distance = distance;
    }
    if (duration != null) {
      this._duration = duration;
    }
    if (rideType != null) {
      this._rideType = rideType;
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
    if (seatsOffered != null) {
      this._seatsOffered = seatsOffered;
    }
    if (rideStatus != null) {
      this._rideStatus = rideStatus;
    }
    if(count != null) {
      this._count = count;
    }
  }

  String? get id => _id;
  set id(String? id) => _id = id;
  String? get riderUserId => _riderUserId;
  set riderUserId(String? riderUserId) => _riderUserId = riderUserId;
  String? get carTypeInterested => _carTypeInterested;
  set carTypeInterested(String? carTypeInterested) =>
      _carTypeInterested = carTypeInterested;
  String? get driverRideId => _driverRideId;
  set driverRideId(String? driverRideId) => _driverRideId = driverRideId;
  int? get pricePaid => _pricePaid;
  set pricePaid(int? pricePaid) => _pricePaid = pricePaid;
  String? get startTime => _startTime;
  set startTime(String? startTime) => _startTime = startTime;
  String? get endTime => _endTime;
  set endTime(String? endTime) => _endTime = endTime;
  String? get startDestinationFormattedAddress =>
      _startDestinationFormattedAddress;
  set startDestinationFormattedAddress(
      String? startDestinationFormattedAddress) =>
      _startDestinationFormattedAddress = startDestinationFormattedAddress;
  StartLocation? get startLocation => _startLocation;
  set startLocation(StartLocation? startLocation) =>
      _startLocation = startLocation;
  String? get startDestinationPlaceId => _startDestinationPlaceId;
  set startDestinationPlaceId(String? startDestinationPlaceId) =>
      _startDestinationPlaceId = startDestinationPlaceId;
  String? get endDestinationFormattedAddress => _endDestinationFormattedAddress;
  set endDestinationFormattedAddress(String? endDestinationFormattedAddress) =>
      _endDestinationFormattedAddress = endDestinationFormattedAddress;
  StartLocation? get endLocation => _endLocation;
  set endLocation(StartLocation? endLocation) => _endLocation = endLocation;
  String? get endDestinationPlaceId => _endDestinationPlaceId;
  set endDestinationPlaceId(String? endDestinationPlaceId) =>
      _endDestinationPlaceId = endDestinationPlaceId;
  int? get profileMatchPercentage => _profileMatchPercentage;
  set profileMatchPercentage(int? profileMatchPercentage) =>
      _profileMatchPercentage = profileMatchPercentage;
  int? get routeMatchPercentage => _routeMatchPercentage;
  set routeMatchPercentage(int? routeMatchPercentage) =>
      _routeMatchPercentage = routeMatchPercentage;
  String? get riderStatus => _riderStatus;
  set riderStatus(String? riderStatus) => _riderStatus = riderStatus;
  List<Steps>? get steps => _steps;
  set steps(List<Steps>? steps) => _steps = steps;
  List<Stops>? get stops => _stops;
  set stops(List<Stops>? stops) => _stops = stops;
  String? get distance => _distance;
  set distance(String? distance) => _distance = distance;
  String? get duration => _duration;
  set duration(String? duration) => _duration = duration;
  String? get rideType => _rideType;
  set rideType(String? rideType) => _rideType = rideType;
  String? get driverUserId => _driverUserId;
  set driverUserId(String? driverUserId) => _driverUserId = driverUserId;
  String? get carId => _carId;
  set carId(String? carId) => _carId = carId;
  int? get totalAmount => _totalAmount;
  set totalAmount(int? totalAmount) => _totalAmount = totalAmount;
  int? get amountPerSeat => _amountPerSeat;
  set amountPerSeat(int? amountPerSeat) => _amountPerSeat = amountPerSeat;
  int? get seatsOffered => _seatsOffered;
  set seatsOffered(int? seatsOffered) => _seatsOffered = seatsOffered;
  String? get rideStatus => _rideStatus;
  set rideStatus(String? rideStatus) => _rideStatus = rideStatus;
  int? get riderCount => _count;
  set riderCount(int? count) => _count = riderCount;

  UpcomingRides.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _riderUserId = json['riderUserId'];
    _carTypeInterested = json['carTypeInterested'];
    _driverRideId = json['driverRideId'];
    _pricePaid = json['pricePaid'];
    _startTime = json['startTime'];
    _endTime = json['endTime'];
    _startDestinationFormattedAddress =
    json['startDestinationFormattedAddress'];
    _startLocation = json['startLocation'] != null
        ? new StartLocation.fromJson(json['startLocation'])
        : null;
    _startDestinationPlaceId = json['startDestinationPlaceId'];
    _endDestinationFormattedAddress = json['endDestinationFormattedAddress'];
    _endLocation = json['endLocation'] != null
        ? new StartLocation.fromJson(json['endLocation'])
        : null;
    _endDestinationPlaceId = json['endDestinationPlaceId'];
    _profileMatchPercentage = json['profileMatchPercentage'];
    _routeMatchPercentage = json['routeMatchPercentage'];
    _riderStatus = json['riderStatus'];
    _count = json['count'];
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
    _distance = json['distance'];
    _duration = json['duration'];
    _rideType = json['rideType'];
    _driverUserId = json['driverUserId'];
    _carId = json['carId'];
    _totalAmount = json['totalAmount'];
    _amountPerSeat = json['amountPerSeat'];
    _seatsOffered = json['seatsOffered'];
    _rideStatus = json['rideStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['riderUserId'] = this._riderUserId;
    data['carTypeInterested'] = this._carTypeInterested;
    data['driverRideId'] = this._driverRideId;
    data['pricePaid'] = this._pricePaid;
    data['startTime'] = this._startTime;
    data['endTime'] = this._endTime;
    data['startDestinationFormattedAddress'] =
        this._startDestinationFormattedAddress;
    if (this._startLocation != null) {
      data['startLocation'] = this._startLocation!.toJson();
    }
    data['startDestinationPlaceId'] = this._startDestinationPlaceId;
    data['endDestinationFormattedAddress'] =
        this._endDestinationFormattedAddress;
    if (this._endLocation != null) {
      data['endLocation'] = this._endLocation!.toJson();
    }
    data['endDestinationPlaceId'] = this._endDestinationPlaceId;
    data['profileMatchPercentage'] = this._profileMatchPercentage;
    data['routeMatchPercentage'] = this._routeMatchPercentage;
    data['riderStatus'] = this._riderStatus;
    if (this._steps != null) {
      data['steps'] = this._steps!.map((v) => v.toJson()).toList();
    }
    if (this._stops != null) {
      data['stops'] = this._stops!.map((v) => v.toJson()).toList();
    }
    data['distance'] = this._distance;
    data['duration'] = this._duration;
    data['rideType'] = this._rideType;
    data['driverUserId'] = this._driverUserId;
    data['carId'] = this._carId;
    data['totalAmount'] = this._totalAmount;
    data['amountPerSeat'] = this._amountPerSeat;
    data['seatsOffered'] = this._seatsOffered;
    data['rideStatus'] = this._rideStatus;
    data['count'] = this._count;
    return data;
  }
}
