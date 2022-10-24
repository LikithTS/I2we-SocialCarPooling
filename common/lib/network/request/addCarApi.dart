
class AddCarApi {

  AddCarApi({
    String? regNumber,
    bool isEv = false,
    String? carName,
    int seatingCapacity = 0,
    List<String>? carPicture,
    int offeringSeats = 0,
    String? carType,
    String? carRcPicture,
  }) {
    _regNumber = regNumber;
    _isEv = isEv;
    _carName = carName;
    _seatingCapacity = seatingCapacity;
    _carPicture = carPicture;
    _offeringSeats = offeringSeats;
    _carType = carType;
    _carRcPicture = carRcPicture;
  }

  AddCarApi.fromJson(dynamic json) {
    _regNumber = json['regNumber'];
    _isEv = json['isEv'];
    _carName = json['carName'];
    _seatingCapacity = json['seatingCapacity'];
    _carPicture = json['carPictures'];
    _offeringSeats = json['offeringSeat'];
    _carType = json['carType'];
    _carRcPicture = json['rcPicture'];
  }

  String? _regNumber;
  bool _isEv = false;
  String? _carName;
  int _seatingCapacity = 0;
  List<String>? _carPicture;
  int _offeringSeats = 0;
  String? _carType;
  String? _carRcPicture;

  String? get regNumber => _regNumber;
  bool get isEv => _isEv;
  String? get carName => _carName;
  int get seatingCapacity => _seatingCapacity;
  List<String>? get carPicture => _carPicture;
  int get offeringSeats => _offeringSeats;
  String? get carType => _carType;
  String? get carRcPicture => _carRcPicture;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['regNumber'] = _regNumber;
    map['isEv'] = _isEv;
    map['carName'] = _carName;
    map['seatingCapacity'] = _seatingCapacity;
    map['carPictures'] = _carPicture;
    map['offeringSeat'] = _offeringSeats;
    map['carType'] = _carType;
    map['rcPicture'] = _carRcPicture;
    return map;
  }

}