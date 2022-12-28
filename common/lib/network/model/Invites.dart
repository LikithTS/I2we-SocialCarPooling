import 'package:common/network/model/Driver.dart';
import 'package:common/network/model/Passenger.dart';

class Invites {
  String? id;
  String? asPassengerId;
  String? asDriverId;
  String? type;
  AsDriver? asDriver;
  AsPassenger? asPassenger;

  Invites(
      {this.id, this.asPassengerId, this.asDriverId, this.type, this.asDriver});

  Invites.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    asPassengerId = json['asPassengerId'];
    asDriverId = json['asDriverId'];
    type = json['type'];
    asDriver = json['asDriver'] != null
        ? new AsDriver.fromJson(json['asDriver'])
        : null;
    asPassenger = json['asPassenger'] != null
        ? new AsPassenger.fromJson(json['asPassenger'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['asPassengerId'] = this.asPassengerId;
    data['asDriverId'] = this.asDriverId;
    data['type'] = this.type;
    if (this.asDriver != null) {
      data['asDriver'] = this.asDriver!.toJson();
    }
    if (this.asPassenger != null) {
      data['asPassenger'] = this.asPassenger!.toJson();
    }
    return data;
  }
}