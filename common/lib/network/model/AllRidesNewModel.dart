import 'package:common/network/model/Passengers.dart';

import 'Drivers.dart';

class AllRidesNewModel {
  AllRidesNewModel({
      this.drivers,
      this.passengers,
      this.count,});

  AllRidesNewModel.fromJson(dynamic json) {
    if (json['drivers'] != null) {
      drivers = [];
      json['drivers'].forEach((v) {
        drivers!.add(Drivers.fromJson(v));
      });
    }
    if (json['passengers'] != null) {
      passengers = [];
      json['passengers'].forEach((v) {
        passengers!.add(Passengers.fromJson(v));
      });
    }
    count = json['count'];
  }
  List<Drivers>? drivers;
  List<Passengers>? passengers;
  int? count;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (drivers != null) {
      map['drivers'] = drivers!.map((v) => v.toJson()).toList();
    }
    if (passengers != null) {
      map['passengers'] = passengers!.map((v) => v.toJson()).toList();
    }
    map['count'] = count;
    return map;
  }

}