import 'package:common/model/steps.dart';

import 'distance.dart';
import 'northeast.dart';

class Legs {
  Distance? distance;
  Distance? duration;
  String? endAddress;
  Northeast? endLocation;
  String? startAddress;
  Northeast? startLocation;
  List<Steps>? steps;

  Legs(
      {this.distance,
      this.duration,
      this.endAddress,
      this.endLocation,
      this.startAddress,
      this.startLocation,
      this.steps});

  Legs.fromJson(Map<String, dynamic> json) {
    distance = json['distance'] != null
        ? new Distance.fromJson(json['distance'])
        : null;
    duration = json['duration'] != null
        ? new Distance.fromJson(json['duration'])
        : null;
    endAddress = json['end_address'];
    endLocation = json['end_location'] != null
        ? new Northeast.fromJson(json['end_location'])
        : null;
    startAddress = json['start_address'];
    startLocation = json['start_location'] != null
        ? new Northeast.fromJson(json['start_location'])
        : null;
    if (json['steps'] != null) {
      steps = <Steps>[];
      json['steps'].forEach((v) {
        steps!.add(new Steps.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.distance != null) {
      data['distance'] = this.distance!.toJson();
    }
    if (this.duration != null) {
      data['duration'] = this.duration!.toJson();
    }
    data['end_address'] = this.endAddress;
    if (this.endLocation != null) {
      data['end_location'] = this.endLocation!.toJson();
    }
    data['start_address'] = this.startAddress;
    if (this.startLocation != null) {
      data['start_location'] = this.startLocation!.toJson();
    }
    if (this.steps != null) {
      data['steps'] = this.steps!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
