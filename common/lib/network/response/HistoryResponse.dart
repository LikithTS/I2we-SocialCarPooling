import 'dart:convert';

import 'package:common/network/model/RecentRides.dart';

import '../model/RecentRides.dart';
import '../model/UpcomingRides.dart';


HistoryResponse historyResponseFromJson(String str) =>
    HistoryResponse.fromJson(json.decode(str));

String historyResponseToJson(HistoryResponse data) => json.encode(data.toJson());

class HistoryResponse {
  List<RecentRides>? _asDriver;
  List<UpcomingRides>? _asPassenger;

  List<RecentRides>? get asDriver => _asDriver;
  List<UpcomingRides>? get asPassenger => _asPassenger;

  HistoryResponse({
    List<RecentRides>? asDriver,
    List<UpcomingRides>? asPassenger,
  }) {
    _asDriver = asDriver;
    _asPassenger = asPassenger;
  }

  HistoryResponse.fromJson(dynamic json) {
    if (json['asDriver'] != null) {
      _asDriver = [];
      json['asDriver'].forEach((v) {
        _asDriver?.add(RecentRides.fromJson(v));
      });
    }
    if (json['asPassenger'] != null) {
      _asPassenger = [];
      json['asPassenger'].forEach((v) {
        _asPassenger?.add(UpcomingRides.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_asDriver != null) {
      map['asDriver'] = _asDriver?.map((v) => v.toJson()).toList();
    }
    if (_asPassenger != null) {
      map['asPassenger'] = _asPassenger?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
