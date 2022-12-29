import 'dart:convert';

/// regNumber : "string"
/// isEv : true
/// carName : "string"
/// seatingCapacity : 0
/// carPictures : ["string"]
/// offeringSeat : 0
/// carType : "MINI"
/// rcPicture : "string"
/// drivingStatus : true

AddCarApi addCarApiFromJson(String str) => AddCarApi.fromJson(json.decode(str));
String addCarApiToJson(AddCarApi data) => json.encode(data.toJson());

class AddCarApi {
  AddCarApi({
    String? regNumber,
    bool? isEv,
    String? carName,
    num? seatingCapacity,
    List<String>? carPictures,
    num? offeringSeat,
    String? carType,
    String? rcPicture,
    bool? drivingStatus,
  }) {
    _regNumber = regNumber;
    _isEv = isEv;
    _carName = carName;
    _seatingCapacity = seatingCapacity;
    _carPictures = carPictures;
    _offeringSeat = offeringSeat;
    _carType = carType;
    _rcPicture = rcPicture;
    _drivingStatus = drivingStatus;
  }

  AddCarApi.fromJson(dynamic json) {
    _regNumber = json['regNumber'];
    _isEv = json['isEv'];
    _carName = json['carName'];
    _seatingCapacity = json['seatingCapacity'];
    _carPictures =
        json['carPictures'] != null ? json['carPictures'].cast<String>() : [];
    _offeringSeat = json['offeringSeat'];
    _carType = json['carType'];
    _rcPicture = json['rcPicture'];
    _drivingStatus = json['drivingStatus'];
  }
  String? _regNumber;
  bool? _isEv;
  String? _carName;
  num? _seatingCapacity;
  List<String>? _carPictures;
  num? _offeringSeat;
  String? _carType;
  String? _rcPicture;
  bool? _drivingStatus;
  AddCarApi copyWith({
    String? regNumber,
    bool? isEv,
    String? carName,
    num? seatingCapacity,
    List<String>? carPictures,
    num? offeringSeat,
    String? carType,
    String? rcPicture,
    bool? drivingStatus,
  }) =>
      AddCarApi(
        regNumber: regNumber ?? _regNumber,
        isEv: isEv ?? _isEv,
        carName: carName ?? _carName,
        seatingCapacity: seatingCapacity ?? _seatingCapacity,
        carPictures: carPictures ?? _carPictures,
        offeringSeat: offeringSeat ?? _offeringSeat,
        carType: carType ?? _carType,
        rcPicture: rcPicture ?? _rcPicture,
        drivingStatus: drivingStatus ?? _drivingStatus,
      );
  String? get regNumber => _regNumber;
  bool? get isEv => _isEv;
  String? get carName => _carName;
  num? get seatingCapacity => _seatingCapacity;
  List<String>? get carPictures => _carPictures;
  num? get offeringSeat => _offeringSeat;
  String? get carType => _carType;
  String? get rcPicture => _rcPicture;
  bool? get drivingStatus => _drivingStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['regNumber'] = _regNumber;
    map['isEv'] = _isEv;
    map['carName'] = _carName;
    map['seatingCapacity'] = _seatingCapacity;
    map['carPictures'] = _carPictures;
    map['offeringSeat'] = _offeringSeat;
    map['carType'] = _carType;
    map['rcPicture'] = _rcPicture;
    map['drivingStatus'] = _drivingStatus;
    return map;
  }
}
