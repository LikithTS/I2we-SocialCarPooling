import 'package:socialcarpooling/model/geocodedWayPoints.dart';
import 'package:socialcarpooling/model/routes.dart';

class Direction {
  List<GeocodedWaypoints>? geocodedWaypoints;
  List<Routes>? routes;
  String? status;

  Direction({this.geocodedWaypoints, this.routes, this.status});

  Direction.fromJson(Map<String, dynamic> json) {
    if (json['geocoded_waypoints'] != null) {
      geocodedWaypoints = <GeocodedWaypoints>[];
      json['geocoded_waypoints'].forEach((v) {
        geocodedWaypoints!.add(new GeocodedWaypoints.fromJson(v));
      });
    }
    if (json['routes'] != null) {
      routes = <Routes>[];
      json['routes'].forEach((v) {
        routes!.add(new Routes.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.geocodedWaypoints != null) {
      data['geocoded_waypoints'] =
          this.geocodedWaypoints!.map((v) => v.toJson()).toList();
    }
    if (this.routes != null) {
      data['routes'] = this.routes!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}