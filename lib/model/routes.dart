

import 'package:socialcarpooling/model/bounds.dart';
import 'package:socialcarpooling/model/legs.dart';
import 'package:socialcarpooling/model/polylinePointsData.dart';

class Routes {
  Bounds? bounds;
  List<Legs>? legs;
  PolylinePointsData? overviewPolyline;
  String? summary;
  List<Null>? warnings;

  Routes(
      {this.bounds,
        this.legs,
        this.overviewPolyline,
        this.summary,
        this.warnings});

  Routes.fromJson(Map<String, dynamic> json) {
    bounds =
    json['bounds'] != null ? new Bounds.fromJson(json['bounds']) : null;
    if (json['legs'] != null) {
      legs = <Legs>[];
      json['legs'].forEach((v) {
        legs!.add(new Legs.fromJson(v));
      });
    }
    overviewPolyline = json['overview_polyline'] != null
        ? new PolylinePointsData.fromJson(json['overview_polyline'])
        : null;
    summary = json['summary'];
    /* if (json['warnings'] != null) {
      warnings = <Null>[];
      json['warnings'].forEach((v) {
        warnings!.add(Null.fromJson(v));
      });
    }*/
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.bounds != null) {
      data['bounds'] = this.bounds!.toJson();
    }
    if (this.legs != null) {
      data['legs'] = this.legs!.map((v) => v.toJson()).toList();
    }
    if (this.overviewPolyline != null) {
      data['overview_polyline'] = this.overviewPolyline!.toJson();
    }
    data['summary'] = this.summary;
    /* if (this.warnings != null) {
      data['warnings'] = this.warnings!.map((v) => v.toJson()).toList();
    }*/
    return data;
  }
}