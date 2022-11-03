

import 'package:socialcarpooling/model/distance.dart';
import 'package:socialcarpooling/model/northeast.dart';
import 'package:socialcarpooling/model/polylinePointsData.dart';

class Steps {
  Distance? distance;
  Distance? duration;
  Northeast? endLocation;
  String? htmlInstructions;
  PolylinePointsData? polyline;
  Northeast? startLocation;
  String? travelMode;
  String? maneuver;

  Steps(
      {this.distance,
        this.duration,
        this.endLocation,
        this.htmlInstructions,
        this.polyline,
        this.startLocation,
        this.travelMode,
        this.maneuver});

  Steps.fromJson(Map<String, dynamic> json) {
    distance = json['distance'] != null
        ? new Distance.fromJson(json['distance'])
        : null;
    duration = json['duration'] != null
        ? new Distance.fromJson(json['duration'])
        : null;
    endLocation = json['end_location'] != null
        ? new Northeast.fromJson(json['end_location'])
        : null;
    htmlInstructions = json['html_instructions'];
    polyline = json['polyline'] != null
        ? new PolylinePointsData.fromJson(json['polyline'])
        : null;
    startLocation = json['start_location'] != null
        ? new Northeast.fromJson(json['start_location'])
        : null;
    travelMode = json['travel_mode'];
    maneuver = json['maneuver'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.distance != null) {
      data['distance'] = this.distance!.toJson();
    }
    if (this.duration != null) {
      data['duration'] = this.duration!.toJson();
    }
    if (this.endLocation != null) {
      data['end_location'] = this.endLocation!.toJson();
    }
    data['html_instructions'] = this.htmlInstructions;
    if (this.polyline != null) {
      data['polyline'] = this.polyline!.toJson();
    }
    if (this.startLocation != null) {
      data['start_location'] = this.startLocation!.toJson();
    }
    data['travel_mode'] = this.travelMode;
    data['maneuver'] = this.maneuver;
    return data;
  }
}