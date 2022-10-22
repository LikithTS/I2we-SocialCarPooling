
class CarDetails {
  String? id;
  String? regNumber;
  String? carName;
  bool? drivingStatus;
  bool? isEv;
  int? seatingCapacity;
  int? offeringSeat;
  List<String>? carPictures;
  String? carType;

  CarDetails(
      {this.id,
        this.regNumber,
        this.carName,
        this.drivingStatus,
        this.isEv,
        this.seatingCapacity,
        this.offeringSeat,
        this.carPictures,
        this.carType});

  CarDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    regNumber = json['regNumber'];
    carName = json['carName'];
    drivingStatus = json['drivingStatus'];
    isEv = json['isEv'];
    seatingCapacity = json['seatingCapacity'];
    offeringSeat = json['offeringSeat'];
    carPictures = json['carPictures'].cast<String>();
    carType = json['carType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['regNumber'] = this.regNumber;
    data['carName'] = this.carName;
    data['drivingStatus'] = this.drivingStatus;
    data['isEv'] = this.isEv;
    data['seatingCapacity'] = this.seatingCapacity;
    data['offeringSeat'] = this.offeringSeat;
    data['carPictures'] = this.carPictures;
    data['carType'] = this.carType;
    return data;
  }
}