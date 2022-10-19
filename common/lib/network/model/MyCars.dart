class MyCars {
  String? _id;
  String? _regNumber;
  String? _carName;
  bool? _drivingStatus;
  bool? _isEv;
  int? _seatingCapacity;
  int? _offeringSeat;
  List<String>? _carPictures;
  String? _carType;

  MyCars(
      {String? id,
        String? regNumber,
        String? carName,
        bool? drivingStatus,
        bool? isEv,
        int? seatingCapacity,
        int? offeringSeat,
        List<String>? carPictures,
        String? carType}) {
    if (id != null) {
      this._id = id;
    }
    if (regNumber != null) {
      this._regNumber = regNumber;
    }
    if (carName != null) {
      this._carName = carName;
    }
    if (drivingStatus != null) {
      this._drivingStatus = drivingStatus;
    }
    if (isEv != null) {
      this._isEv = isEv;
    }
    if (seatingCapacity != null) {
      this._seatingCapacity = seatingCapacity;
    }
    if (offeringSeat != null) {
      this._offeringSeat = offeringSeat;
    }
    if (carPictures != null) {
      this._carPictures = carPictures;
    }
    if (carType != null) {
      this._carType = carType;
    }
  }

  String? get id => _id;
  set id(String? id) => _id = id;
  String? get regNumber => _regNumber;
  set regNumber(String? regNumber) => _regNumber = regNumber;
  String? get carName => _carName;
  set carName(String? carName) => _carName = carName;
  bool? get drivingStatus => _drivingStatus;
  set drivingStatus(bool? drivingStatus) => _drivingStatus = drivingStatus;
  bool? get isEv => _isEv;
  set isEv(bool? isEv) => _isEv = isEv;
  int? get seatingCapacity => _seatingCapacity;
  set seatingCapacity(int? seatingCapacity) =>
      _seatingCapacity = seatingCapacity;
  int? get offeringSeat => _offeringSeat;
  set offeringSeat(int? offeringSeat) => _offeringSeat = offeringSeat;
  List<String>? get carPictures => _carPictures;
  set carPictures(List<String>? carPictures) => _carPictures = carPictures;
  String? get carType => _carType;
  set carType(String? carType) => _carType = carType;

  MyCars.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _regNumber = json['regNumber'];
    _carName = json['carName'];
    _drivingStatus = json['drivingStatus'];
    _isEv = json['isEv'];
    _seatingCapacity = json['seatingCapacity'];
    _offeringSeat = json['offeringSeat'];
    _carPictures = json['carPictures'].cast<String>();
    _carType = json['carType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['regNumber'] = this._regNumber;
    data['carName'] = this._carName;
    data['drivingStatus'] = this._drivingStatus;
    data['isEv'] = this._isEv;
    data['seatingCapacity'] = this._seatingCapacity;
    data['offeringSeat'] = this._offeringSeat;
    data['carPictures'] = this._carPictures;
    data['carType'] = this._carType;
    return data;
  }
}